# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReportCreator, type: :model do
  describe '#call' do
    let(:sender) { FactoryBot.create(:user) }
    let!(:sender_account) { FactoryBot.create(:account, amount: 1_000, currency: 'USD', user: sender) }

    let(:receiver) { FactoryBot.create(:user) }
    let!(:receiver_account) { FactoryBot.create(:account, amount: 500, currency: 'USD', user: receiver) }

    let(:params) do
      { action: 'transfer',
        transfer: { identify_number_sender: sender.identify_number.to_s,
                    identify_number_recipient: receiver.identify_number.to_s,
                    currency: 'USD',
                    amount: '500' } }
    end
    let(:params_request) { { user_ids: [receiver.identify_number.to_s], time_period: Time.now - 1.year..Time.now } }

    context 'when sender does not have enough money' do
      it 'should return right statistic' do
        TransferMoney.call(params)

        expect(ReportCreator.call('1', params_request)).to eq([[[receiver.identify_number.to_s, 'USD'], 500]])
      end
    end
  end
end
