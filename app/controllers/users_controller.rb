class UsersController < ApplicationController
  wrap_parameters :user, include: [:username, :password, :fullname]
  def create
    @user = User.create(user_params)
    if @user.save
      render json: CommonRepresenter.new(data: UserRepresenter.new(@user).as_json, code: 201).as_json, status: :created
    else
      render json: CommonRepresenter.new(code: 422, message: @user.errors.full_messages.first).as_json, status: :unprocessable_entity
    end
  rescue StandardError => e; render json: CommonRepresenter.new(code: 400, message: e.to_s).as_json, status: :bad_request
  end
  
  private

  def user_params
    params.require(:user).permit(:username, :password, :fullname)
  end
end
