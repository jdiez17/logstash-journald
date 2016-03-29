FROM jruby:1.7.21-jdk

WORKDIR /gem
RUN git clone https://github.com/logstash-plugins/logstash-input-journald.git . \
    && git reset --hard 1b017c493bd9ed7774161a5f6022575a5b2af0d3 \
    && jgem build logstash-input-journald.gemspec \
    && mv logstash-input-journald-*.gem logstash-input-journald.gem
