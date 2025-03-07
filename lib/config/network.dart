import 'package:tlend_app/config/contracts.dart';
import 'package:tlend_app/config/const.dart';

class NetworkConfig {
  const NetworkConfig(
      {required this.chainId,
      required this.chainName,
      required this.nativeCurrency,
      required this.apiUrl,
      required this.blockExplorerUrl,
      required this.logoPath,
      required this.contracts,
      this.mainId});
  final int chainId;
  final int? mainId;
  final String chainName;
  final String nativeCurrency;
  final List<String> apiUrl;
  final String blockExplorerUrl;
  final String logoPath;
  final Map<String, String> contracts;
}

class ActiveChains {
  static const NetworkConfig ethereum = NetworkConfig(
    chainId: 1,
    chainName: 'Ethereum',
    nativeCurrency: 'ETH',
    apiUrl: [
      'https://mainnet.infura.io/v3/1c177df366ef47b689e8b84ee6c7297d',
      'https://eth.llamarpc.com',
    ],
    blockExplorerUrl: 'https://etherscan.io',
    logoPath: 'icons/networks/ethereum.svg',
    // logoPath: 'icons/networks/1.png',
    contracts: Contracts.ethereum,
  );
  static const NetworkConfig arbitrum = NetworkConfig(
    chainId: 42161,
    chainName: 'Arbitrum',
    nativeCurrency: 'ETH',
    apiUrl: [
      'https://arb1.arbitrum.io/rpc',
      'https://arbitrum-mainnet.infura.io/v3/1c177df366ef47b689e8b84ee6c7297d'
    ],
    blockExplorerUrl: 'https://arbiscan.io',
    logoPath: 'icons/networks/arbitrum.svg',
    contracts: Contracts.arbitrum,
  );
  static const NetworkConfig optimism = NetworkConfig(
    chainId: 10,
    chainName: 'Optimism',
    nativeCurrency: 'ETH',
    apiUrl: [
      'https://mainnet.optimism.io',
      'https://optimism-mainnet.infura.io/v3/1c177df366ef47b689e8b84ee6c7297d'
    ],
    blockExplorerUrl: 'https://optimistic.etherscan.io',
    logoPath: 'icons/networks/optimism.svg',
    contracts: Contracts.optimism,
  );
  static const NetworkConfig basechain = NetworkConfig(
    chainId: 1337,
    chainName: 'base',
    nativeCurrency: 'ETH',
    apiUrl: ['https://mainnet.base.org'],
    blockExplorerUrl: 'https://basescan.org',
    logoPath: 'icons/networks/base.svg',
    contracts: Contracts.basechain,
  );
  static const NetworkConfig bsc = NetworkConfig(
    chainId: 56,
    chainName: 'Binance',
    nativeCurrency: 'BNB',
    apiUrl: ['https://bsc-dataseed.binance.org'],
    blockExplorerUrl: 'https://bscscan.com',
    logoPath: 'icons/networks/binance.svg',
    contracts: Contracts.bsc,
  );
  static const NetworkConfig polygon = NetworkConfig(
    chainId: 137,
    chainName: 'Polygon',
    nativeCurrency: 'MATIC',
    apiUrl: ['https://rpc-mainnet.maticvigil.com'],
    blockExplorerUrl: 'https://polygonscan.com',
    logoPath: 'icons/networks/polygon.svg',
    contracts: Contracts.polygon,
  );
  static const NetworkConfig avalanche = NetworkConfig(
    chainId: 43114,
    chainName: 'Avalanche',
    nativeCurrency: 'AVAX',
    apiUrl: [
      'https://api.avax.network/ext/bc/C/rpc',
      'https://avalanche-mainnet.infura.io/v3/1c177df366ef47b689e8b84ee6c7297d'
    ],
    blockExplorerUrl: 'https://cchain.explorer.avax.network',
    logoPath: 'icons/networks/avalanche.svg',
    contracts: Contracts.avalanche,
  );
  static const NetworkConfig fantom = NetworkConfig(
    chainId: 250,
    chainName: 'Fantom',
    nativeCurrency: 'FTM',
    apiUrl: ['https://rpcapi.fantom.network'],
    blockExplorerUrl: 'https://ftmscan.com',
    logoPath: 'icons/networks/fantom.svg',
    contracts: Contracts.fantom,
  );
}

