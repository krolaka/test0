class MessagesController < ApplicationController

  before_action :find_message, only: [:show, :edit]

  def index
    @messages = Message.where(rxuser_id: current_user.id).order(created_at: :desc)
  end

  def show
    @message.mark_as_read if @message.rxuser_id == current_user.id
    @messages_history = Message.get_messages current_user.id, @message.txuser_id
  end

  def load_messages
    @messages = Message.where(rxuser_id: current_user.id).order(created_at: :desc)
    render :_messages, :layout => false
  end

  def new
    @message = Message.new
    @message.txuser_id = params[:rxuser_id]
    @message.rxuser_id = current_user.id
    @messages_history = Message.get_messages current_user.id, params[:rxuser_id]
  end

  def edit
    @message = Message.find(params[:id])
  end

  def update
    @message = Message.new(message_params)
    if current_user.id.to_s != params[:id]
      @message.rxuser_id = params[:id]
      @message.txuser_id = current_user.id
      if @message.save
        flash[:notice] = 'Message sent'
        redirect_to :messages
      else
        render :show
      end
    else
      redirect_to :messages, alert: "You can't send a message yourself"
    end
  end

  def get_message_count
    render json: { count: Message.where(rxuser_id: current_user.id, read: false).count }
  end

  private

  def find_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:id, :message)
  end

end