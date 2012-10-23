require 'browser_print/version'
require 'browser_print/middleware'
require 'browser_print/railtie' if defined? Rails
require 'core_ext/object'
require 'core_ext/kernel'

module BrowserPrint
  def self.inspect_object(object)
    objects << object
  end

  def self.objects
    Thread.current['browser_print.object'] ||= []
  end
end
