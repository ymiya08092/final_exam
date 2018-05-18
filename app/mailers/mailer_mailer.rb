class MailerMailer < ApplicationMailer
    def create_user(user)
      @user = user
      @url  = 'http://example.com/login'
      mail to: @user.email, subject: "ご登録ありがとうございます"
    end
     def create_place(picture)
       @place = place.user.email
       mail to: @place, subject: "投稿しました"
     end
end

