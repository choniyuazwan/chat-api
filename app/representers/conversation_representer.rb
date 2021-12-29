class ConversationRepresenter
  def initialize(data)
    @data = data
  end
  
  def as_json(list = false)
    list ? data.map do |item| {
        id: item.id,
        sender: item.sender_id,
        recipient: item.recipient_id,
        last_message: 'item.last_message',
        type: 'item.type',
        unread: 'item.unread'
    } end : {
        id: data.id,
        sender: data.sender_id,
        recipient: data.recipient_id,
        last_message: 'data.last_message',
        type: 'data.type',
        unread: 'data.unread'
    }
  end
  
  private
  attr_reader :data
end