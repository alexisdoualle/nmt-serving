run: 
	make -k r

r:  rm rn
	
build:
	@echo "Building WezenMT serving docker"
	sudo docker build . -t wezenmt-serving

kill:
	sudo docker kill wezenmt-serving

rm:
	sudo docker rm wezenmt-serving

rn:
	@echo "Lauching WezenMT serving docker"
	# sudo docker run -it --name wezenmt-serving wezenmt-serving
	sudo docker run -it --name wezenmt-serving -p 5000:5000 \
	-v `pwd`/models:/root/models wezenmt-serving \
	--model test_transformer_model \
	--model_storage /root/models serve --host 0.0.0.0 --port 5000

log:
	sudo docker logs wezenmt-serving