require "rails_helper"

RSpec.describe HomeController, type: :request do
  it "shows the home page" do
    get "/"
    expect(response).to have_http_status(:success)
  end
end
