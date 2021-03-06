require 'securerandom'
require 'httparty'
require 'json'


class Blockchain

	def initialize
		@chain = []
		@trans = []
		@wallet = {} #데이터셋을 들고있어야하기 때문에 []를 쓰지않음
		@node = []
	end





	def add_port(port)
		@node << port
	end




	def all_node
		@node
	end


	def ask_block
		@node.each do |n| #4567, 4568, 4569
			n_block = HTTParty.get("http://localhost:"+n+"/number_of_blocks").body
			if @chain.length < n_block.to_i
				#내 블럭 정보를 모두 JSON 으로 만들고 그 정보를 상대에게 던진다.
			   jsoned_chain = @chain.to_json
			   full_chain = HTTParty.get("http://localhost:"+n+"/recv_chain?chain="+jsoned_chain)
			   @chain = JSON.parse(full_chain)
			end
		end
	end


	def add_block(block)
		block.each do |b|
			@chain << b
		end
		@chain.to_json
	end




	def wallet_list
	@wallet #지갑주소 리스트 출력
	end


	def make_a_wallet
		address = SecureRandom.uuid.gsub("-", "")
		@wallet[address] = 100 #유니크한 지갑주소 만들고 100코인 넣어줌.
		@wallet
	end

	def make_a_trans(s,r,a)


		if @wallet[s].nil?
			"없는 지갑입니다."
		elsif @wallet[r].nil?
			"없는 지갑입니다."
		elsif @wallet[s].to_f < a.to_f #보낸사람의 잔액wallet[s]이 보내려는 금액a.to_f보다 작으면 "돈이 부족합니다" 출력.
			"돈이 부족합니다"
		else

		@wallet[s] = @wallet[s] - a.to_f
		@wallet[r] = @wallet[r] + a.to_f


		trans = { 
			"sender" => s, "recv" => r, "amount" => a 
		}
		@trans << trans #거래할때마다 거래정보가 trans에 저장.

		"다음 블럭에 쓰여집니다." + (@chain.length + 1).to_s #숫자를 문자로 바꿈.

		end
	end



	def mining

		history = []

		begin
			nonce = rand(100000)
			history << nonce #history 에 nounce 값을 add <<
			hashed = Digest::SHA256.hexdigest(nonce.to_s) #스트링으로 변환한 nonce값을 SHA256 으로 암호화하여 hashed 에 넣는다.

		end while hashed[0..3] != "0000" # hashed 첫 0-3사이의 값이 0000 이 되면, 아래를 실행

			block = {
			"index" => @chain.size + 1, 
			"time" => Time.now, 
			"nonce" => nonce, 
			"previous_address" => Digest::SHA256.hexdigest(last_block.to_s), 
			"transactions" => @trans
			}
			@trans = [] #새로운 배열을 할당.
			@chain << block

		#history.size

	end




	def last_block
		@chain[-1] #리스트의 마지막 -1 
	end

	def all_chains
		@chain # @chain 출력
	end


end
