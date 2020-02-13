class OverviewController < ApplicationController
  def index
    @ips = current_organisation.ips
    @locations = current_organisation.locations
    @team_members = current_organisation.users
    @current_org_signed_mou = current_organisation.has_signed_mou?
  end
end
