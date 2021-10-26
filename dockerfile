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

WORKDIR /
# House the data here
COPY genesis .
# Pass in the genesis block.
COPY clique_genesis.json genesis.json

# port -> 3000
# network -> 49021
# init and start node
EXPOSE 22 8088 50070 8545
# https://geth.ethereum.org/docs/interface/command-line-options
ENTRYPOINT geth --datadir /genesis/data init /genesis.json; geth --port 3000 --networkid 49021 --nodiscover --datadir=/genesis/data --maxpeers=0  --http  --http.addr 0.0.0.0 --http.port 8545 --http.corsdomain "*" --http.api "eth,net,web3,personal,miner" --nousb --allow-insecure-unlock