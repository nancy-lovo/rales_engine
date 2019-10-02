require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "validations" do
    it { should validate_presence_of :item_id }
    it { should validate_presence_of :invoice_id }
    it { should validate_numericality_of(:quantity).only_integer }
    it { should validate_numericality_of(:unit_price).only_integer }
  end

  describe "relationships" do
    it { should belong_to :invoice }
    it { should belong_to :item }
  end
end
