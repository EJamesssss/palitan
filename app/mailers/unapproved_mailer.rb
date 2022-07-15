class UnapprovedMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.unapproved_mailer.user_approved.subject
  #
  def user_approved
    @greeting = "Hi"
    @user = params[:user]

    # mail to: @user.email,
    # subject: "Welcome to palitan.com!"

    mail(from: "welcome@palitan.com", to: @user.email,
          subject: "Welcom to palitan.com!")
  end
end
