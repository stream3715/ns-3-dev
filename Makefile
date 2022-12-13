# Makefile wrapper for waf
include .env

export
ifneq ($(origin DEBUG),undefined)
	NS_LOG := *=level_debug|prefix_func|prefix_time|prefix_node
endif

CS_SIZE := ${CS_SIZE}
ID_PRD := ${ID_PRD}
ID_CON_MJ := ${ID_CON_MJ}
ID_CON_MN := ${ID_CON_MN}
	
all:
	./waf

# free free to change this part to suit your requirements
configure:
	./waf configure --enable-examples --enable-tests

build:
	./waf build

install:
	./waf install

clean:
	./waf clean

distclean:
	./waf distclean

run-kademlia: all
	@env | ./waf --run=ndn-kademlia > k-${ID_PRD}-${ID_CON_MJ}-${ID_CON_MN}.log

	mkdir -p result-k/${CS_SIZE}/${ID_PRD}/${ID_CON_MJ}-${ID_CON_MN}
	rm -rf result-k/${CS_SIZE}/${ID_PRD}/${ID_CON_MJ}-${ID_CON_MN}/*

	mv app-delays-trace.tsv result-k/${CS_SIZE}/${ID_PRD}/${ID_CON_MJ}-${ID_CON_MN}/k-${CS_SIZE}-app-delays-trace-${ID_PRD}-${ID_CON_MJ}-${ID_CON_MN}.tsv
	mv drop-trace.tsv result-k/${CS_SIZE}/${ID_PRD}/${ID_CON_MJ}-${ID_CON_MN}/k-${CS_SIZE}-drop-trace-${ID_PRD}-${ID_CON_MJ}-${ID_CON_MN}.tsv
	mv rate-trace.tsv result-k/${CS_SIZE}/${ID_PRD}/${ID_CON_MJ}-${ID_CON_MN}/k-${CS_SIZE}-rate-trace-${ID_PRD}-${ID_CON_MJ}-${ID_CON_MN}.tsv
	mv k-${ID_PRD}-${ID_CON_MJ}-${ID_CON_MN}.log result-k/${CS_SIZE}/${ID_PRD}/${ID_CON_MJ}-${ID_CON_MN}/k-${CS_SIZE}-${ID_PRD}-${ID_CON_MJ}-${ID_CON_MN}.log

	./t2c.sh result-k/${CS_SIZE}/${ID_PRD}/${ID_CON_MJ}-${ID_CON_MN} k-${CS_SIZE}-app-delays-trace-${ID_PRD}-${ID_CON_MJ}-${ID_CON_MN}.tsv
	./t2c.sh result-k/${CS_SIZE}/${ID_PRD}/${ID_CON_MJ}-${ID_CON_MN} k-${CS_SIZE}-drop-trace-${ID_PRD}-${ID_CON_MJ}-${ID_CON_MN}.tsv
	./t2c.sh result-k/${CS_SIZE}/${ID_PRD}/${ID_CON_MJ}-${ID_CON_MN} k-${CS_SIZE}-rate-trace-${ID_PRD}-${ID_CON_MJ}-${ID_CON_MN}.tsv

	./stats.sh result-k/${CS_SIZE}/${ID_PRD}/${ID_CON_MJ}-${ID_CON_MN} k-${CS_SIZE}-app-delays-trace-${ID_PRD}-${ID_CON_MJ}-${ID_CON_MN}.tsv.csv

run-vanilla: all
	@env | ./waf --run=ndn-kademlia > v-${ID_PRD}-${ID_CON_MJ}-${ID_CON_MN}.log

	mkdir -p result-v/${CS_SIZE}/${ID_PRD}/${ID_CON_MJ}-${ID_CON_MN}
	rm -rf result-v/${CS_SIZE}/${ID_PRD}/${ID_CON_MJ}-${ID_CON_MN}/*

	mv app-delays-trace.tsv result-v/${CS_SIZE}/${ID_PRD}/${ID_CON_MJ}-${ID_CON_MN}/v-${CS_SIZE}-app-delays-trace-${ID_PRD}-${ID_CON_MJ}-${ID_CON_MN}.tsv
	mv drop-trace.tsv result-v/${CS_SIZE}/${ID_PRD}/${ID_CON_MJ}-${ID_CON_MN}/v-${CS_SIZE}-drop-trace-${ID_PRD}-${ID_CON_MJ}-${ID_CON_MN}.tsv
	mv rate-trace.tsv result-v/${CS_SIZE}/${ID_PRD}/${ID_CON_MJ}-${ID_CON_MN}/v-${CS_SIZE}-rate-trace-${ID_PRD}-${ID_CON_MJ}-${ID_CON_MN}.tsv
	mv v-${ID_PRD}-${ID_CON_MJ}-${ID_CON_MN}.log result-v/${CS_SIZE}/${ID_PRD}/${ID_CON_MJ}-${ID_CON_MN}/v-${CS_SIZE}-${ID_PRD}-${ID_CON_MJ}-${ID_CON_MN}.log

	./t2c.sh result-v/${CS_SIZE}/${ID_PRD}/${ID_CON_MJ}-${ID_CON_MN} v-${CS_SIZE}-app-delays-trace-${ID_PRD}-${ID_CON_MJ}-${ID_CON_MN}.tsv
	./t2c.sh result-v/${CS_SIZE}/${ID_PRD}/${ID_CON_MJ}-${ID_CON_MN} v-${CS_SIZE}-drop-trace-${ID_PRD}-${ID_CON_MJ}-${ID_CON_MN}.tsv
	./t2c.sh result-v/${CS_SIZE}/${ID_PRD}/${ID_CON_MJ}-${ID_CON_MN} v-${CS_SIZE}-rate-trace-${ID_PRD}-${ID_CON_MJ}-${ID_CON_MN}.tsv

	./stats.sh result-v/${CS_SIZE}/${ID_PRD}/${ID_CON_MJ}-${ID_CON_MN} v-${CS_SIZE}-app-delays-trace-${ID_PRD}-${ID_CON_MJ}-${ID_CON_MN}.tsv.csv

switch-vanilla:
	git checkout ndn-vanilla
	cd src/ndnSIM && git checkout ndn-vanilla && git submodule update

switch-kademlia:
	git checkout ndn-kademlia
	cd src/ndnSIM && git checkout ndn-kademlia && git submodule update