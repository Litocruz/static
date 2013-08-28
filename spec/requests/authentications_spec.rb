require 'spec_helper'

describe "Authentications" do
  subject {page}

  describe "signin page" do
    before {visit signin_path}
    it{should have_selector('h1',text:'Sign in')}
    it{should have_selector('title',text:'Sign in')}
  end

  describe "signin" do
    before {visit signin_path}

    describe "with invalid information" do
      before {click_button "Sign in"}
      it {should have_selector('title', text: 'Sign in')}
      it {should have_selector('div.alert.alert-error', content: 'Invalid')}

      describe "after visiting another page" do
        before {click_link "Home"} 
        it {should_not have_selector('div.alert.alert-error')}
      end
    end

    describe "with valid information" do
      let(:user){FactoryGirl.create(:user)}
      #helper spec/support/utilities
      before{sign_in user}

      it {should have_selector('title', text: user.name)}
      it {should have_link('Profile', href: user_path(user))}
      it {should have_link('Settings', href: edit_user_path(user))}
      it {should have_link('Sign out', href: signout_path)}
      it {should_not have_link('Sign in', href: signin_path)}
    end
  end # close signin

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) {FactoryGirl.create(:user)}

      describe "visiting the edit page" do
        before {visit edit_user_path(user)}
        it { should have_selector('title', content: 'Sign in')}
      end

      #visiting the edit page only tests the authorization for the edit action, not for update.
      #the only way to test the authorization for the update action is to issue a direct request.
      describe "submiting to the update action" do
        before { put user_path(user)}
        #When using methods to issue HTTP requests, we get access to the low-level response object.
        #Unlike the Capybara page object, response lets us test for the server response itself,
        #in this case verifying that the update action responds by redirecting to the signin page
        specify {response.should redirect_to(signin_path) }
      end

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email", with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end
        describe "after signin in" do
          it "should render the desired protected page" do
            page.should have_selector('title', text: 'Edit user')
          end

          describe "when signing in again" do
            before do
              visit signin_path
              fill_in "Email", with: user.email
              fill_in "Password", with: user.password
              click_button "Sign in"
            end
            it "should render the default (profile) page" do
              page.should have_selector('title', text: user.name)
            end
          end
        end
      end

      describe "in the Users controller" do
        describe "visiting the User index" do
          before {visit users_path}
          it {should have_selector('title', text: 'Sign in')}
        end
      end
    end # close "for non-signed-in users"

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user }
      describe "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_selector('title', text: full_title('Edit user')) }
      end
      describe "submitting a PUT request to the Users#update action" do
        before { put user_path(wrong_user) }
        specify { response.should redirect_to(root_path) }
      end
    end # close "as wrong user"

    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user)}
      let(:non_admin) { FactoryGirl.create(:user)}

      before { sign_in non_admin}

      describe "submitting a DELETE request to the User#destroy action" do
        before { delete user_path(user)}
        specify {response.should redirect_to(root_path)}
      end
    end

  end # close "authorization" 
end # close "authentication"
