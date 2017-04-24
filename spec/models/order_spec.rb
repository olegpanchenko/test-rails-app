require 'spec_helper'

describe Order do
  let!(:item_1) { create(:item, price: 10.0) }
  let!(:item_2) { create(:item, price: 20.0) }

  describe "#calc_amount" do
    let(:order) { create(:order) }
    subject { order.calc_amount }

    context "when the basket is empty" do
      it { is_expected.to eq(0.0) }
    end

    context "when the basket is not empty" do
      before do
        # prepare basket
        create(:order_item, {
          order_id: order.id,
          item_id: item_1.id,
          quantity: 2
        })
        create(:order_item, {
          order_id: order.id,
          item_id: item_2.id,
          quantity: 1
        })
      end

      it { is_expected.to eq(40.0) }
    end

    context "when the promotions is applied" do
      before do
        # prepare basket
        create(:order_item, {
          order_id: order.id,
          item_id: item_1.id,
          quantity: 2
        })
        create(:order_item, {
          order_id: order.id,
          item_id: item_2.id,
          quantity: 1
        })
        # apply promotions
        create(:percentage_discount,{
          value: 20,
          order_id: order.id
        })
        create(:fixed_discount,{
          value: 10,
          order_id: order.id
        })
      end

      it { is_expected.to eq(22.0) }
    end
  end

  describe "#apply_promotion!" do
    let(:order) { create(:order) }
    subject { order.apply_promotion!(code) }

    context "when the promotions is not exist" do
      let(:code) { '11%OFF' }

      it { is_expected.to eq(false) }
    end

    context "when the promotions is exist" do
      let(:code) { '10%OFF' }
      let!(:discount) { create(:fixed_discount, {
            promo_code: code,
            value: 10
        })
      }

      it { is_expected.to eq(true) }
    end

    context "when the promotions cannot be used in conjunction" do
      let(:code) { '10%OFF' }
      let!(:discount) { create(:fixed_discount, {
            promo_code: code,
            value: 10,
            can_be_conjunction: false
        })
      }

      before do
        create(:percentage_discount,{
          value: 20,
          order_id: order.id,
          can_be_conjunction: true
        })
      end

      it { is_expected.to eq(true) }
    end
  end

  describe "#make_payment" do
  end
end
