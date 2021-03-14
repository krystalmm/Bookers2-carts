class Batch::SendUserMail
  def self.send_user_mail
    @users = User.all
    @users.each do |user|
      UserMailer.daily_mail(user).deliver_now
    end
  end
end