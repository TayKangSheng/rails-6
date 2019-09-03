require "rails_helper"

RSpec.describe "Users::Registrations" do
  describe "GET /signup" do
    it "renders signin page" do
      get signup_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /signup" do
    context "success" do
      let(:signup_params) do
        {
          name: "user1",
          email: "user1@example.com",
          password: "password1",
          password_confirmation: "password1"
        }
      end

      it "creates a user" do
        expect do
          post signup_path, params: { signup: signup_params }
        end.to change { User.count }.by(1)

        expect(User.last.name).to eq "user1"
      end

      it "redirects user to root_path" do
        expect(
          post signup_path, params: { signup: signup_params }
        ).to redirect_to(root_path)
      end

      it "shows user.registration.confirm_email message" do
        post signup_path, params: { signup: signup_params }

        expect(flash[:notice]).to be_truthy
        expect(flash[:notice]).to eq I18n.t("user.registration.confirm_email")
      end
    end

    context "failure" do
      {
        password_confirmation: [ "user1", "user1@example.com", "password1", "" ],
        password: [ "user1", "user1@example.com", "", "password1" ],
        email: [ "user1", "", "password1", "password1" ],
        name: [ "", "user1@example.com", "password1", "password1" ]
      }.each_pair do | key, fields |
        it "registration fails if #{key} is not provided" do
          expect do
            post signup_path, params: {
              signup: {
                name: fields[0],
                email: fields[1],
                password: fields[2],
                password_confirmation: fields[3]
              }
            }
          end.not_to change { User.count }
        end
      end
    end # context "failure"
  end # describe POST /signup
end # describe Users::Registration
