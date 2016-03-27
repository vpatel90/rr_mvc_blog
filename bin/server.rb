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

$main_user = nil
module GetTime
  def GetTime.now
    "#{Time.now.strftime('%x')} at #{Time.now.strftime('%r')}"
  end
end
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

module AllUsers
  def AllUsers.users
    @all_users ||= [
      User.new("Vivek", "Patel"),
      User.new("Abby", "Hunter"),
      User.new("Kat", "Bianco"),
      User.new("Tyrion", "Lannister"),
      User.new("Jon", "Snow"),
      User.new("Arya", "Stark"),
      User.new("Daenerys", "Targaryen"),
      User.new("Robert", "Barratheon"),
      User.new("Oberyn", "Martell"),
      User.new("Malcolm", "Reynolds"),
      User.new("Aedan", "Cousland"),
      User.new("George Michael", "Bluth"),
      User.new("Maeby", "Funke"),
      User.new("Peter", "Griffin"),
      User.new("Steve", "Smith"),
      User.new("Rick", "Morty"),
      User.new("Bernie", "Sanders"),
      User.new("Hillary", "Clinton"),
      User.new("Ted", "Cruz"),
      User.new("Donald", "Trump"),
      User.new("Stephen", "Colbert"),
                    ]
  end
end

module AllPosts
  def AllPosts.posts
    @all_posts ||= [
      Post.new("Post 1", AllUsers.users.sample, Lorem::L),
      Post.new("Post 2", AllUsers.users.sample, Lorem::O),
      Post.new("Post 3", AllUsers.users.sample, Lorem::R),
      Post.new("Post 4", AllUsers.users.sample, Lorem::E),
      Post.new("Post 5", AllUsers.users.sample, Lorem::M),
      Post.new("Post 6", AllUsers.users.sample, Lorem::L),
      Post.new("Post 7", AllUsers.users.sample, Lorem::O),
      Post.new("Post 8", AllUsers.users.sample, Lorem::R),
      Post.new("Post 9", AllUsers.users.sample, Lorem::E),
      Post.new("Post 10", AllUsers.users.sample, Lorem::M),
      Post.new("Post 11", AllUsers.users.sample, Lorem::L),
      Post.new("Post 12", AllUsers.users.sample, Lorem::O),
      Post.new("Post 13", AllUsers.users.sample, Lorem::R),
      Post.new("Post 14", AllUsers.users.sample, Lorem::E),
      Post.new("Post 1", AllUsers.users.sample, Lorem::L),
      Post.new("Post 2", AllUsers.users.sample, Lorem::O),
      Post.new("Post 3", AllUsers.users.sample, Lorem::R),
      Post.new("Post 4", AllUsers.users.sample, Lorem::E),
      Post.new("Post 5", AllUsers.users.sample, Lorem::M),
      Post.new("Post 6", AllUsers.users.sample, Lorem::L),
      Post.new("Post 7", AllUsers.users.sample, Lorem::O),
      Post.new("Post 8", AllUsers.users.sample, Lorem::R),
      Post.new("Post 9", AllUsers.users.sample, Lorem::E),
      Post.new("Post 10", AllUsers.users.sample, Lorem::M),
      Post.new("Post 11", AllUsers.users.sample, Lorem::L),
      Post.new("Post 12", AllUsers.users.sample, Lorem::O),
      Post.new("Post 13", AllUsers.users.sample, Lorem::R),
      Post.new("Post 14", AllUsers.users.sample, Lorem::E),
      Post.new("Post 1", AllUsers.users.sample, Lorem::L),
      Post.new("Post 2", AllUsers.users.sample, Lorem::O),
      Post.new("Post 3", AllUsers.users.sample, Lorem::R),
      Post.new("Post 4", AllUsers.users.sample, Lorem::E),
      Post.new("Post 5", AllUsers.users.sample, Lorem::M),
      Post.new("Post 6", AllUsers.users.sample, Lorem::L),
      Post.new("Post 7", AllUsers.users.sample, Lorem::O),
      Post.new("Post 8", AllUsers.users.sample, Lorem::R),
      Post.new("Post 9", AllUsers.users.sample, Lorem::E),
      Post.new("Post 10", AllUsers.users.sample, Lorem::M),
      Post.new("Post 11", AllUsers.users.sample, Lorem::L),
      Post.new("Post 12", AllUsers.users.sample, Lorem::O),
      Post.new("Post 13", AllUsers.users.sample, Lorem::R),
      Post.new("Post 14", AllUsers.users.sample, Lorem::E),
    ]
  end
end

AllPosts.posts.each do |post|
  post.published = true if rand(1..3) == 2
  rand(1..20).times do
    Comment.new(AllUsers.users.sample, Lorem::C1.sample, post)
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
