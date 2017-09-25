class ContactMailer < ActionMailer::Base
  default to: 'rohinton.kazak@gmail.com'
  def contact_email(name, email, body)
    @name = name
    @email = email
    @body = body
    mail(from: email, "Contact Created" )
  end
end
