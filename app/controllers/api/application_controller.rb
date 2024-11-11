module Api
  class ApplicationController < ActionController::API
    private

    def handle_error(error)
      render json: { message: error.message }, status: :unprocessable_entity
    end

    def authenticate_user
      user = User.where(username: params[:username]).first

      user = create_user! if user.blank?

      if user&.authenticate(params[:password])
        @current_user = user
      else
        render json: { error: "Invalid username or password" }, status: :unauthorized
      end
    end

    def current_user
      @current_user
    end

    def create_user!
      raise Errors::InvalidName.new('invalid username!') if params[:username] == User::ADMIN_NAME

      begin
        User.create!(username: params[:username], password: params[:password])
      end
    end
  end
end
