require 'sinatra'
require './block' 
#block.rb 연결


b = Blockchain.new



get '/add_node' do #port를 변수화해서 저장.
	port = params["port"]
	b.add_port(port) 
end


get '/recv_chain' do

	rev_chain = params["chain"]
	extracted = JSON.parse(rev_chain)
	b.add_block(extracted)

end



get '/all_node' do
	b.all_node.to_s
end



get '/number_of_blocks' do
	b.all_chains.size.to_s
end


get '/ask' do
	b.ask_block.to_s
end




get '/' do

 message = "<center>"

 b.all_chains.each do |a|
 message << "번호는 : " + a['index'].to_s + "<br>" 
 message << "nonce는 : " + a['nonce'].to_s + "<br>" 
 message << "시간은 : " + a['time'].to_s + "<br>" 
 message << "앞 주소는 : " + a['previous_address'].to_s + "<br>" 
 message << "내 주소는 : " + Digest::SHA256.hexdigest(a.to_s) + "<br>" 
 message << "거래정보 : " + a['transactions'].to_s + "<br>"
 message << "<hr>"
 end

 message << "</center>"
 message #출력

end


get '/mine' do
 b.mining.to_s
end


get '/trans' do
 b.make_a_trans(params["sender"], params["recv"], params["amount"])
end


get '/new_wallet' do
	b.make_a_wallet.to_s
end

get '/wallet_list' do
	b.wallet_list.to_s 
end
