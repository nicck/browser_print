require 'minitest/pride'
require 'minitest/autorun'

require 'rack/test'

class MiniTest::Spec
  class << self
    alias context describe
  end

  include Rack::Test::Methods
end
