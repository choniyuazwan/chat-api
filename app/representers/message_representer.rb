class MessageRepresenter
  def initialize(data)
    @data = data
  end
  
  def as_json(list = false)
    list ? data.map do |item| {
        id: item.id,
        conversation_id: item.conversation_id,
        content: item.content,
        is_read: item.is_read,
    } end : {
        id: data.id,
        conversation_id: data.conversation_id,
        content: data.content,
        is_read: data.is_read,
    }
  end
  
  private
  attr_reader :data
end