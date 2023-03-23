class AuthenticationController < ApplicationController
    def login
        user = User.find_by(username: params[:username])
        if (!user)
            render json: {
                error: "Incorrect username"
            },
             status: :unauthorized
        elsif user.authenticate(params[:password])
            secret_key = Rails.application.secrets.secret_key_base[0] 
            token = JWT.encode(user.username, secret_key)

            render json: {token: token}
        else
            render json: {message: "Incorrect password"}
        end
    end
end
