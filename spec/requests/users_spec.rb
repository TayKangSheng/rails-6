require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    it "HTTP response 200" do
      get users_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /users/new" do
    it "HTTP response 200" do
      get new_user_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /users" do
    it "creates a new user" do
      user_attributes = { name: "User1", email: "user1@example.com", password: "password1" }
      expect do
        post users_path, params: { user: user_attributes }
      end.to change(User, :count).by(1)
    end

    it "does not creates new user if attributes are not valid" do
      user_attributes = { name: "User1", email: "user1@example.com" }
      expect do
        post users_path, params: { user: user_attributes }
      end.to change(User, :count).by(0)
    end
  end

  describe "PATCH/PUT /users" do
    let!(:user) { User.create(name: "User1", email: "user1@example.com", password: "Password") }

    it "updates a user" do
      put user_path(user.id), params: { user: { id: user.id, name: "User2" } }

      updated_user = User.find(user.id)
      expect(updated_user.name).to eq "User2"
      expect(response).to have_http_status(:redirect)
    end

    it "does not update a user if attributes are not valid" do
      User.create(name: "User2", email: "user2@example.com", password: "Password")

      put user_path(user.id), params: { user: { id: user.id, name: "User2" } }

      updated_user = User.find(user.id)
      expect(updated_user.name).to eq "User1"
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE /user/:id" do
    let!(:user) { User.create(name: "User1", email: "user1@example.com", password: "Password") }

    it "deletes user" do
      expect do
        delete user_path(user.id)
      end.to change(User, :count).by(-1)
    end
  end
end
