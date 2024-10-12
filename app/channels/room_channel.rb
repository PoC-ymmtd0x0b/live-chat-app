class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    user = User.find_by(email: data['email'])

    if message = Message.create(content: data['message'], user_id: user.id)
      ActionCable.server.broadcast 'room_chat', { message: data['message'], name: user.name, create_at: message.created_at }
    end
  end
end
