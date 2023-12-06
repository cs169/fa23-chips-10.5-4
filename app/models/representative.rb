# frozen_string_literal: true

# comment test
require 'open-uri'

require 'net/http'

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

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

    rep = Representative.find_or_initialize_by(name: official.name)
    update_representative_info(rep, {
                                 ocdid:           ocdid,
                                 title:           title,
                                 contact_address: contact_address,
                                 political_party: political_party,
                                 photo:           photo
                               })

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

  def self.update_representative_info(rep, info)
    info.each do |attribute, value|
      rep[attribute] ||= value if rep[attribute].blank? || rep[attribute].nil?
    end
  end
end
