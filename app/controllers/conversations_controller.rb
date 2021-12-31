class ConversationsController < ApplicationController
  before_action :authenticate_request!

  def index
    @conversations = current_user!.conversations.page(params[:page]).per(params[:per_page])
    
    @conversations.map do |item|
      @two_way = Conversation.where(sender_id: [item.sender_id, item.recipient_id], recipient_id: [item.sender_id, item.recipient_id])
      @messages = @two_way[0].messages.or(@two_way[1].messages)

      if @messages.present?
        item.last_message_type = Conversation.find(@messages.order(created_at: :desc).pluck(:conversation_id).first).sender_id == current_user!.id.to_i ? 'outgoing' : 'incoming'
      end

      item.last_message = @messages.order(created_at: :desc).pluck(:content).first
      item.is_read = @messages.order(created_at: :desc).pluck(:is_read).first
      item.total_unread = @messages && @messages.where(is_read: [nil, false]).count
      item.created_at = @messages.order(created_at: :desc).pluck(:created_at).first
    end

    render json: CommonRepresenter.new(data: ConversationRepresenter.new(@conversations).as_json(true), meta: [@conversations.current_page, @conversations.limit_value, @conversations.total_pages, @conversations.total_count]).as_json
  rescue StandardError => e; render json: CommonRepresenter.new(code: 400, message: e.to_s).as_json, status: :bad_request
  end
end
