class Blockchain


	def mining
		begin
			nonce = rand(100000)
			hashed = Digest::SHA256.hexdigest(nonce.to_s)
		end while hashed[0..3] != "0000" #hashed 값의 첫 0-3사이의 값이 0000 일때까지

		nonce
	end

end