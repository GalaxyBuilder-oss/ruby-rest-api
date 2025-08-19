# test/app_test.rb
require 'minitest/autorun'
require 'rack/test'
require_relative '../app'

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_get_users_returns_ok
    get '/users'
    assert last_response.ok?
  end
end
