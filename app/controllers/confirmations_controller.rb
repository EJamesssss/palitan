class ConfirmationsController < Devise::ConfirmationsController
    private
    def after_confirmation_path_for(resource_name, resource)
        sign_in(resource)
        dashboards_path
    end
end