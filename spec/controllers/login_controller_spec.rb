# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LoginController, type: :controller do
  describe 'actions' do
    it { is_expected.to respond_to(:login) }
    it { is_expected.to respond_to(:google_oauth2) }
    it { is_expected.to respond_to(:github) }
    it { is_expected.to respond_to(:logout) }
  end
end
