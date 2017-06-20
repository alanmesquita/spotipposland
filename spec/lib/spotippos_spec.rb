describe Spotippos do
  let(:subject) { described_class.new('./data/provinces.json') }

  describe '.add_property' do
    before do
      allow(subject).to receive(:properties).and_return(
        class_double('Properties', add: true, last: properties)
      )
    end

    let(:property_schema) {
      PropertySchema.new(
        x: 200,
        y: 800,
        title: 'title',
        price: 1250000,
        description: 'description',
        beds: 10,
        baths: 3,
        squareMeters: 210
      )
    }

    context 'When save first property' do
      let(:properties) { nil }
      it 'return added property id' do
        expect(subject.add_property(property_schema)).to eq(1)
      end
    end

    context 'When save a property with id 2' do
      let(:properties) { {id: 1} }
      it 'return added property id' do
        expect(subject.add_property(property_schema)).to eq(2)
      end
    end

    context 'When save property with one province' do
      let(:properties) { nil }
      it 'property provinces should has one province' do
        subject.add_property(property_schema)
        expect(property_schema.provinces).to eq(["Gode"])
      end
    end

    context 'When save property with two province' do
      let(:properties) { nil }
      it 'property provinces should has two provinces' do
        property_schema.x = 450
        property_schema.y = 700

        subject.add_property(property_schema)
        expect(property_schema.provinces).to eq(["Gode", "Ruja"])
      end
    end

    context 'When property do not match with any provinces' do
      let(:properties) { nil }
      it 'raise province not found exception' do
        property_schema.x = 9999
        property_schema.y = 9999

        expect{subject.add_property(property_schema)}.to raise_error(
          ProvinceNotFound
        )
      end
    end
  end

  describe '.filter_properties_by_coords' do
    before do
      allow(subject).to receive(:properties).and_return(
        class_double('Properties', add: true, all: properties)
      )
    end

    context 'When you do not find any property' do
      let(:properties) { [] }
      it 'raise property not found exception' do
        expect{subject.filter_properties_by_coords(1, 1, 1, 1)}.to raise_error(
          PropertyNotFound
        )
      end
    end

    context 'When it found properties' do
      let(:properties) { [{x: 200, y: 200}, {x: 210, y: 210}] }
      it 'return formated provinces response' do
        expect(subject.filter_properties_by_coords(0, 400, 800, 0)).to eq(
          {
            foundProperties: 2,
            properties: [
              {x: 200, y: 200},
              {x: 210, y: 210}
            ]
          }
        )
      end
    end
  end
end
