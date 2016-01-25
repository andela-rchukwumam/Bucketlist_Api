require 'test_helper'

class ItemTest < ActionDispatch::IntegrationTest
  test 'validates item name' do
    create_bucketlist
    post '/api/v1/lists/1/items',
         { name: nil, details: 'first item', done: true }.to_json,
         'Accept' => Mime::JSON,
         'Content-Type' => Mime::JSON.to_s, 'Authorization' => @auth_token
    assert_equal 400, response.status
    assert_equal Mime::JSON, response.content_type
    error = JSON.parse(response.body)
    assert_equal error['Error'], "can't be blank"
  end
end
