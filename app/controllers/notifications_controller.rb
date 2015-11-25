class NotificationsController < ApplicationController
  def show
    @user = User.find_by(url: params[:id])
  end

  def create
    @user = User.find_by(name: params[:artist])
    NotificationsMailer.contact(email_params).deliver_now
    NotificationsMailer.confirm(email_params).deliver_now

    ArtistToSupporter.create(artist_id: @user.id, supporter_id: current_user.id)
    redirect_to dashboard_path(current_user.url), notice: 'Email sent.'
    flash[:message] = "Email sent."
  end

  private

  def email_params
    params.permit(:email, :name, :message, :artist, :street_address, :city, :state, :zip_code)
  end
end