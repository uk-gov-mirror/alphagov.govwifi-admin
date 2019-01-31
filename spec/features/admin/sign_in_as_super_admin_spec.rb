describe 'signing in as a super admin' do
  let!(:user) { create(:user, super_admin: true) }

  context 'when visiting the home page' do
    before do
      create(:organisation, name: "Org 2")
      sign_in_user user
      visit root_path
    end

    it 'shows list of signed organisations on the home page' do
      expect(page).to have_content("Org 2")
    end
  end
end
