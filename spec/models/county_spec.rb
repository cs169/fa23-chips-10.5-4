# frozen_string_literal: true

require 'spec_helper'

RSpec.describe County, type: :model do
  describe 'methods' do
    it { is_expected.to respond_to(:std_fips_code) }
  end
end
