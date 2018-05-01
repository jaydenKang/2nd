class Blockchain

	def initialize
		@chain = []
		@trans = []
	end

	def make_a_trans(s,r,a)
		trans = { 
			"sender" => s, "recv" => r, "amount" => a 
		}

		@trans << trans #거래할때마다 거래정보가 trans에 저장.

		"다음 블럭에 쓰여집니다." + (@chain.length + 1).to_s
	end



	def mining

		history = []

		begin
			nonce = rand(100000)
			history << nonce #history 에 nounce 값을 add <<
			hashed = Digest::SHA256.hexdigest(nonce.to_s) #스트링으로 변환한 nonce값을 SHA256 으로 암호화하여 hashed 에 넣는다.

		end while hashed[0..3] != "0000" # hashed 첫 0-3사이의 값이 0000 이 되면, 아래를 실행

			block = {
			"index" => @chain.size + 1, "time" => Time.now, "nonce" => nonce, "previous_address" => Digest::SHA256.hexdigest(last_block.to_s)
			#chain.size 에서 +1을 추가 , to_i 는 초
			}

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
