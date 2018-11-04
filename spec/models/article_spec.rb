require 'rails_helper'

RSpec.describe Article, type: :model do
	describe '#validations' do
		it 'should test that the factory is valid' do
			expect(FactoryBot.build :article).to be_valid
		end

		it 'should validate the presence of title' do
			article = FactoryBot.build :article, title: ''
			expect(article).not_to be_valid
			expect(article.errors.messages[:title]).to include("can't be blank")
		end

		it 'should validate the presence of slug' do
			article = FactoryBot.build :article, slug: ''
			expect(article).not_to be_valid
			expect(article.errors.messages[:slug]).to include("can't be blank")
		end
	end

	describe '#show' do
		let(:article) { create :article }
		subject { get :show, params: { id: article.id } }

		it 'should return success response' do
			subject
			expect(response).to have_http_status(:ok)
		end

		it 'should return proper json' do
			subject
			expect(json_data['attributes']).to eq({
				"title" => article.title,
				"content" => article.content,
				"slug" => article.slug
			})
		end
	end
end
