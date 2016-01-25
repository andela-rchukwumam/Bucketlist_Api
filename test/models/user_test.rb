require 'test_helper'

class UserTest < ActionDispatch::IntegrationTest
  test 'validates user name' do
    post '/api/v1/users',
         { full_name: nil, email: 'ruth@a.com', password: 'password' }.to_json,
         'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s
    assert_equal 400, response.status
    assert_equal Mime::JSON, response.content_type
    status = JSON.parse(response.body)
    assert_equal status['Status'], 'User could not be created'
  end

   test "validate user email" do
     post '/api/v1/users',
          { full_name: 'Ruth', email: 'ruth.com', password: 'password' }.to_json,
          'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s
     assert_equal 400, response.status
     assert_equal Mime::JSON, response.content_type
     status = JSON.parse(response.body)
     assert_equal status['Status'], 'User could not be created'
   end

   test 'validates user password' do
     post '/api/v1/users',
          { full_name: 'Ruth', email: 'ruth@ada.com', password: nil }.to_json,
          'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s
     assert_equal 400, response.status
     assert_equal Mime::JSON, response.content_type
     status = JSON.parse(response.body)
     assert_equal status['Status'], 'User could not be created'
   end
end
