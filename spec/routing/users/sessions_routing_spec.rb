require "rails_helper"

RSpec.describe Users::SessionsController, type: :routing do
  describe "Users::Sessions" do
    it "routes to #new" do
      expect(:get => "/signin").to route_to("users/sessions#new")
    end

    it "routes to #create" do
      expect(:post => "/signin").to route_to("users/sessions#create")
    end

    it "routes to #destroy" do
      expect(:delete => "/signout").to route_to("users/sessions#destroy")
    end
  end
end
