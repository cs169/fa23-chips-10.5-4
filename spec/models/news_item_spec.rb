# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewsItem, type: :model do
  describe 'methods' do
    it { is_expected.to respond_to(:representative) }
    it { is_expected.to respond_to(:ratings) }
  end
end
