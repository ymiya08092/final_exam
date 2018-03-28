class MailerMailer < ApplicationMailer
    def create_user(user)
      @user = user
      @url  = 'http://example.com/login'
      mail to: @user.email, subject: "ご登録ありがとうございます"
    end
     def create_blog(blog)
       @blog = blog.user.email
       @title = blog.title
       @content = blog.content
       mail to: @blog, subject: "ブログを作成しました"
     end
end

