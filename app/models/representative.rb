# frozen_string_literal: true

# comment test
require 'open-uri'

require 'net/http'

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all
  has_one_attached :photo_attachment

  def self.civic_api_to_representative_params(rep_info)
    representatives = []

    rep_info.officials.each_with_index do |official, index|
      rep = process_representative(official, rep_info.offices, index)
      representatives.push(rep)
    end

    representatives
  end

  def self.process_representative(official, offices, index)
    title, ocdid = find_title_and_ocdid(official, offices, index)
    contact_address = create_contact_address(official)
    political_party, photo = extract_political_info(official)

    rep = Representative.find_or_initialize_by(name: official.name, ocdid: ocdid)
    update_representative_info(rep, {
                                 title:           title,
                                 contact_address: contact_address,
                                 political_party: political_party,
                                 photo:           photo
                               })
    attach_photo(rep, official.photo_url)

    rep.save
    rep
  end

  def self.find_title_and_ocdid(_official, offices, index)
    title_temp = ''
    ocdid_temp = ''

    offices.each do |office|
      if office.official_indices.include?(index)
        title_temp = office.name
        ocdid_temp = office.division_id
      end
    end

    [title_temp, ocdid_temp]
  end

  def self.create_contact_address(official)
    address_parts = []
    if official.address&.first
      address_parts = [
        official.address.first.line1,
        official.address.first.city,
        official.address.first.state,
        official.address.first.zip
      ].compact
    end

    address_parts.join(', ') unless address_parts.empty?
  end

  def self.extract_political_info(official)
    political_party = official.party if official.respond_to?(:party)
    photo = official.photo_url if official.respond_to?(:photo_url)

    [political_party, photo]
  end

  def self.attach_photo(rep, photo_url)
    return if photo_url.blank?

    begin
      uri = URI.parse(photo_url)
      downloaded_image = Net::HTTP.get_response(uri)

      rep.photo_attachment.attach(
        io:       StringIO.new(downloaded_image.body),
        filename: "#{rep.name.parameterize.underscore}_photo.jpg"
      )
    rescue StandardError => e
      Rails.logger.error("Error attaching photo for #{rep.name}: #{e.message}")
    end
  end

  def self.update_representative_info(rep, info)
    info.each do |attribute, value|
      rep[attribute] ||= value if rep[attribute].blank? || rep[attribute].nil?
    end
  end
end
