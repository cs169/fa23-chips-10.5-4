# spec/controllers/events_controller_spec.rb

require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe 'actions' do
    it { is_expected.to respond_to(:index) }
    it { is_expected.to respond_to(:show) }
  end

  describe 'private methods' do
  end
end
