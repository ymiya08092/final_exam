class MailerMailer < ApplicationMailer
    def create_user(user)
      @user = user
      @url  = 'http://example.com/login'
      mail to: @user.email, subject: "ご登録ありがとうございます"
    end
     def create_picture(picture)
       @picture = picture.user.email
       @content = picture.content
       mail to: @picture, subject: "投稿しました"
     end
end

