require 'webrick'
require 'socket'
require 'timeout'
require 'uri'
require 'erb'
require 'json'
require 'pry'
require_relative '../config/router'
require_relative '../app/controllers/application_controller'
require_relative '../lib/all'


module App
  # Place all data here inside of a method
  def App.tweets
    # This is an example
    @all_tweets ||= [
      { message: "cool tweet!", id: 1},
      { message: "badd tweet!", id: 2},
      { message: "ohno tweet!", id: 3},
      { message: "eehhh tweet", id: 4},
    ]
  end
end

module AllPosts
  def AllPosts.posts
    @all_posts ||= [
      Post.new("Post 1", "Vivek", Lorem::L),
      Post.new("Post 2", "Abby", Lorem::O),
      Post.new("Post 3", "Van", Lorem::R),
      Post.new("Post 4", "Dane", Lorem::E),
      Post.new("Post 5", "Nightmaretron", Lorem::M),
      Post.new("Post 6", "Andrew", Lorem::L),
      Post.new("Post 7", "Kat", Lorem::O),
      Post.new("Post 8", "Abby", Lorem::R),
      Post.new("Post 9", "Vivek", Lorem::E),
      Post.new("Post 10", "Abby", Lorem::M),
      Post.new("Post 11", "Vivek", Lorem::L),
      Post.new("Post 12", "Tychus", Lorem::O),
      Post.new("Post 13", "Moralas", Lorem::R),
      Post.new("Post 14", "Li Ming", Lorem::E),
    ]
  end
end
AllPosts.posts.each do |post|
  rand(1..3).times do
    Comment.new("hi guy", Lorem::C1.sample, post)
  end
end

system('clear')

def start_custom_webbrick_server
  server = WEBrick::HTTPServer.new(Port: 3001)
  server.mount "/", WEBBrickServer

  trap(:INT)  { server.shutdown }
  trap(:TERM) { server.shutdown }

  puts "The server is running and awaiting requests at http://localhost:3001/"
  server.start
end

def start_custom_tcp_server
  CustomTCPServer.new.start
end


if ARGV[0] == '--no-webrick'
  start_custom_tcp_server
else
  start_custom_webbrick_server
end
