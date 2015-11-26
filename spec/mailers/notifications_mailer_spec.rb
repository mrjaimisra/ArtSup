require 'rails_helper'

RSpec.describe NotificationsMailer, type: :mailer do
  describe 'wishlist item sent to artist' do
    let(:mail) {
      NotificationsMailer.contact(
          name: "ArtSup",
          email: "jai@artsup.com",
          message: "Hello!",
          artist: "Jai",
          street_address: "1223 street",
          city: "Devner",
          state: "CO",
          zip_code: 00000
      )
    }

    it 'renders the subject' do
      expect(mail.subject).to eql('Message from ArtSup')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql(['jai@artsup.com'])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['admin@ArtSup.com'])
    end
  end

  describe 'wishlist item sent to supporter' do
    let(:mail) {
      NotificationsMailer.confirm(
          name: "ArtSup",
          email: "jai@artsup.com",
          message: "Hello!",
          artist: "Jai",
          street_address: "1223 street",
          city: "Devner",
          state: "CO",
          zip_code: 00000
      )
    }

    it 'renders the subject' do
      expect(mail.subject).to eql('Message from ArtSup')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql(['jai@artsup.com'])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['admin@ArtSup.com'])
    end
  end
end