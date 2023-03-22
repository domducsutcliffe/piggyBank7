class AuthenticationController < ApplicationController
    def login
        user = User.find_by(username: params[:username])
        if (!user)
            render json: {
                error: "Incorrect username"
            },
             status: :unauthorized
        elsif user.authenticate(params[:password])
            render json: {message: "Successfull login"}
        else
            render json: {message: "Incorrect password"}
        end
    end
end
