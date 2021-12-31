class ConversationRepresenter
  def initialize(data)
    @data = data
  end
  
  def as_json(list = false)
    list ? data.map do |item| {
        id: item.id,
        recipient: item.recipient.fullname,
        last_message: item.last_message,
        last_message_type: item.last_message_type,
        is_read: item.is_read,
        total_unread: item.total_unread,
        created_at: item.created_at
    } end : {
        id: data.id,
        recipient: data.recipient.fullname,
        last_message: data.last_message,
        last_message_type: data.last_message_type,
        is_read: data.is_read,
        total_unread: data.total_unread,
        created_at: data.created_at
    }
  end
  
  private
  attr_reader :data
end