class MessagesController < ApplicationController
  before_action :find_user, only: [:create, :index]
  respond_to :js, only: [:create, :index, :read]

  def create
    @message = Message.new(message_params)
    @message.sender = current_user

    if @user == current_user
      @message.recipient = current_user.adviser.user
      @message.save
    else
      @message.recipient = @user
      @message.save
      end
    end
  
  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    end


  def index
    @messages = Message.all
  end

  def read
    @messages = Message.where(recipient: current_user, read_at: nil)
    @messages.each do |message|
      message.read_at = Time.now
      message.save
    end
    head :ok
  end

  private
    
    def find_user
      if params[:recipient_id].present?
        @user = User.find(params[:recipient_id])
      else
        @user = User.find(params[:user_id])
    end
  end

    
    def message_params
      params.require(:message).permit(:content, :user, :recipient_id)
    end
  end

