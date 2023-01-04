class Public::ChatsController < ApplicationController
  before_action :ensure_correct_user, only: [:show, :index]

  def show
    @user = User.find(params[:id])
    rooms = current_user.user_rooms.pluck(:room_id)
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)
    if user_rooms.nil?
      @room = Room.new
      @room.save
      UserRoom.create(user_id: @user.id, room_id: @room.id)
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
    else
      @room = user_rooms.room
    end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end

  def index
    @user_rooms = UserRoom.all
  end

  def create
    @chat = current_user.chats.new(chat_params)
    @chat.save
    @chats = @chat.room.chats
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
  
  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

end
