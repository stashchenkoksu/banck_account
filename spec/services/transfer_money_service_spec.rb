# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransferMoney, type: :model do
  describe '#call' do
    let(:sender) { FactoryBot.create(:user) }
    let!(:sender_account) { FactoryBot.create(:account, amount: 1_000, currency: 'USD', user: sender) }

    let(:receiver) { FactoryBot.create(:user) }
    let!(:receiver_account) { FactoryBot.create(:account, amount: 0, currency: 'USD', user: receiver) }

    context 'when sender has enough money and receiver has this currency account' do
      let(:params) do
        { action: 'transfer',
          transfer: { identify_number_sender: sender.identify_number.to_s,
                      identify_number_recipient: receiver.identify_number.to_s,
                      currency: 'USD',
                      amount: '500' } }
      end

      it 'subtract sender money and adds receiver money' do
        TransferMoney.call(params)

        expect(sender.accounts.find_by(currency: 'USD').amount).to eq(500)
        expect(receiver.accounts.find_by(currency: 'USD').amount).to eq(500)
      end
    end

    context 'when sender has enough money and receiver does not have this currency account' do
      let!(:sender_account) { FactoryBot.create(:account, amount: 1_000, currency: 'EUR', user: sender) }
      let(:params) do
        { action: 'transfer',
          transfer: { identify_number_sender: sender.identify_number.to_s,
                      identify_number_recipient: receiver.identify_number.to_s,
                      currency: 'EUR',
                      amount: '500' } }
      end

      it 'subtract sender money, create receivers new account and adds receiver money' do
        TransferMoney.call(params)

        expect(receiver.accounts.find_by(currency: 'EUR').persisted?).to be true
        expect(sender.accounts.find_by(currency: 'EUR').amount).to eq(500)
        expect(receiver.accounts.find_by(currency: 'EUR').amount).to eq(500)
      end
    end

    context 'when sender does not have enough money' do
      let(:params) do
        { action: 'transfer',
          transfer: { identify_number_sender: sender.identify_number.to_s,
                      identify_number_recipient: receiver.identify_number.to_s,
                      currency: 'USD',
                      amount: '1500' } }
      end
      it 'amount stay the same' do
        TransferMoney.call(params)

        expect(sender.accounts.find_by(currency: 'USD').amount).to eq(1000)
        expect(receiver.accounts.find_by(currency: 'USD').amount).to eq(0)
      end
    end
  end
end
