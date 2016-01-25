require 'test_helper'

class ListTest < ActionDispatch::IntegrationTest
  test 'validates list name' do
    auth_token = login
    post '/api/v1/lists/',
         { name: nil, publicity: true }.to_json,
         'Accept' => Mime::JSON,
         'Content-Type' => Mime::JSON.to_s, 'Authorization' => auth_token
    assert_equal 400, response.status
    assert_equal Mime::JSON, response.content_type
    error = JSON.parse(response.body)
    assert_equal error['name'][0], "can't be blank"
  end
end
