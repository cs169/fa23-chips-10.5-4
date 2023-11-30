# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'methods' do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:auth_provider) }
  end
end
