require 'rack/auth/request'
require 'rack/lint'
require 'rack/mock'

RSpec.describe Rack::Auth::Request do
  def unprotected_app
    Rack::Lint.new lambda { |env|
      [ 200, { 'Content-Type' => 'text/plain' }, ['Hello'] ]
    }
  end

  def request(auth)
    protected_app = Rack::Auth::Request.new(unprotected_app, auth)
    Rack::MockRequest.new(protected_app)
  end

  it 'return application outupt if auth method returns success code' do
    [200, 201, 202, 203, 204, 205, 206].each do |code|
      success = lambda { |_| [code, {}, []] }
      response = request(success).get('/')
      expect(response.status).to eq(200)
      expect(response.body).to eq('Hello')
    end
  end

  it 'return 401 if auth method returns 401' do
    unauthorized = lambda { |_| [401, {}, []] }
    response = request(unauthorized).get('/')
    expect(response.status).to eq(401)
  end

  it 'return 403 if auth method returns 403' do
    forbidden = lambda { |_| [403, {}, []] }
    response = request(forbidden).get('/')
    expect(response.status).to eq(403)
  end

  it 'return 500 if auth method returns other code' do
    [301, 302, 400,  404, 410, 429, 500, 501, 502, 503, 504].each do |code|
      fail = lambda { |_| [code, {}, []] }
      response = request(fail).get('/')
      expect(response.status).to eq(500)
    end
  end
end
