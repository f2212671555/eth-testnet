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
WORKDIR /
# House the data here
RUN mkdir /block-data
# Pass in the genesis block.
COPY genesis.json genesis.json
RUN ln -sf /go-ethereum/build/bin/geth /bin/geth
EXPOSE 22 8088 50070 8545

# port -> 3000
# network -> 66
# --maxpeers -> total number of connection
# --nodiscover -> each node will not find each other; need to add other node manually.
# --rpc -> active http json-rpc
# --rpcaddr 0.0.0.0 --rpcport 8545
# --rpccorsdomain "*" -> CORS
# --rpcapi "eth,net,web3,personal,miner" -> provides some api
# --nousb -> disable monitoring and management of USB hardware wallets.
# --allow-insecure-unlock -> do not unlock account, when I access a node with geth via http protocol
# --dev -> development mode
ENTRYPOINT geth --datadir /block-data init /genesis.json; geth --port 3000 --networkid 66 --nodiscover --datadir=/block-data --maxpeers=0  --rpc  --rpcaddr 0.0.0.0 --rpcport 8545 --rpccorsdomain "*" --rpcapi "eth,net,web3,personal,miner" --nousb --allow-insecure-unlock --dev