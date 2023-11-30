# spec/controllers/login_controller_spec.rb

require 'rails_helper'

RSpec.describe LoginController, type: :controller do
  describe 'actions' do
    it { is_expected.to respond_to(:login) }
    it { is_expected.to respond_to(:google_oauth2) }
    it { is_expected.to respond_to(:github) }
    it { is_expected.to respond_to(:logout) }
  end

  describe 'private methods' do
  end
end
