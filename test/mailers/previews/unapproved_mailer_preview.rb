# Preview all emails at http://localhost:3000/rails/mailers/unapproved_mailer
class UnapprovedMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/unapproved_mailer/user_approved
  def user_approved
    UnapprovedMailer.user_approved
  end

end
