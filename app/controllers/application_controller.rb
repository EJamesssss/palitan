class ApplicationController < ActionController::Base

    private
        def after_sign_in_path_for(resource)
            home_index_path
        end

        def iex_resource
            @client = IEX::API::Client.new
        end
end
