class AuthenticationController < ApplicationController
  class AuthenticateError < StandardError; end

  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  rescue_from AuthenticateError, with: :handle_unauthenticated

  def create
    if user
      raise AuthenticateError unless user.authenticate(params.require(:password))

      render json: CommonRepresenter.new(data: UserRepresenter.new(user).as_json, code: 201).as_json, status: :created
    else
      render json: CommonRepresenter.new(code: 401, message: 'No such user').as_json, status: :unauthorized
    end
  end

  private

  def user
    @user ||= User.find_by(username: params.require(:username))
  end
end
