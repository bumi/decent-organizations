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
      expect(assigns(:posts)).to contain_exactly(posts[0], posts[1], posts[2])
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'renders the edit template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'GET #add' do
    it 'returns http success' do
      get :add
      expect(response).to have_http_status(:success)
    end

    it 'renders the add template' do
      get :add
      expect(response).to render_template('add')
    end
  end

  describe 'GET #edit' do
    let!(:post) { FactoryBot.create(:post_with_categories) }

    it 'returns http success' do
      get :edit, params: { 'id': post.id }
      expect(response).to have_http_status(:success)
    end

    it 'renders the edit template' do
      get :edit, params: { 'id': post.id }
      expect(response).to render_template('edit')
    end

    it 'assigns the correct post' do
      get :edit, params: { 'id': post.id }
      expect(assigns(:post)).to eq(post)
    end
  end

  describe '#create' do
    it 'saves a valid post' do
      post_params = FactoryBot.attributes_for(:post)
      post_params[:category_ids] = [FactoryBot.create(:category).id]
      expect { post :create, params: { post: post_params } }.to change(Post, :count).by(1)
    end

    it 'does not save an invalid post' do
      post_params = FactoryBot.build(:post)
      expect { post :create, params: { post: post_params } }.to raise_error(ActionController::ParameterMissing)
    end

    it 'does not save a post with a non-existent category' do
      post_params = FactoryBot.attributes_for(:post)
      post_params[:category_ids] = ['asd', 9999]
      expect { post :create, params: { post: post_params } }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe '#update' do 
    let(:post) {FactoryBot.create(:post_with_categories)}
    let(:post_attributes) { post.attributes }

    before do
      post_attributes['category_ids'] = post.categories.map(&:id)
    end

    it 'saves a valid post' do
      new_title = "A changed title for an existing record"
      post_attributes['title'] = new_title
      patch :update, params: { id: post.id, post: post_attributes }
      post.reload
      expect(post.title).to eq(new_title)
    end
  end

  describe '#autofill' do
    it 'redirects to /new when there is no url provided' do
      post :autofill, params: { url: '' }
      expect(response).to redirect_to(new_post_path)
    end

    it 'redirects to /new when the provided url is not readable' do
      post :autofill, params: { url: 'asdf' }
      expect(response).to redirect_to(new_post_path)
    end

    it 'redirects to new when a valid url is provided' do
      post :autofill, params: { url: 'https://google.de' }
      expect(response).to render_template('new')
    end

    it 'prefills the post variable when a valid url is provided' do
      post :autofill, params: { url: 'https://google.de' }
      expect(assigns(:post).title).not_to be_nil
    end
  end

end
