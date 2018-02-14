require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "assigns @posts" do
      posts = FactoryBot.create_list(:post_with_categories, 3)
      get :index
      expect(assigns(:posts)).to eq(posts)
    end

    it "assigns @categories" do 
      categories = FactoryBot.create_list(:category, 4)
      get :index
      expect(assigns(:categories)).to eq(categories)
    end
  end

end
