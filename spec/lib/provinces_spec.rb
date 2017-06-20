describe Provinces do
  describe '.new' do
    context 'When provinces file not found' do
      it 'raise exception' do
        expect{described_class.new('teste')}.to raise_error(Errno::ENOENT)
      end
    end
  end

  describe '.get_property_by_id' do
    let(:subject) { described_class.new('./data/provinces.json') }

    before do
      allow(subject).to receive(:properties).and_return(
        class_double('Properties', get_by_id: properties)
      )
    end

    context 'When it finds the property by given id' do
      let(:properties) { {foo: 'bar'} }
      it 'return formated response with property' do
        expect(subject.get_property_by_id(1)).to eq(
          {
            foundProperties: 1,
            properties: [{foo: 'bar'}]
          }
        )
      end
    end

    context 'When it does not find the property by id' do
      let(:properties) { nil }
      it 'raise property not found error' do
        expect{subject.get_property_by_id(1)}.to raise_error(PropertyNotFound)
      end
    end
  end
end
