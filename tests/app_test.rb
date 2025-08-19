require 'minitest/autorun'
require 'rack/test'
require 'json'
require_relative '../app'

class AppTest < Minitest::Test
  include Rack::Test::Methods

  # This method tells Rack::Test which application to run
  def app
    Sinatra::Application
  end

  def setup
    # Reset the users array to its initial state before each test
    users.clear
    users.replace([
      { id: 1, name: 'John Doe', email: 'john@example.com' },
      { id: 2, name: 'Jane Doe', email: 'jane@example.com' }
    ])
  end

  # Test for the GET /users route
  def test_get_users
    get '/users'
    assert last_response.ok?
    assert_equal 'application/json', last_response.content_type
    users = JSON.parse(last_response.body)
    assert_equal 2, users.size
  end

  # Test for the GET /users/:id route
  def test_get_single_user
    get '/users/1'
    assert last_response.ok?
    user = JSON.parse(last_response.body)
    assert_equal 'John Doe', user['name']
  end

  # Test for the POST /users route
  def test_create_new_user
    post '/users', { name: 'Peter Pan', email: 'peter@example.com' }.to_json, { 'CONTENT_TYPE' => 'application/json' }
    assert last_response.ok?
    user = JSON.parse(last_response.body)
    assert_equal 'Peter Pan', user['name']
    assert_equal 3, user['id']
  end

  # Test for the PUT /users/:id route
  def test_update_user
    put '/users/2', { name: 'Jane Smith' }.to_json, { 'CONTENT_TYPE' => 'application/json' }
    assert last_response.ok?
    user = JSON.parse(last_response.body)
    assert_equal 'Jane Smith', user['name']
  end

  # Test for the DELETE /users/:id route
  def test_delete_user
    delete '/users/1'
    assert last_response.ok?
    message = JSON.parse(last_response.body)
    assert_equal 'User deleted', message['message']

    get '/users/1'
    assert last_response.not_found? # Check that the user no longer exists
  end
end
