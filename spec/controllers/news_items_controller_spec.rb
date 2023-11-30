# frozen_string_literal: true

require 'spec_helper'

RSpec.describe NewsItemsController, type: :controller do
  describe 'actions' do
    it { is_expected.to respond_to(:index) }
    it { is_expected.to respond_to(:show) }
  end
end
