# spec/models/event_spec.rb

require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'methods' do
    it { is_expected.to respond_to(:county_names_by_id) }
  end
end