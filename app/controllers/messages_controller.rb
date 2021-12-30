class MessagesController < ApplicationController
  before_action :authenticate_request!

  def show
    if current_user!.id.to_i == params[:id].to_i
      return render json: CommonRepresenter.new(code: 422, message: "can't have a conversation with yourself").as_json, status: :unprocessable_entity
    end
    
    @conversations = current_user!.conversations.find_by(recipient_id: params[:id])
    if @conversations == nil
      return render json: CommonRepresenter.new(code: 422, message: "conversation not available").as_json, status: :unprocessable_entity
    end
    
    @messages = @conversations.messages.order(params[:order]).page(params[:page]).per(params[:per_page])
    render json: CommonRepresenter.new(data: MessageRepresenter.new(@messages).as_json(true), meta: [@messages.current_page, @messages.limit_value, @messages.total_pages, @messages.total_count]).as_json
  rescue StandardError => e; render json: CommonRepresenter.new(code: 400, message: e.to_s).as_json, status: :bad_request
  end

  def create
    if current_user!.id == message_params[:recipient_id]
      return render json: CommonRepresenter.new(code: 422, message: "can't have a message with yourself").as_json, status: :unprocessable_entity
    end
    
    @conversation = current_user!.conversations.find_by(recipient_id: message_params[:recipient_id])
    @message = @conversation.messages.create({content: message_params[:content]})
    
    if @message.save
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
