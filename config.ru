#!/usr/bin/env ruby
require 'rubygems'
require 'sinatra'
require 'gollum/app'

module Precious
  class App < Sinatra::Base
    ['/create/*', '/edit/*', 'uploadFile', '/deleteFile/*', '/rename/*', '/delete/*', '/revert/*'].each do |path|
      before path do
        authenticate!
      end
    end
    helpers do
      def authenticate!
        @auth ||=  Rack::Auth::Basic::Request.new(request.env)
        if @auth.provided? && @auth.basic? && @auth.credentials ==['iwanabe','theguy']
          puts("authenticate!")
        else
          response['WWW-Authenticate'] = %(Basic realm="Gollum Wiki")
          throw(:halt, [401, "Not authorized\n"])
        end
        puts("test")
      end
    end
  end
end

gollum_path = File.expand_path(File.dirname(__FILE__))
wiki_options = {:universal_toc => false}
Precious::App.set(:gollum_path, gollum_path)
Precious::App.set(:default_markup, :markdown)
Precious::App.set(:wiki_options, wiki_options)

run Precious::App
