// imports

const config: HardhatUserConfig = {
    solidity: {
      compilers: [
        {
          version: "0.6.0",
          settings: {
            optimizer: {
              enabled: true,
              runs: 1000,
            },
            outputSelection: {
              "*": {
                "*": ["storageLayout"],
              },
            },
          },
        },
        // other versions
        {
          version: "0.8.11",
          settings: {
            optimizer: {
              enabled: true,
              runs: 1000,
            },
            outputSelection: {
              "*": {
                "*": ["storageLayout"],
              },
            },
          },
        },
      ],
    },
    // other properties
  };
  
  export default config;