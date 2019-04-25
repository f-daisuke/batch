require "rails_helper"

describe Filter::Upcase do
  describe "#filter" do
    subject do
      Filter::Upcase.new.filter(hash, nil)
    end
    context "{}を返すこと" do
      let(:hash) {
        {}
      }
      it { is_expected.to be_blank }
    end
    context "{'type2' => 'a'}を返すこと" do
      let(:hash) {
        {
          'type2' => 'a'
        }
      }
      it { is_expected.to eq hash }
    end
    context "{'type1' => 'A', 'type2' => 'a'}を返すこと" do
      let(:hash) {
        {
          'type1' => 'a',
          'type2' => 'a'
        }
      }
      it { is_expected.to eq ({'type1' => 'A', 'type2' => 'a'}) }
    end
    context "{}を返すこと" do
      let(:hash) {
        {
          'type1' => 'a',
          'type2' => 'a'
        }
      }
      it do
        expect(hash).to receive(:blank?).and_return(true)
        is_expected.to eq ({})
      end
    end
  end
end
