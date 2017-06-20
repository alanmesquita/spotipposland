describe App do
  let(:json_type) { {CONTENT_TYPE: "application/json"} }
  describe 'POST /properties' do
    context 'When sends a valid body' do
      it 'return added id' do
        payload = JSON.dump(
          x: 222,
          y: 444,
          title: "Imóvel código 1, com 5 quartos e 4 banheiros",
          price: 1250000,
          description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
          beds: 4,
          baths: 3,
          squareMeters: 210
        )
        post '/properties', payload, json_type
        expect(last_response.status).to eq(201)
      end
    end

    context 'When sends invalid param' do
      it 'return 422 and error fields' do
        payload = JSON.dump(
          y: 444,
          title: "Imóvel código 1, com 5 quartos e 4 banheiros",
          price: 1250000,
          description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
          beds: 4,
          baths: 3,
          squareMeters: 210
        )
        post '/properties', payload, json_type
        expect(last_response.status).to eq(422)
      end
    end

    context 'When the given property does not match with any province' do
      it 'return 422 and error fields' do
        payload = JSON.dump(
          x: 9999,
          y: 9999,
          title: "Imóvel código 1, com 5 quartos e 4 banheiros",
          price: 1250000,
          description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
          beds: 4,
          baths: 3,
          squareMeters: 210
        )
        post '/properties', payload, json_type
        expect(last_response.status).to eq(422)
        expect(JSON.load(last_response.body)).to eq(
          {"provinces"=>"There is no province with the coordinates sent"}
        )
      end
    end
  end

  describe 'GET /properties/:id' do
    context 'When a property was found' do
      it 'return property json' do
        get '/properties/1'
        expected_response = {
          'foundProperties' => 1,
           'properties' => [
              {
                'id' => 1,
                'x' => 222,
                'y' => 444,
                'title' => 'Imóvel código 1, com 5 quartos e 4 banheiros',
                'price' => 1250000,
                'description' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                'beds' => 4,
                'baths' => 3,
                'squareMeters' => 210,
                'provinces' => ['Scavy']
              }
          ]
        }
        expect(last_response.status).to eq(200)
        expect(JSON.load(last_response.body)).to eq(expected_response)
      end
    end

    context 'When a property was not found' do
      it 'return not found' do
        get '/properties/99'
        expect(last_response.status).to eq(404)
      end
    end
  end

  describe 'GET /properties' do
    context 'When a properties was found' do
      it 'return property json' do
        get '/properties?ax=200&ay=450&bx=500&by=400'
        expected_response = {
          'foundProperties' => 1,
           'properties' => [
              {
                'id' => 1,
                'x' => 222,
                'y' => 444,
                'title' => 'Imóvel código 1, com 5 quartos e 4 banheiros',
                'price' => 1250000,
                'description' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                'beds' => 4,
                'baths' => 3,
                'squareMeters' => 210,
                'provinces' => ['Scavy']
              }
          ]
        }
        expect(last_response.status).to eq(200)
        expect(JSON.load(last_response.body)).to eq(expected_response)
      end
    end

    context 'When a properties was no found' do
      it 'return property json' do
        get '/properties?ax=1000&ay=100&bx=1500&by=0'
        expect(last_response.status).to eq(404)
      end
    end
  end
end
