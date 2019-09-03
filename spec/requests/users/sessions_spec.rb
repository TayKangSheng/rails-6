require "rails_helper"

RSpec.describe "Users::Session" do
  describe "GET /signin" do
    it "render signin page" do
      get signin_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /signin" do
    let!(:user) { User.create(name: "user1", email: "user1@example.com", password: "password") }

    it "sign in user" do
      post signin_path, params: { signin: { name: "user1", password: "password" } }

      expect(request.env["rack.session"][:user_id]).to eq user.id
      expect(response).to have_http_status(:redirect)
      expect(flash[:notice]).to be_truthy
    end

    it "render signin form with error if sign in fails" do
      post signin_path, params: { signin: { name: "user", password: "password" } }

      expect(request.env["rack.session"][:user_id]).to eq nil
      expect(response).to have_http_status(:success)
      expect(flash[:alert]).to be_truthy
    end
  end

  describe "DELETE /signout" do
    it "signs out user" do
      delete signout_path

      expect(request.env["rack.session"][:user_id]).to eq nil
      expect(response).to have_http_status(:redirect)
      expect(flash[:notice]).to be_truthy
    end
  end
end
