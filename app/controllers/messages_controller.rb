class MessagesController < ApplicationController
  before_action :authenticate_request!

  def show
    if current_user!.id.to_i == params[:id].to_i
      return render json: CommonRepresenter.new(code: 422, message: "can't have a conversation with yourself").as_json, status: :unprocessable_entity
    end
    @conversations = Conversation.where(sender_id: [current_user!.id, params[:id]], recipient_id: [current_user!.id, params[:id]])
    return render json: CommonRepresenter.new(code: 422, message: "conversation not available").as_json, status: :unprocessable_entity if @conversations.blank?

    @messages = @conversations[0].messages.or(@conversations[1].messages)
    return render json: CommonRepresenter.new(code: 422, message: "message is empty").as_json, status: :unprocessable_entity if @messages == nil
    
    Conversation.find_by(sender_id: params[:id], recipient_id: current_user!.id).messages.update(is_read: true)
    @messages = @messages.page(params[:page]).per(params[:per_page])
    @messages.map{|item| item.type = item.conversation.sender_id == current_user!.id.to_i ? 'outgoing' : 'incoming'}
    
    render json: CommonRepresenter.new(data: MessageRepresenter.new(@messages).as_json(true), meta: [@messages.current_page, @messages.limit_value, @messages.total_pages, @messages.total_count]).as_json
  rescue StandardError => e; render json: CommonRepresenter.new(code: 400, message: e.to_s).as_json, status: :bad_request
  end

  def create
    if current_user!.id == message_params[:recipient_id]
      return render json: CommonRepresenter.new(code: 422, message: "can't have a message with yourself").as_json, status: :unprocessable_entity
    end
    
    @conversation = current_user!.conversations.find_by(recipient_id: message_params[:recipient_id])
    
    if @conversation
      @message = @conversation.messages.create({content: message_params[:content], is_read: false})
    else
      @conversation = current_user!.conversations.create({recipient_id: message_params[:recipient_id]})
      if @conversation.save
        @user = User.find(message_params[:recipient_id])
        @conversation2 = @user.conversations.create({recipient_id: current_user!.id})
        if @conversation2.save
          @message = @conversation.messages.create({content: message_params[:content], is_read: false})
        else
          return render json: CommonRepresenter.new(code: 422, message: @conversation2.errors.full_messages.first).as_json, status: :unprocessable_entity
        end
      else
        return render json: CommonRepresenter.new(code: 422, message: @conversation.errors.full_messages.first).as_json, status: :unprocessable_entity
      end
    end
    
    if @message.save
      @conversation.update(updated_at: @message.created_at)
      @conversation2 = Conversation.where(sender_id: message_params[:recipient_id], recipient_id: current_user!.id)
      @conversation2.update(updated_at: @message.created_at)

      return render json: CommonRepresenter.new(data: MessageRepresenter.new(@message).as_json, code: 201).as_json, status: :created
    end
    render json: CommonRepresenter.new(code: 422, message: @message.errors.full_messages.first).as_json, status: :unprocessable_entity
  rescue StandardError => e; render json: CommonRepresenter.new(code: 400, message: e.to_s).as_json, status: :bad_request
  end

  private

  def message_params
    params.permit(:recipient_id, :content)
  end
end
