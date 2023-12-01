# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationJob, type: :job do
  it 'is a valid job class' do
    expect(described_class).to be < ActiveJob::Base
  end
end
