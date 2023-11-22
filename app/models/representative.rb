# frozen_string_literal: true

# comment test

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)

    representatives = []

    rep_info.officials.each_with_index do |official, index|
      ocdid_temp = ''
      title_temp = ''
      

      rep_info.offices.each do |office|
        if office.official_indices.include? index
          title_temp = office.name
          ocdid_temp = office.division_id
        end
      end
      
      rep = Representative.find_or_create_by(name: official.name, ocdid: ocdid_temp) do |rep|
        rep.title = title_temp
      end
      representatives.push(rep)
    end
    representatives
  end
end
