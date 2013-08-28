require 'test_helper'
require 'browser_print'

describe BrowserPrint::Middleware do
  def default_app(options = {})
    Rack::Builder.new {
      use BrowserPrint::Middleware
      run lambda { |env|
        options[:processor].call if options[:processor]
        [
          200,
          {'Content-Type' => 'text/html'},
          [options[:body] || 'app page']
        ]
      }
    }.to_app
  end

  def http_get_request
    get '/', {}, {'HTTP_ACCEPT' => 'text/html'}
  end

  def bp_pane_object
    '<div id="bp-pane"><div class="bp-object">'
  end

  context 'request processor does not have bpp calls' do
    def app
      default_app(
        body: '<body>original body</body>',
        processor: -> { }
      )
    end

    it 'shoudl respond with application page' do
      http_get_request
      last_response.body.wont_include bp_pane_object
    end
  end

  context 'request processor have bpp call' do
    def app
      default_app(
        body: '<body>original body</body>',
        processor: -> { 1.bpp + 2 }
      )
    end

    it 'shoudl respond with application page' do
      http_get_request
      last_response.body.must_include bp_pane_object
    end
  end

  context 'request processor have bp call' do
    def app
      default_app(
        body: '<body>original body</body>',
        processor: -> { res = 1 + 2; bp(res) }
      )
    end

    it 'shoudl respond with application page' do
      http_get_request
      last_response.body.must_include bp_pane_object
    end
  end

  context 'body with attributes' do
    def app
      default_app(
        body: '<body id="homepage">original body</body>',
        processor: -> { bp(1) }
      )
    end

    it 'shoudl respond with application page' do
      http_get_request
      last_response.body.must_include bp_pane_object
    end
  end

end
