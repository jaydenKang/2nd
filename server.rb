require 'sinatra'
require './block' 
#block.rb 연결


b = Blockchain.new



get '/' do

 message = ""

 b.all_chains.each do |a|
 message << "번호는 : " + a['index'].to_s + "<br>" 
 message << "nonce는 : " + a['nonce'].to_s + "<br>" 
 message << "시간은 : " + a['time'].to_s + "<br>" 
 message << "앞 주소는 : " + a['previous_address'].to_s + "<br>" 
 message << "내 주소는 : " + Digest::SHA256.hexdigest(a.to_s) + "<br>" 
 message << "<hr>"
 end

 message #출력

end


get '/mine' do
 b.mining.to_s

end
