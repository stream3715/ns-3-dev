# Makefile wrapper for waf

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
	export CS_SIZE=${CS_SIZE}
	export ID_PRD=${ID_PRD}
	export ID_CON_MJ=${ID_CON_MJ}
	export ID_CON_MN=${ID_CON_MN}
	ifneq ($(origin DEBUG), undefined)
		export NS_LOG="*=level_debug|prefix_func|prefix_time|prefix_node"
	
	./waf --run=ndn-kademlia > k-${ID_PRD}-${ID_CON_MJ}-${ID_CON_MN}.log

	mkdir -p result-k/${CS_SIZE}/${ID_PRD}/${ID_CON_MJ}-${ID_CON_MN}
	rm -rf result-k/${CS_SIZE}/${ID_PRD}/${ID_CON_MJ}-${ID_CON_MN}/*

	mv app-delays-trace.tsv result-k/${CS_SIZE}/${ID_PRD}/${ID_CON_MJ}-${ID_CON_MN}/k-${CS_SIZE}-app-delays-trace-${ID_PRD}-${ID_CON_MJ}-${ID_CON_MN}.tsv
	mv drop-trace.tsv result-k/${CS_SIZE}/${ID_PRD}/${ID_CON_MJ}-${ID_CON_MN}/k-${CS_SIZE}-drop-trace-${ID_PRD}-${ID_CON_MJ}-${ID_CON_MN}.tsv
	mv rate-trace.tsv result-k/${CS_SIZE}/${ID_PRD}/${ID_CON_MJ}-${ID_CON_MN}/k-${CS_SIZE}-rate-trace-${ID_PRD}-${ID_CON_MJ}-${ID_CON_MN}.tsv
	mv k-${ID_PRD}-${ID_CON_MJ}-${ID_CON_MN}.log result-k/${CS_SIZE}/${ID_PRD}/${ID_CON_MJ}-${ID_CON_MN}/k-${CS_SIZE}-${ID_PRD}-${ID_CON_MJ}-${ID_CON_MN}.log

	cd result-k/${CS_SIZE}/${ID_PRD}/${ID_CON_MJ}-${ID_CON_MN}
	t2c k-${CS_SIZE}-app-delays-trace-${ID_PRD}-${ID_CON_MJ}-${ID_CON_MN}.tsv
	t2c k-${CS_SIZE}-drop-trace-${ID_PRD}-${ID_CON_MJ}-${ID_CON_MN}.tsv
	t2c k-${CS_SIZE}-rate-trace-${ID_PRD}-${ID_CON_MJ}-${ID_CON_MN}.tsv

run-vanilla: all
	export CS_SIZE=${CS_SIZE}
	export ID_PRD=${ID_PRD}
	export ID_CON_MJ=${ID_CON_MJ}
	export ID_CON_MN=${ID_CON_MN}
	ifneq ($(origin DEBUG), undefined)
		export NS_LOG="*=level_debug|prefix_func|prefix_time|prefix_node"
	
	./waf --run=ndn-vanilla > v-${ID_PRD}-${ID_CON_MJ}-${ID_CON_MN}.log

	mkdir -p result-v/${CS_SIZE}/${ID_PRD}/${ID_CON_MJ}-${ID_CON_MN}
	rm -rf result-v/${CS_SIZE}/${ID_PRD}/${ID_CON_MJ}-${ID_CON_MN}/*

	mv app-delays-trace.tsv result-v/${CS_SIZE}/${ID_PRD}/${ID_CON_MJ}-${ID_CON_MN}/k-${CS_SIZE}-app-delays-trace-${ID_PRD}-${ID_CON_MJ}-${ID_CON_MN}.tsv
	mv drop-trace.tsv result-v/${CS_SIZE}/${ID_PRD}/${ID_CON_MJ}-${ID_CON_MN}/k-${CS_SIZE}-drop-trace-${ID_PRD}-${ID_CON_MJ}-${ID_CON_MN}.tsv
	mv rate-trace.tsv result-v/${CS_SIZE}/${ID_PRD}/${ID_CON_MJ}-${ID_CON_MN}/k-${CS_SIZE}-rate-trace-${ID_PRD}-${ID_CON_MJ}-${ID_CON_MN}.tsv
	mv v-${ID_PRD}-${ID_CON_MJ}-${ID_CON_MN}.log result-v/${CS_SIZE}/${ID_PRD}/${ID_CON_MJ}-${ID_CON_MN}/k-${CS_SIZE}-${ID_PRD}-${ID_CON_MJ}-${ID_CON_MN}.log

	cd result-v/${CS_SIZE}/${ID_PRD}/${ID_CON_MJ}-${ID_CON_MN}
	t2c v-${CS_SIZE}-app-delays-trace-${ID_PRD}-${ID_CON_MJ}-${ID_CON_MN}.tsv
	t2c v-${CS_SIZE}-drop-trace-${ID_PRD}-${ID_CON_MJ}-${ID_CON_MN}.tsv
	t2c v-${CS_SIZE}-rate-trace-${ID_PRD}-${ID_CON_MJ}-${ID_CON_MN}.tsv


switch-vanilla:
	git checkout ndn-vanilla
	cd src/ndnSIM
	git checkout ndn-vanilla
	git submodule update

switch-kademlia:
	git checkout ndn-kademlia
	cd src/ndnSIM
	git checkout ndn-kademlia
	git submodule update