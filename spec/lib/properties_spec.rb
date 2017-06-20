describe Properties do
  before do
    allow(described_class).to receive(:properties).and_return(properties)
  end

  describe '#add' do
    context 'When add a item in properties' do
      let(:properties) { [] }

      it 'this item should be in properties list' do
        described_class.add({foo: 'bar'})
        expect(described_class.all).to eq([{foo: 'bar'}])
      end
    end
  end

  describe '#get_by_id' do
    context 'When it finds a property by id' do
      let(:properties) { [{foo: 'bar'}] }

      it 'return the property' do
        expect(described_class.get_by_id(1)).to eq({foo: 'bar'})
      end
    end

    context 'When it does not find the property by id' do
      let(:properties) { [{foo: 'bar'}] }

      it 'return nil' do
        expect(described_class.get_by_id(2)).to be_nil
      end
    end


    context 'When it sends a string in params' do
      let(:properties) { [{foo: 'bar'}] }

      it 'return nil' do
        expect(described_class.get_by_id('foo')).to be_nil
      end
    end
  end

  describe '#last' do
    context 'When there is at least one property' do
      let(:properties) { [{foo: 'bar'}] }

      it 'return last one' do
        expect(described_class.last).to eq({foo: 'bar'})
      end
    end

    context 'When there is no property' do
      let(:properties) { [] }

      it 'return nil' do
        expect(described_class.last).to be_nil
      end
    end
  end

  describe '#add' do
    context 'When there is at least one property' do
      let(:properties) { [{foo: 'bar'}] }

      it 'return all properties' do
        expect(described_class.all).to eq([{foo: 'bar'}])
      end
    end

    context 'When there is no property' do
      let(:properties) { [] }

      it 'return empty dict' do
        expect(described_class.all).to eq([])
      end
    end
  end
end
