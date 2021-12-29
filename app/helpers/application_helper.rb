module ApplicationHelper
  def parameter_missing(error)
    render json: CommonRepresenter.new(code: 422, message: error.message).as_json, status: :unprocessable_entity
  end

  def handle_unauthenticated
    render json: CommonRepresenter.new(code: 401, message: 'Incorrect password').as_json, status: :unauthorized
  end
end
