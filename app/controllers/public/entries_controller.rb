class Public::EntriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @currentEntries = current_user.entries
    myRoomIds = []

    @currentEntries.each do |entry|
      myRoomIds << entry.room.id
    end

    @anotherEntries = Entry.where(room_id: myRoomIds).where('user_id != ?', current_user.id)
  end
end
