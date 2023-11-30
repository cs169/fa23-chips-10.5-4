# spec/models/news_item_spec.rb

require 'rails_helper'

RSpec.describe NewsItem, type: :model do
  describe 'associations' do
  end

  describe 'methods' do
    it { is_expected.to respond_to(:representative) }
    it { is_expected.to respond_to(:ratings) }
  end
end
