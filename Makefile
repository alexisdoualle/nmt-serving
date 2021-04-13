run: 
	make -k r

r:  rm rn log
	
build:
	@echo "Building WezenMT serving docker"
	sudo docker build . -t wezenmt-serving

kill:
	sudo docker kill wezenmt-serving

rm:
	sudo docker rm wezenmt-serving

rn:
	sudo docker run -p 5000:5000 -v `pwd`/models:/root/models --name wezenmt-serving wezenmt-serving \
    --model_storage /root/models --model models serve --host 0.0.0.0 --port 5000

rnOLD:
	@echo "Lauching WezenMT serving docker"
	sudo docker run -it --name wezenmt-serving --gpus=all -p 5000:5000 \
	-v `pwd`/models:/root/models wezenmt-serving \
	--model istores_transformer_model \
	--model_storage /root/models serve --host 0.0.0.0 --port 5000

shell:
	sudo docker run --entrypoint bash -it --name wezenmt-serving --gpus=all -p 5000:5000 \
	-v `pwd`/models:/root/models wezenmt-serving 

log:
	sudo docker logs wezenmt-serving