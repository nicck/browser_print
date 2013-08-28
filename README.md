# BrowserPrint

[awesome_print][ap] right in your browser

## Installation

Add this line to your application's Gemfile:

``` rb
  gem 'browser_print',
    :git => 'git://github.com/nicck/browser_print.git',
    :group => :development
```

## Usage

Anywhere in your app you can use `bp(object)` to print object inspect to the top of rendered HTML page.

Also you can use `bpp` (browser print proxy) method to inspect object inside method chain.

``` rb
  @comments = user.articles.first.bpp.comments # inspect first user article
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## TODO

- show line of sources where `bpp` called above inspect
- ability to user `user.articles.first.bpp(&:title).comments` for inspecting only title of article instead full article object
- better CSS for browser_print pane

[ap]: http://github.com/michaeldv/awesome_print
