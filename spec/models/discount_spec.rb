require 'spec_helper'

describe Discount do

  describe "#calc_discount_for" do
    let(:amount) { 100.0 }
    subject { discount.calc_discount_for(amount) }

    context "when the discount is fixed" do
      let!(:discount) { create(:fixed_discount, value: 10) }

      it { is_expected.to eq(10.0) }
    end

    context "when the discount is percentage" do
      let!(:discount) { create(:percentage_discount, value: 20) }
      it { is_expected.to eq(20.0) }
    end
  end

end
