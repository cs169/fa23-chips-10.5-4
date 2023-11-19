
require 'rails_helper'

describe Representative do
  describe '.civic_api_to_representative_params' do
    let(:rep_info) do
      OpenStruct.new({
        officials: [
          OpenStruct.new({ name: 'John Doe' }),
          OpenStruct.new({ name: 'Jane Smith' })
        ],
        offices: [
          OpenStruct.new({
            name: 'Mayor',
            division_id: 'ocdid1',
            official_indices: [0]
          }),
          OpenStruct.new({
            name: 'Governor',
            division_id: 'ocdid2',
            official_indices: [1]
          })
        ]
      })
    end

    context 'when officials already exist' do
      before do
        Representative.create(name: 'John Doe', ocdid: 'ocdid1', title: 'Mayor')
      end

      it 'does not create duplicates' do
        expect { Representative.civic_api_to_representative_params(rep_info) }
          .to change(Representative, :count).by(1)
        expect(Representative.where(name: 'John Doe').count).to eq(1)
        expect(Representative.where(name: 'Jane Smith').count).to eq(1)
      end
    end

    context 'when no officials exist' do
      it 'creates new records' do
        expect { Representative.civic_api_to_representative_params(rep_info) }
          .to change(Representative, :count).by(2)
      end
    end
  end
end