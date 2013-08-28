require 'awesome_print'

module BrowserPrint
  class Middleware
    MIME_TYPES = ["text/html", 'application/xhtml+xml']

    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, body = @app.call(env)

      @response = Rack::Response.new(body, status, headers)

      inject_log if response_type_okay_to_modify?

      return @response.to_a
    end

    private

    def response_type_okay_to_modify?
      content_type, charset = @response.content_type.split(";")
      @response.ok? && MIME_TYPES.include?(content_type)
    end

    def inject_log
      full_body = @response.body.join
      full_body.sub! /<body([^>]*)>/, "<body#{$1}>" + render

      @response["Content-Length"] = full_body.bytesize.to_s

      # Ensure that browser does
      @response["Etag"] = ""
      @response["Cache-Control"] = "no-cache"

      @response.body = [full_body]
    end

    def render
      html = objects.inject '' do |html, object|
        object_html = object.ai(:html => true)
        object_html.gsub! /\#<(\w+)\:/, '#&lt;\1:'
        html << %{<div class="bp-object">#{object_html}</div>}
      end

      <<-HTML
      <style>
        #bp-pane {
          overflow: auto;
          background: #dfdfdf;
        }
        #bp-pane pre {
          display: inline;
          font-family: Consolas, Monaco, monosapce;
        }
        #bp-pane .bp-object {
          padding: 10px;
          box-shadow:inset 0 0 20px #fff;
        }
      </style>
      <div id="bp-pane">#{html}</div>
      HTML
    end

    def objects
      BrowserPrint.objects
    end
  end
end
