# spec/models/county_spec.rb

require 'rails_helper'

RSpec.describe County, type: :model do
  describe 'associations' do
  end
  describe 'methods' do
    it { is_expected.to respond_to(:std_fips_code) }
  end
end