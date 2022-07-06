class ApplicationController < ActionController::Base

    Client = IEX::Api::Client.new

    private
        def after_sign_in_path_for(resource)
            home_index_path
        end

end
