class NotificationsMailer < ApplicationMailer
  def contact(email_params)
    @message = email_params[:message]
    @artist = email_params[:artist]
    @name = email_params[:name]
    @street_address = email_params[:street_address]
    @city = email_params[:city]
    @state = email_params[:state]
    @zip_code = email_params[:zip_code]

    mail(
        to: email_params[:email],
        subject: "Message from #{email_params[:name]}"
    )
  end
end
