class Guestuser::DataGuest

  # guestuserの投稿を削除
  def self.data_reset
    user = User.find_by(email: "guest@example.com")
    user.reviews.destroy_all
    user.works.destroy_all
  end
end