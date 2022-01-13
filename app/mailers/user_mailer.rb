class UserMailer < ApplicationMailer
  default from: 'support@sparkpostbox.com'
  layout 'mailer'

  def send_welcome_email(user)
    data = {
      template_id: 'my-first-email',
      substitution_data: {
        name: user.first_name
      }
    }

    mail(to: user.email, sparkpost_data: data) do |format|
      format.text { render plain: 'OK' }
    end
  end
end
