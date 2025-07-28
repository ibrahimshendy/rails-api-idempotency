require 'rails_helper'

RSpec.describe 'Posts Api', type: :request do

  describe 'GET /api/v1/posts' do

    before do
      create_list(:post, 3) # Creates 3 posts in DB
    end

    it "Retrieves all posts" do
      get '/api/v1/posts', headers: { 'ACCEPT' => 'application/json' }
      expect(response).to have_http_status(:ok)

      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe 'GET /api/v1/posts/:id' do
    let(:post) { create(:post) }

    it 'Retrieves a post' do
      get "/api/v1/posts/#{post.id}", headers: { 'ACCEPT' => 'application/json' }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /api/v1/posts' do
    let(:valid_params) do
      {
        post: {
          title: "Test a post title",
          description: "Test a post description"
        }
      }
    end

    it 'Creates a post' do
      post '/api/v1/posts', params: valid_params, headers: {
        'ACCEPT' => 'application/json',
        "Idempotency-Key" => SecureRandom.uuid
      }

      expect(response).to have_http_status(:created)

      body = JSON.parse(response.body)
      expect(body['title']).to eq('Test a post title')
    end
  end

  describe 'PUT /api/v1/posts/:id' do
    let(:post) {create(:post)}

    let(:valid_params) do
      {
        post: {
          title: "Edit post title",
          description: Faker::Lorem.paragraph
        }
      }
    end

    it 'Updates a post' do
      put "/api/v1/posts/#{post.id}", params: valid_params, headers: {
        'ACCEPT' => 'application/json',
      }

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body['title']).to eq("Edit post title")
    end
  end

  describe 'DELETE /api/v1/posts/:id' do
    let(:post) {create(:post)}

    it 'Deletes a post' do
      delete "/api/v1/posts/#{post.id}", headers: { 'ACCEPT' => 'application/json' }
      expect(response).to have_http_status(:no_content)
    end
  end
end