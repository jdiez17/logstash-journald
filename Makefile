BASE=2.0
TAG=$(BASE)-$(shell git rev-parse --short HEAD)

all: tags

gem:
	docker build -f gem.Dockerfile -t logstash-journald-gem:latest .
	docker run -v "$(shell pwd)":/context --rm logstash-journald-gem:latest bash -c 'mv logstash-input-journald.gem /context/logstash-input-journald.gem'

build: gem
	docker build -f Dockerfile -t state/logstash-journald:$(TAG) .

tags: build
	docker tag -f jdiez/logstash-journald:$(TAG) jdiez/logstash-journald:$(BASE)

push: tags
	docker push jdiez/logstash-journald:$(TAG)
	docker push jdiez/logstash-journald:$(BASE)
