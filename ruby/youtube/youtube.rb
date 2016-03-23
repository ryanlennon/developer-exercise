require 'rubygems'
require 'unirest'

puts "Please enter the type of youtube videos you are looking for:"
user_search = gets.chomp

puts "Please enter the number of videos you would you like to see:"
number = gets.chomp

search_results = Unirest.get("https://www.googleapis.com/youtube/v3/search?part=snippet&q=#{user_search}&type=video&maxResults=#{number}&key=#{developer_key}").body["items"]
  
videos_array = []
search_results.each do |results|
    videos_array << "http://www.youtube.com/watch?v=" + results["id"]["videoId"]
end

puts "Here are your results: "
puts videos_array
