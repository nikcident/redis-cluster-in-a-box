# Redis-Cluster-in-a-Box

I had a use for a redis cluster in my CI process and thought it would be even easier if it were all in a single container, so here it is.

This is 100% not for production use.


Usage:
```
docker build -t clusterinabox .

docker run -d -p 6379:6379 -p 6380:6380 -p 6381:6381 clusterinabox
```
