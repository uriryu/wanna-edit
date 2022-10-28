class Public::MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    message = Message.new(message_params)
    message.user_id = current_user.id
    if message.save
      redirect_to room_path(message.room)
    else
      #直前のページへ戻る(redirect_back)
      redirect_back(fallback_location: room_path)
    end
  end

  private

    def message_params
      params.require(:message).permit(:room_id, :body)
    end
end
