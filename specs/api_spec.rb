require_relative './spec_helper'

describe 'Test root route' do
  it 'should find the root route' do
    get '/'
    _(last_response.body).must_include 'UbikeApi'
    _(last_response.status).must_equal 200
  end
end

describe 'Test GET /v1/ubike-station/taipei' do
  it 'should return code: -1' do
    get '/v1/ubike-station/taipei?lat=25.034153&lng=181'
    # print _(last_response.body)
    _(last_response.body).must_include "-1"
  end

  it 'should return code: -2' do
    get '/v1/ubike-station/taipei?lat=25.012890&lng=121.464676'
    _(last_response.body).must_include "-2"
    _(last_response.status).must_equal 400
  end

  it 'should return code: -3' do
    get '/v1/ubike-station/taipei?lat=xxx&lng=ooo'
    _(last_response.body).must_include "-3"
    _(last_response.status).must_equal 400
  end

  it 'should return code: 0' do
    get '/v1/ubike-station/taipei?lat=25.102044&lng=121.548922'
    _(last_response.body).must_include "0"
    _(last_response.status).must_equal 200
  end
end
