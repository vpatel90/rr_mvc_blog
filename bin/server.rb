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
      User.new("Andrew", "Montgomery"),
      User.new("Van", "Anderson"),
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
      Post.new(TITLES.sample, AllUsers.users.sample, Lorem::L),
      Post.new(TITLES.sample, AllUsers.users.sample, Lorem::O),
      Post.new(TITLES.sample, AllUsers.users.sample, Lorem::R),
      Post.new(TITLES.sample, AllUsers.users.sample, Lorem::E),
      Post.new(TITLES.sample, AllUsers.users.sample, Lorem::M),
      Post.new(TITLES.sample, AllUsers.users.sample, Lorem::L),
      Post.new(TITLES.sample, AllUsers.users.sample, Lorem::O),
      Post.new(TITLES.sample, AllUsers.users.sample, Lorem::R),
      Post.new(TITLES.sample, AllUsers.users.sample, Lorem::E),
      Post.new(TITLES.sample,  AllUsers.users.sample, Lorem::M),
      Post.new(TITLES.sample,  AllUsers.users.sample, Lorem::L),
      Post.new(TITLES.sample,  AllUsers.users.sample, Lorem::O),
      Post.new(TITLES.sample,  AllUsers.users.sample, Lorem::R),
      Post.new(TITLES.sample,  AllUsers.users.sample, Lorem::E),
      Post.new(TITLES.sample, AllUsers.users.sample, Lorem::L),
      Post.new(TITLES.sample, AllUsers.users.sample, Lorem::O),
      Post.new(TITLES.sample, AllUsers.users.sample, Lorem::R),
      Post.new(TITLES.sample, AllUsers.users.sample, Lorem::E),
      Post.new(TITLES.sample, AllUsers.users.sample, Lorem::M),
      Post.new(TITLES.sample, AllUsers.users.sample, Lorem::L),
      Post.new(TITLES.sample, AllUsers.users.sample, Lorem::O),
      Post.new(TITLES.sample, AllUsers.users.sample, Lorem::R),
      Post.new(TITLES.sample, AllUsers.users.sample, Lorem::E),
      Post.new(TITLES.sample,  AllUsers.users.sample, Lorem::M),
      Post.new(TITLES.sample,  AllUsers.users.sample, Lorem::L),
      Post.new(TITLES.sample,  AllUsers.users.sample, Lorem::O),
      Post.new(TITLES.sample,  AllUsers.users.sample, Lorem::R),
      Post.new(TITLES.sample,  AllUsers.users.sample, Lorem::E),
      Post.new(TITLES.sample, AllUsers.users.sample, Lorem::L),
      Post.new(TITLES.sample, AllUsers.users.sample, Lorem::O),
      Post.new(TITLES.sample, AllUsers.users.sample, Lorem::R),
      Post.new(TITLES.sample, AllUsers.users.sample, Lorem::E),
      Post.new(TITLES.sample, AllUsers.users.sample, Lorem::M),
      Post.new(TITLES.sample, AllUsers.users.sample, Lorem::L),
      Post.new(TITLES.sample, AllUsers.users.sample, Lorem::O),
      Post.new(TITLES.sample, AllUsers.users.sample, Lorem::R),
      Post.new(TITLES.sample, AllUsers.users.sample, Lorem::E),
      Post.new(TITLES.sample,  AllUsers.users.sample, Lorem::M),
      Post.new(TITLES.sample,  AllUsers.users.sample, Lorem::L),
      Post.new(TITLES.sample,  AllUsers.users.sample, Lorem::O),
      Post.new(TITLES.sample,  AllUsers.users.sample, Lorem::R),
      Post.new(TITLES.sample,  AllUsers.users.sample, Lorem::E),
    ]
  end


  TITLES ||= [
              "How To Make Your Own Soap",
              "How To Find Nemo",
              "How To Get More Likes On Blog Yo'Self",
              "Ultimate Gold Diggers Guide",
              "Hack: Grow Your Own Rice",
              "DIY Game of Thrones",
              "How To Unlock Perfect Skin",
              "Wrong Ways To Vote",
              "Things Your Dog Doesn't Tell You",
              "Things Your Cat Doesn't Tell You",
              "Secrets To Losing A Bet",
              "Proven Ways To Get A Maid",
              "Facts About Bacon",
              "Is Caffene Affecting Your Loved Ones?",
              "Quiz: Are You Smarter Than Jeff Foxworthy?",
              "Wearable Tuna For The Beach",
              "Best Tip Ever: Carry A Pocket Knife",
              "How To Rock A Funeral",
              "A Complete Guide To Making Cereal",
              "Beginners Gudie: Building A Time Warp Machine",
              "How To Deliver",
              "Insane Man That Will Give You $5",
              "Unique Ways To Use A Toilet",
              "Why I Don't Wax",
              "Which I Had Known",
              "How To Make Your Own Deoderant",
              "How To Find Waldo",
              "How To Get More Likes On Blog Facebook",
              "Ultimate Art Guide",
              "Hack: Grow Your Own Cheese",
              "DIY Wands",
              "How To Unlock A Safe",
              "Wrong Ways To Eat",
              "Things Your Mom Doesn't Tell You",
              "Things Your Mistress Doesn't Tell You",
              "Secrets To Smoking",
              "Proven Ways To Get Fired",
              "Facts About Your Love Life",
              "Is Sarah Jessica Parker Affecting Your Loved Ones?",
              "Quiz: Are You Smarter Than This Guy?",
              "Wearable Umbrella For The Beach",
              "Best Tip Ever: Run 500 Miles",
              "How To Rock A Birthing Room",
              "A Complete Guide To Drinking Water",
              "Beginners Gudie: Building A Warp Drive",
              "How To Fail",
              "Insane Man That Will Give You A Sandwich",
              "Unique Ways To Use A Q-Tip",
              "Why I Don't Sleep",
              "Wish I Had Known",
    ]

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
