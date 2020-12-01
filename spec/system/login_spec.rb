feature "the login process", type: :feature, driver: :real_firefox do
  scenario "logging in" do
    @user = create(:user, :with_organisation, :with_2fa)

    visit "/users/sign_in"

    within("#new_user") do
      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
    end
    click_button "Continue"

    expect(page).to have_content "Please enter your 6 digit two factor authentication code."
  end
end
