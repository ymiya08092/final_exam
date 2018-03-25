class MailerMailer < ApplicationMailer
    def create_user(user)
      @user = user
      @url  = 'http://example.com/login'
      mail to: @user.email, subject: "ご登録ありがとうございます"
    end
     ##def create_blog(blog)
     ##@blog.user.name = user_name
     ## @blog.user.email = email
     ##  mail to: @blog.user.email, subject: "ブログを作成しました"
     ##end
end

