require 'sinatra'
require './block' 
#block.rb 연결


b = Blockchain.new



get '/' do
 b.all_chains.to_s
end


get '/mine' do
 b.mining.to_s

end
