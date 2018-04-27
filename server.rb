require 'sinatra'
require './block' 
#block.rb 연결


b = Blockchain.new



get '/' do
	"블럭 리스트 입니다."
end


get '/mine' do
	
 b.mining.to_s

end
