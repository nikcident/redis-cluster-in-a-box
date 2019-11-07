FROM redis:5-alpine

ADD redis.conf.template /conf/redis.conf.template

RUN set -ex \
    && chown -R redis:redis /conf \
    # Template out all of the config files
    && for i in $(seq 6379 6381); do sed "s/<port>/$i/g" /conf/redis.conf.template > /conf/redis-$i.conf; done \
    # Start 3 redis nodes in the background
    && redis-server /conf/redis-6379.conf --daemonize yes \
    && redis-server /conf/redis-6380.conf --daemonize yes \
    && redis-server /conf/redis-6381.conf --daemonize yes \ 
    # Create the cluster
    && redis-cli --cluster create 127.0.0.1:6379 127.0.0.1:6380 127.0.0.1:6381 --cluster-replicas 0 --cluster-yes 

EXPOSE 6379 6380 6381

CMD redis-server /conf/redis-6379.conf --daemonize yes; redis-server /conf/redis-6380.conf --daemonize yes; redis-server /conf/redis-6381.conf
