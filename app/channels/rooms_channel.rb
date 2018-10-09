class RoomsChannel < ApplicationCable::Channel
  def subscribed
    stream_for "rooms_channel"
  end

  def speak(data)
    new_message = Message.create(body: data['body'], room_id: data['room_id'], user_id: data['user_id'])
    RoomsChannel.broadcast_to('rooms_channel', new_message)
  end

  def speakRoom(data) 
    new_room = Room.create(title: data['title'], is_private: data['is_private'], owner_id: data['owner_id'], is_dm: data['is_dm'])
    if new_room.is_private || new_room.is_dm
      data['user_ids'].each do |user_id|
        RoomMembership.create(user_id: user_id, room_id: new_room.id)
      end
    else
      User.all.each do |user|
        RoomMembership.create(user_id: user.id, room_id: new_room.id)
      end
    end
    RoomsChannel.broadcast_to('rooms_channel', new_room)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
