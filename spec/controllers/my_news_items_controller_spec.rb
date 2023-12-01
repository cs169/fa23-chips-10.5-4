# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MyNewsItemsController, type: :controller do
  describe 'actions' do
    it { is_expected.to respond_to(:new) }
    it { is_expected.to respond_to(:edit) }
    it { is_expected.to respond_to(:create) }
    it { is_expected.to respond_to(:update) }
    it { is_expected.to respond_to(:destroy) }
  end
end
