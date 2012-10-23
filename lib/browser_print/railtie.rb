module BrowserPrint
  class Railtie < Rails::Railtie
    initializer "browser_print.insert_middleware" do |app|
      app.config.middleware.use 'BrowserPrint::Middleware'
    end
  end
end
