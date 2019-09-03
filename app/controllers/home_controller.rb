class HomeController < ApplicationController
  def index
    return redirect_to super_admin_organisations_path if super_admin?

    redirect_to(new_organisation_setup_instructions_path)
  end
end
