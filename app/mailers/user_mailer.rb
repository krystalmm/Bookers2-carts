class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'
  
  def thanks(user)
    @user = user
    mail to: @user.email, subject: '会員登録が完了しました'
  end
  
  # ———————————————dailyメール———————————————
  def daily_mail(user)
    @user = user
    mail to: @user.email, subject: 'Bookers2s Daily Mail'
  end
  # ———————————dailyメールここまで———————————
end
