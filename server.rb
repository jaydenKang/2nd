require 'sinatra'
require './block' 
#block.rb 연결


b = Blockchain.new



get '/' do

 message = ""

 b.all_chains.each do |a|
 message << a['index'].to_s + "<br>" 
 end

 message #출력

end


get '/mine' do
 b.mining.to_s

end