class TestNetworks {
  static const NetworkConfig ethereumSepolia = NetworkConfig(
    chainId: 11155111,
    mainId: 1,
    chainName: 'Ethereum sepolia',
    nativeCurrency: 'ETH',
    apiUrl: [
      'https://sepolia.infura.io/v3/1c177df366ef47b689e8b84ee6c7297d',
      'https://1rpc.io/sepolia',
    ],
    blockExplorerUrl: 'https://rinkeby.etherscan.io',
    logoPath: 'icons/networks/ethereum.svg',
    contracts: Contracts.ethereumSepolia,
  );
  static const NetworkConfig arbitrumSepolia = NetworkConfig(
    chainId: 421614,
    mainId: 42161,
    chainName: 'Arbitrum Sepolia',
    nativeCurrency: 'ETH',
    apiUrl: [
      'https://arb1-sepolia.arbitrum.io/rpc',
      'https://arbitrum-sepolia.infura.io/v3/1c177df366ef47b689e8b84ee6c7297d'
    ],
    blockExplorerUrl: 'https://sepolia.arbiscan.io',
    logoPath: 'icons/networks/arbitrum.svg',
    contracts: Contracts.arbitrumSepolia,
  );
  static const NetworkConfig optimismSepolia = NetworkConfig(
    chainId: 100,
    mainId: 10,
    chainName: 'Optimism Sepolia',
    nativeCurrency: 'ETH',
    apiUrl: [
      'https://optimism-sepolia.infura.io/v3/1c177df366ef47b689e8b84ee6c7297d'
    ],
    blockExplorerUrl: 'https://sepolia-optimism.etherscan.io',
    logoPath: 'icons/networks/optimism.svg',
    contracts: Contracts.optimismSepolia,
  );
  static const NetworkConfig basechainSepolia = NetworkConfig(
    chainId: 13371,
    mainId: 1337,
    chainName: 'base Sepolia',
    nativeCurrency: 'ETH',
    apiUrl: ['https://sepolia.base.org'],
    blockExplorerUrl: '	https://sepolia-explorer.base.org',
    logoPath: 'icons/networks/base.svg',
    contracts: Contracts.basechainSepolia,
  );
  static const NetworkConfig bscTest = NetworkConfig(
    chainId: 97,
    mainId: 56,
    chainName: 'Binance Smart Chain Testnet',
    nativeCurrency: 'BNB',
    apiUrl: [
      'https://opbnb-testnet-rpc.bnbchain.org/',
      'https://data-seed-prebsc-1-s1.binance.org:8545'
    ],
    blockExplorerUrl: 'https://testnet.bscscan.com',
    logoPath: 'icons/networks/binance.svg',
    contracts: Contracts.bscTest,
  );
  static const NetworkConfig mumbai = NetworkConfig(
    chainId: 80001,
    mainId: 137,
    chainName: 'Mumbai Testnet',
    nativeCurrency: 'MATIC',
    apiUrl: ['https://rpc-mumbai.matic.today'],
    blockExplorerUrl: 'https://mumbai.polygonscan.com',
    logoPath: 'icons/networks/polygon.svg',
    contracts: Contracts.mumbai,
  );
  static const NetworkConfig fuji = NetworkConfig(
    chainId: 43113,
    mainId: 43114,
    chainName: 'Fuji C-Chain',
    nativeCurrency: 'AVAX',
    apiUrl: ['https://api.avax-test.network/ext/bc/C/rpc'],
    blockExplorerUrl: 'https://cchain.explorer.avax-test.network',
    logoPath: 'icons/networks/avalanche.svg',
    contracts: Contracts.fuji,
  );
  static const NetworkConfig fantomTest = NetworkConfig(
    chainId: 4002,
    mainId: 250,
    chainName: 'Fantom Testnet',
    nativeCurrency: 'FTM',
    apiUrl: ['https://rpc.testnet.fantom.network'],
    blockExplorerUrl: 'https://explorer.testnet.fantom.network',
    logoPath: 'icons/networks/fantom.svg',
    contracts: Contracts.fantomTest,
  );
}

Map<int, NetworkConfig> activeNetworks = {
  ActiveChains.ethereum.chainId: ActiveChains.ethereum,
  ActiveChains.arbitrum.chainId: ActiveChains.arbitrum,
  ActiveChains.optimism.chainId: ActiveChains.optimism,
  ActiveChains.basechain.chainId: ActiveChains.basechain,
  ActiveChains.bsc.chainId: ActiveChains.bsc,
  ActiveChains.polygon.chainId: ActiveChains.polygon,
  ActiveChains.avalanche.chainId: ActiveChains.avalanche,
  ActiveChains.fantom.chainId: ActiveChains.fantom,
};

