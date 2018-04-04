# Pretent to be broken memcache

After a number of attacks we found memcache was breaking causing no end of trouble... I haistlily put this together to try and replicate the error we were seeing.

Stop memcached, find the process id `ps auxf | grep memcache` then kill it `kill MEMCACHE_PROCESS_ID_WHATEVER_THAT_IS` now verify the website still works, the webapp should detect the loss of memcache and continue to operate without the caching system. Finally run the script in this repo which listens on the memcache port 11211 and fails to respond mimicking the errors we were seeing on production.
