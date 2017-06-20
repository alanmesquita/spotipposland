require "bundler/setup"
require 'sinatra'
require './models/property_schema.rb'
require './lib/spotippos.rb'

class App < Sinatra::Base
  set :spotippos, Spotippos.new('./data/provinces.json')
  set :show_exceptions, :after_handler

  post '/properties' do
    # TO-DO make invalid body response
    payload = JSON.parse(request.body.read)

    property_schema = PropertySchema.new(payload)

    if not property_schema.valid?
      return response_body(422, property_schema.errors.messages)
    end

    response_body(201, {id: province.add_property(property_schema)})
  end

  get '/properties/:id' do
    properties = province.get_property_by_id(params['id'])

    response_body 200, properties
  end

  get '/properties' do
    ax = params['ax'].to_i
    ay = params['ay'].to_i
    bx = params['bx'].to_i
    by = params['by'].to_i

    properties = province.filter_properties_by_coords(ax, ay, bx, by)

    response_body 200, properties
  end

  error PropertyNotFound do
    response_body(404)
  end

  error ProvinceNotFound do
    return response_body(422,
      {
        provinces: 'There is no province with the coordinates sent'
      }
    )
  end

  private
  def province
    settings.spotippos
  end

  def response_body(status_code, body='')
    status status_code
    content_type :json

    body = body.to_json if body
    body
  end
end