Map<int, NetworkConfig> testNetworks = {
  TestNetworks.ethereumSepolia.chainId: TestNetworks.ethereumSepolia,
  TestNetworks.arbitrumSepolia.chainId: TestNetworks.arbitrumSepolia,
  TestNetworks.optimismSepolia.chainId: TestNetworks.optimismSepolia,
  TestNetworks.basechainSepolia.chainId: TestNetworks.basechainSepolia,
  TestNetworks.bscTest.chainId: TestNetworks.bscTest,
  TestNetworks.mumbai.chainId: TestNetworks.mumbai,
  TestNetworks.fuji.chainId: TestNetworks.fuji,
  TestNetworks.fantomTest.chainId: TestNetworks.fantomTest,
};

List<NetworkConfig> networkList = [
  ActiveChains.ethereum,
  ActiveChains.arbitrum,
  ActiveChains.optimism,
  ActiveChains.basechain,
  ActiveChains.bsc,
  ActiveChains.polygon,
  ActiveChains.avalanche,
  ActiveChains.fantom,
];

List<NetworkConfig> testNetworkList = [
  TestNetworks.ethereumSepolia,
  TestNetworks.arbitrumSepolia,
  TestNetworks.optimismSepolia,
  TestNetworks.basechainSepolia,
  TestNetworks.bscTest,
  TestNetworks.mumbai,
  TestNetworks.fuji,
  TestNetworks.fantomTest,
];

List<int> suportedNetworks = [
  ChainId.ethereum.id,
  ChainId.ethereumSepolia.id,
];

Map<int, NetworkConfig> allNetworks = {
  ...activeNetworks,
  ...testNetworks,
};

