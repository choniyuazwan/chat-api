class UserRepresenter
  def initialize(data)
    @data = data
  end
  
  def as_json
    {
        id: data.id,
        username: data.username,
        token: AuthenticationTokenService.call(data.id),
        fullname: data.fullname
    }
  end
  
  private
  attr_reader :data
end