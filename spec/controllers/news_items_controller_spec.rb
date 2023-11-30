# spec/controllers/news_items_controller_spec.rb

require 'rails_helper'

RSpec.describe NewsItemsController, type: :controller do
  describe 'before actions' do
  end

  describe 'actions' do
    it { is_expected.to respond_to(:index) }
    it { is_expected.to respond_to(:show) }
  end

  describe 'private methods' do
  end
end