// declare const POOL_ADDRESSES_PROVIDER = "0x012bAC54348C0E635dCAc9D5FB99f06F24136C9A";
// declare const POOL = "0x6Ae43d3271ff6888e7Fc43Fd7321a503ff738951";
// declare const POOL_CONFIGURATOR = "0x7Ee60D184C24Ef7AfC1Ec7Be59A0f448A0abd138";
// declare const ORACLE = "0x2da88497588bf89281816106C7259e31AF45a663";
// declare const PRICE_ORACLE_SENTINEL = "0x0000000000000000000000000000000000000000";
// declare const AAVE_PROTOCOL_DATA_PROVIDER = "0x3e9708d80f7B3e43118013075F7e95CE3AB31F31";
// declare const ACL_MANAGER = "0x7F2bE3b178deeFF716CD6Ff03Ef79A1dFf360ddD";
// declare const ACL_ADMIN = "0xfA0e305E0f46AB04f00ae6b5f4560d61a2183E00";
// declare const COLLECTOR = "0x604264f8017fEF3b11B3dD63537CB501560380B5";
// declare const DEFAULT_INCENTIVES_CONTROLLER = "0x4DA5c4da71C5a167171cC839487536d86e083483";
// declare const DEFAULT_A_TOKEN_IMPL_REV_1 = "0x48424f2779be0f03cDF6F02E17A591A9BF7AF89f";
// declare const DEFAULT_VARIABLE_DEBT_TOKEN_IMPL_REV_1 = "0x54bdE009156053108E73E2401aEA755e38f92098";
// declare const DEFAULT_STABLE_DEBT_TOKEN_IMPL_REV_1 = "0xd1CF2FBf4fb82045eE0B116eB107d29246E8DCe9";
// declare const EMISSION_MANAGER = "0x098a890BAfDf6FB4ACD24bF107D20EA15D229C62";
// declare const FAUCET = "0xC959483DBa39aa9E78757139af0e9a2EDEb3f42D";
// declare const UI_INCENTIVE_DATA_PROVIDER = "0xBA25de9a7DC623B30799F33B770d31B44c2C3b77";
// declare const UI_POOL_DATA_PROVIDER = "0x69529987FA4A075D0C00B0128fa848dc9ebbE9CE";
// declare const WALLET_BALANCE_PROVIDER = "0xCD4e0d6D2b1252E2A709B8aE97DBA31164C5a709";
// declare const WETH_GATEWAY = "0x387d311e47e80b498169e6fb51d3193167d89F7D";
// declare const STATIC_A_TOKEN_FACTORY = "0xd210dFB43B694430B8d31762B5199e30c31266C8";
// declare const UI_GHO_DATA_PROVIDER = "0x69B9843A16a6E9933125EBD97659BA3CCbE2Ef8A";
// declare const CHAIN_ID = 11155111;
// declare const ASSETS: {
//     readonly DAI: {
//         readonly decimals: 18;
//         readonly UNDERLYING: "0xFF34B3d4Aee8ddCd6F9AFFFB6Fe49bD371b8a357";
//         readonly A_TOKEN: "0x29598b72eb5CeBd806C5dCD549490FdA35B13cD8";
//         readonly S_TOKEN: "0xbEF786E742edB13361ff2f005b901A82c23AA491";
//         readonly V_TOKEN: "0x22675C506A8FC26447aFFfa33640f6af5d4D4cF0";
//         readonly INTEREST_RATE_STRATEGY: "0xA813CC4d67821fbAcF24659e414A1Cf6c551373c";
//         readonly ORACLE: "0x9aF11c35c5d3Ae182C0050438972aac4376f9516";
//         readonly STATA_TOKEN: "0xDE46e43F46ff74A23a65EBb0580cbe3dFE684a17";
//     };
//     readonly LINK: {
//         readonly decimals: 18;
//         readonly UNDERLYING: "0xf8Fb3713D459D7C1018BD0A49D19b4C44290EBE5";
//         readonly A_TOKEN: "0x3FfAf50D4F4E96eB78f2407c090b72e86eCaed24";
//         readonly S_TOKEN: "0x8f7440aa789924626ab9f5687AF305da2ffB996b";
//         readonly V_TOKEN: "0x34a4d932E722b9dFb492B9D8131127690CE2430B";
//         readonly INTEREST_RATE_STRATEGY: "0xCA30c502d52F905FB3D04eE60cA48F5A1A89f8dB";
//         readonly ORACLE: "0x14fC51b7df22b4D393cD45504B9f0A3002A63F3F";
//         readonly STATA_TOKEN: "0x8227a989709a757f25dF251C3C3e71CA38627836";
//     };
//     readonly USDC: {
//         readonly decimals: 6;
//         readonly UNDERLYING: "0x94a9D9AC8a22534E3FaCa9F4e7F2E2cf85d5E4C8";
//         readonly A_TOKEN: "0x16dA4541aD1807f4443d92D26044C1147406EB80";
//         readonly S_TOKEN: "0x42A218F7bd03c63c4835496506492A383EfcF726";
//         readonly V_TOKEN: "0x36B5dE936eF1710E1d22EabE5231b28581a92ECc";
//         readonly INTEREST_RATE_STRATEGY: "0x5CB1008969a2d5FAcE8eF32732e6A306d0D0EF2A";
//         readonly ORACLE: "0x98458D6A99489F15e6eB5aFa67ACFAcf6F211051";
//         readonly STATA_TOKEN: "0x8A88124522dbBF1E56352ba3DE1d9F78C143751e";
//     };
//     readonly WBTC: {
//         readonly decimals: 8;
//         readonly UNDERLYING: "0x29f2D40B0605204364af54EC677bD022dA425d03";
//         readonly A_TOKEN: "0x1804Bf30507dc2EB3bDEbbbdd859991EAeF6EefF";
//         readonly S_TOKEN: "0xc7AEA6Cf353b4FA27aBf1b4A8D536A4e87383EB5";
//         readonly V_TOKEN: "0xEB016dFd303F19fbDdFb6300eB4AeB2DA7Ceac37";
//         readonly INTEREST_RATE_STRATEGY: "0xCA30c502d52F905FB3D04eE60cA48F5A1A89f8dB";
//         readonly ORACLE: "0x784B90bA1E9a8cf3C9939c2e072F058B024C4b8a";
//         readonly STATA_TOKEN: "0x131a121bda71ED810bCAf2aC9079214925e59C18";
//     };
//     readonly WETH: {
//         readonly decimals: 18;
//         readonly UNDERLYING: "0xC558DBdd856501FCd9aaF1E62eae57A9F0629a3c";
//         readonly A_TOKEN: "0x5b071b590a59395fE4025A0Ccc1FcC931AAc1830";
//         readonly S_TOKEN: "0xEb45D5A0efF06fFb88f6A70811c08375A8de84A3";
//         readonly V_TOKEN: "0x22a35DB253f4F6D0029025D6312A3BdAb20C2c6A";
//         readonly INTEREST_RATE_STRATEGY: "0xCA30c502d52F905FB3D04eE60cA48F5A1A89f8dB";
//         readonly ORACLE: "0xDde0E8E6d3653614878Bf5009EDC317BC129fE2F";
//         readonly STATA_TOKEN: "0x162B500569F42D9eCe937e6a61EDfef660A12E98";
//     };
//     readonly USDT: {
//         readonly decimals: 6;
//         readonly UNDERLYING: "0xaA8E23Fb1079EA71e0a56F48a2aA51851D8433D0";
//         readonly A_TOKEN: "0xAF0F6e8b0Dc5c913bbF4d14c22B4E78Dd14310B6";
//         readonly S_TOKEN: "0xEAF54fA3b1C7243033C2893c6B807f9cEaBCf0AF";
//         readonly V_TOKEN: "0x9844386d29EEd970B9F6a2B9a676083b0478210e";
//         readonly INTEREST_RATE_STRATEGY: "0x5CB1008969a2d5FAcE8eF32732e6A306d0D0EF2A";
//         readonly ORACLE: "0x4e86D3Aa271Fa418F38D7262fdBa2989C94aa5Ba";
//         readonly STATA_TOKEN: "0x978206fAe13faF5a8d293FB614326B237684B750";
//     };
//     readonly AAVE: {
//         readonly decimals: 18;
//         readonly UNDERLYING: "0x88541670E55cC00bEEFD87eB59EDd1b7C511AC9a";
//         readonly A_TOKEN: "0x6b8558764d3b7572136F17174Cb9aB1DDc7E1259";
//         readonly S_TOKEN: "0x4F15CaD6ebAE920a773bF00C6E941cccCB704915";
//         readonly V_TOKEN: "0xf12fdFc4c631F6D361b48723c2F2800b84B519e6";
//         readonly INTEREST_RATE_STRATEGY: "0xCA30c502d52F905FB3D04eE60cA48F5A1A89f8dB";
//         readonly ORACLE: "0xda678Ef100c13504edDb8a228A1e8e4CB139f189";
//         readonly STATA_TOKEN: "0x56771cEF0cb422e125564CcCC98BB05fdc718E77";
//     };
//     readonly EURS: {
//         readonly decimals: 2;
//         readonly UNDERLYING: "0x6d906e526a4e2Ca02097BA9d0caA3c382F52278E";
//         readonly A_TOKEN: "0xB20691021F9AcED8631eDaa3c0Cd2949EB45662D";
//         readonly S_TOKEN: "0x08878209484D8178DD1FFA50AB1689F21aDBB856";
//         readonly V_TOKEN: "0x94482C7A7477196259D8a0f74fB853277Fa5a75b";
//         readonly INTEREST_RATE_STRATEGY: "0x5CB1008969a2d5FAcE8eF32732e6A306d0D0EF2A";
//         readonly ORACLE: "0xCbE15C1f40f1D7eE1De3756D1557d5Fdc2A50bBD";
//         readonly STATA_TOKEN: "0x72B49a461900e11632C95dfa563e7173438D4e3E";
//     };
//     readonly GHO: {
//         readonly decimals: 18;
//         readonly UNDERLYING: "0xc4bF5CbDaBE595361438F8c6a187bDc330539c60";
//         readonly A_TOKEN: "0xd190eF37dB51Bb955A680fF1A85763CC72d083D4";
//         readonly S_TOKEN: "0xdCA691FB9609aB814E59c62d70783da1c056A9b6";
//         readonly V_TOKEN: "0x67ae46EF043F7A4508BD1d6B94DB6c33F0915844";
//         readonly INTEREST_RATE_STRATEGY: "0x521247B4d0a51E71DE580dA2cBF99EB40a44b3Bf";
//         readonly ORACLE: "0x00f7fecFAEbEd9499e1f3f9d04E755a21E5fc47C";
//         readonly STATA_TOKEN: "0x0000000000000000000000000000000000000000";
//     };
// };
// enum E_MODES: {
//     readonly NONE: 0;
//     readonly STABLECOINS: 1;
// };