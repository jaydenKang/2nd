class Blockchain

	def initialize
		@chain = []
	end


	def mining

		history = []

		begin
			nonce = rand(100000)
			
			history << nonce

			hashed = Digest::SHA256.hexdigest(nonce.to_s)

		end while hashed[0..3] != "0000" #hashed 값의 첫 0-3사이의 값이 0000 일때까지

			block = {
			"index" => @chain.size + 1, "time" => Time.now, "nonce" => nonce
			#chain.size 에서 +1을 추가 , to_i 는 초
			}

			@chain << block

		#history.size

	end

	def all_chains
		@chain # @chain 출력
	end


end