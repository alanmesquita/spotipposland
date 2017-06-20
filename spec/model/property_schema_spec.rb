describe PropertySchema do
  let(:property_values) {{
    x: 222,
    y: 444,
    title: "Imovel codigo 1, com 5 quartos e 4 banheiros",
    price: 1250000,
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    beds: 4,
    baths: 3,
    squareMeters: 210
  }}

  describe 'valid?' do
    context 'When property is not valid' do
      it 'property must be invalidated' do
        subject = described_class.new()
        expect(subject.valid?).to be_falsey
      end

      context 'When the number of beds is greater than the limit' do
        it 'property must be invalidated' do
          property_values[:beds] = 10
          subject = described_class.new(property_values)

          expect(subject.valid?).to be_falsey
        end
      end

      context 'When the number of baths is greater than the limit' do
        it 'property must be invalidated' do
          property_values[:beds] = 1
          property_values[:baths] = 30
          subject = described_class.new(property_values)

          expect(subject.valid?).to be_falsey
        end
      end

      context 'When the square meters number is not in limit range' do
        it 'property must be invalidated' do
          property_values[:squareMeters] = 1000
          subject = described_class.new(property_values)

          expect(subject.valid?).to be_falsey
          expect(subject.errors.full_messages).to eq(
            ["Squaremeters should be between 20 and 240"]
          )
        end
      end
    end

    context 'When the all attributes are valid' do
      it 'the property must be valid' do
        subject = described_class.new(property_values)
        expect(subject.valid?).to be_truthy
      end
    end
  end

  describe 'serializable_hash' do
    it 'return pecified dict' do
        subject = described_class.new(property_values)
        subject.id = 1
        subject.provinces = 'foo'
        expect(subject.serializable_hash).to eq({
          id: 1,
          x: 222,
          y: 444,
          title: "Imovel codigo 1, com 5 quartos e 4 banheiros",
          price: 1250000,
          description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
          beds: 4,
          baths: 3,
          squareMeters: 210,
          provinces: "foo"
        })
    end
  end
end
