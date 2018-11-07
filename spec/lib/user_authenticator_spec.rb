require 'rails_helper'

describe UserAuthenticator do
	describe '#perform' do
		let(:authenticator) { described_class.new('sample_code') }

		subject { authenticator.perform }

		context 'when code is incorrect' do
			let(:error) {
				double("Sawyer::Resource", error: "bad_verification_code")
			}
			
			before do
				allow_any_instance_of(Octokit::Client).to receive(
					:exchange_code_for_token).and_return(error)
			end

			it 'should raise an error' do
				expect{ subject }.to raise_error(
					UserAuthenticator::AuthenticationError
				)
				expect(authenticator.user).to be_nil
			end
		end

		context 'when code is correct' do
			let(:user_data) do
				{
					login: 'jsmith1',
					url: 'http://example.com',
					avatar_url: 'http://exaple.com/avatar',
					name: 'John Smith'
				}
			end

			before do
				allow_any_instance_of(Octokit::Client).to receive(
					:exchange_code_for_token).and_return('validaccesstoken')
				allow_any_instance_of(Octokit::Client).to receive(
					:user).and_return(user_data)
			end

		end
	end
end
