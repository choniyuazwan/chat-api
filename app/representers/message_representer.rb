class MessageRepresenter
  def initialize(data)
    @data = data
  end
  
  def as_json(list = false)
    list ? data.map do |item| {
        id: item.id,
        content: item.content,
        type: item.type,
        is_read: item.is_read,
        created_at: item.created_at
    } end : {
        id: data.id,
        content: data.content,
        type: data.type || 'outgoing',
        is_read: data.is_read,
        created_at: data.created_at
    }
  end
  
  private
  attr_reader :data
end