# spec/models/event_spec.rb

require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'associations' do
  end

  describe 'validations' do
  end

  describe 'delegation' do
  end

  describe 'methods' do
    it { is_expected.to respond_to(:county_names_by_id) }
  end
end
