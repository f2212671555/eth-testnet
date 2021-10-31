FROM ubuntu:latest
 # Get the Ethereum Stuffs
 RUN apt-get update \
    && apt-get install -y software-properties-common \
    && apt-get install -y build-essential git \
    && add-apt-repository ppa:longsleep/golang-backports \
    && apt-get install -y golang-go
RUN git clone https://github.com/ethereum/go-ethereum
WORKDIR /go-ethereum
RUN make geth
RUN ln -sf /go-ethereum/build/bin/geth /bin/geth
RUN add-apt-repository -y ppa:ethereum/ethereum
RUN apt-get install bootnode 

WORKDIR /
# House the data here
COPY bootnode bootnode
COPY miner1 miner1
COPY miner2 miner2
COPY miner3 miner3
# Pass in the genesis block.
COPY genesis.json genesis.json

# port -> 3000
# network -> 49021
# init and start node
EXPOSE 22 8088 50070 8545
# https://geth.ethereum.org/docs/interface/command-line-options
# ENTRYPOINT geth --datadir /node/data init /genesis.json;
