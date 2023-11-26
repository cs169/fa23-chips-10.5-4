# frozen_string_literal: true

# comment test
require 'open-uri'

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all
  has_one_attached :photo_attachment

  def self.civic_api_to_representative_params(rep_info)
    representatives = []

    rep_info.officials.each_with_index do |official, index|
      ocdid_temp = ''
      title_temp = ''
      contact_address = ''
      political_party = ''
      photo = ''

      rep_info.offices.each do |office|
        if office.official_indices.include? index
          title_temp = office.name
          ocdid_temp = office.division_id
        end
      end
      # address
      address_parts = []
      if official.address&.first
        street = official.address.first.line1
        city = official.address.first.city
        state = official.address.first.state
        zip = official.address.first.zip

        address_parts = [street, city, state, zip].compact
      end

      contact_address = address_parts.join(', ') unless address_parts.nil?

      # checks official is not nil before assigning values to
      # the temp variables
      political_party = official.party if official.respond_to?(:party)
      photo = official.photo_url if official.respond_to?(:photo_url)

      rep = Representative.find_or_initialize_by(name: official.name, ocdid: ocdid_temp)
      rep.title = title_temp if rep.title.blank? || rep.title.nil?
      rep.contact_address = contact_address if rep.contact_address.blank? || rep.contact_address.nil?
      rep.political_party = political_party if rep.political_party.blank? || rep.political_party.nil?
      rep.photo = photo if rep.photo.blank? || rep.photo.nil?

      if official.respond_to?(:photo_url) && official.photo_url.present?
        begin
          downloaded_image = open(official.photo_url)
          rep.photo_attachment.attach(io: downloaded_image, filename: "#{rep.name.parameterize.underscore}_photo.jpg")
        rescue StandardError => e
          Rails.logger.error("Error attaching photo for #{rep.name}: #{e.message}")
        end
      end

      rep.save
      representatives.push(rep)
    end
    representatives
  end
end
