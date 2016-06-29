.PHONY: image clean

IMAGE_NAME = timezonetravel

image: .image.made

.image.made: Dockerfile entrypoint.sh _bashrc
	docker build -t $(IMAGE_NAME) .
	touch .image.made

clean:
	-docker rmi $(IMAGE_NAME)
	-rm .*.made


