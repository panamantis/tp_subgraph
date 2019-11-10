require('babel-register')
require('babel-polyfill')
const HDWalletProvider = require('truffle-hdwallet-provider')

module.exports = {
  networks: {
    mainnet: {
      host: 'https://mainnet.infura.io/v3/5a2597b2866f40d3b704b8ab2cc234b8',
      port: 8545,
      network_id: '*',
    },
    ropsten: {
      provider: function() {
        return new HDWalletProvider(
          process.env.MNEMONIC,
          `https://ropsten.infura.io/v3/${process.env.ROPSTEN_INFURA_API_KEY}`
        )
      },
      network_id: '3',
    },
  },
  compilers: {
    solc: {
      version: '0.4.25'    // Fetch exact version from solc-bin (default: truffle's version)
    }
  }
}
