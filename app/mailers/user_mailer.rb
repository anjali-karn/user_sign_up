class UserMailer < ApplicationMailer
    def user_login_notification(user)
    
      @user = user
      mail(to: 'neeraj@example.com', subject: 'User Logged In')
    end
    private

    def status_changed_to_approved?
      status_changed? && approved?
    end

 
  def user_approval_notification(user)
    @user = user
    mail(to: @user.email, subject: "Your account has been approved!")
  end
  end
  