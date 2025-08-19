require 'sinatra'

set :environment, :test
set :raise_errors, true
set :dump_errors, true
set :show_exceptions, false

require 'json'

$users = [
  { id: 1, name: 'John Doe', email: 'john@example.com' },
  { id: 2, name: 'Jane Doe', email: 'jane@example.com' }
]

get '/users' do
  content_type :json
  $users.to_json
end

get '/users/:id' do
  content_type :json
  user = $users.find { |u| u[:id] == params[:id].to_i }
  if user
    user.to_json
  else
    halt 404, { message: 'User not found' }.to_json
  end
end

post '/users' do
  content_type :json
  new_user = JSON.parse(request.body.read)
  new_user['id'] = users.size + 1
  $users << new_user
  new_user.to_json
end

put '/users/:id' do
  content_type :json
  user = $users.find { |u| u[:id] == params[:id].to_i }
  if user
    updated_user = JSON.parse(request.body.read)
    user.merge!(updated_user)
    user.to_json
  else
    halt 404, { message: 'User not found' }.to_json
  end
end

delete '/users/:id' do
  content_type :json
  user = $users.find { |u| u[:id] == params[:id].to_i }
  if user
    $users.delete(user)
    { message: 'User deleted' }.to_json
  else
    halt 404, { message: 'User not found' }.to_json
  end
end
