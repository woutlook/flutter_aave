import 'dart:convert';
import 'package:tlend_app/config/tokenlist.dart';

class Asset {
  final String name;
  final String symbol;
  final int decimals;
  final String underlying;
  final String aToken;
  final String sToken;
  final String vToken;
  final String interestRateStrategy;
  final String oracle;
  final String stataToken;
  final String logoPath;
  Asset({
    required this.name,
    required this.symbol,
    required this.decimals,
    required this.underlying,
    required this.aToken,
    required this.sToken,
    required this.vToken,
    required this.interestRateStrategy,
    required this.oracle,
    required this.stataToken,
    required this.logoPath,
  });
}

Map<String, Asset> ethereumAssets = {
  'WETH': Asset(
    name: 'Wrapped Ether',
    symbol: 'WETH',
    decimals: 18,
    underlying: '0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2',
    aToken: '0x4d5F47FA6A74757f35C14fD3a6Ef8E3C9BC514E8',
    sToken: '0x102633152313C81cD80419b6EcF66d14Ad68949A',
    vToken: '0xeA51d7853EEFb32b6ee06b1C12E6dcCA88Be0fFE',
    interestRateStrategy: '0xA901Bf68Bebde17ba382e499C3e9EbAe649DF276',
    oracle: '0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419',
    stataToken: '0x252231882FB38481497f3C767469106297c8d93b',
    logoPath: "assets/icons/tokens/eth.svg",
  ),
  'wstETH': Asset(
    name: 'Liquid staked Ether 2.0',
    symbol: 'wstETH',
    decimals: 18,
    underlying: '0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0',
    aToken: '0x0B925eD163218f6662a35e0f0371Ac234f9E9371',
    sToken: '0x39739943199c0fBFe9E5f1B5B160cd73a64CB85D',
    vToken: '0xC96113eED8cAB59cD8A66813bCB0cEb29F06D2e4',
    interestRateStrategy: '0x7b8Fa4540246554e77FCFf140f9114de00F8bB8D',
    oracle: '0x8B6851156023f4f5A66F68BEA80851c3D905Ac93',
    stataToken: '0x322AA5F5Be95644d6c36544B6c5061F072D16DF5',
    logoPath: "assets/icons/tokens/wsteth.svg",
  ),
  'WBTC': Asset(
    name: 'Wrapped Bitcoin',
    symbol: 'WBTC',
    decimals: 8,
    underlying: '0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599',
    aToken: '0x5Ee5bf7ae06D1Be5997A1A72006FE6C607eC6DE8',
    sToken: '0xA1773F1ccF6DB192Ad8FE826D15fe1d328B03284',
    vToken: '0x40aAbEf1aa8f0eEc637E0E7d92fbfFB2F26A8b7B',
    interestRateStrategy: '0x07Fa3744FeC271F80c2EA97679823F65c13CCDf4',
    oracle: '0x230E0321Cf38F09e247e50Afc7801EA2351fe56F',
    stataToken: '0x0000000000000000000000000000000000000000',
    logoPath: "assets/icons/tokens/wbtc.svg",
  ),
  'USDC': Asset(
    name: 'USD Coin',
    symbol: 'USDC',
    decimals: 6,
    underlying: '0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48',
    aToken: '0x98C23E9d8f34FEFb1B7BD6a91B7FF122F4e16F5c',
    sToken: '0xB0fe3D292f4bd50De902Ba5bDF120Ad66E9d7a39',
    vToken: '0x72E95b8931767C79bA4EeE721354d6E99a61D004',
    interestRateStrategy: '0x642a8DAcC59b73491Dcaa3BCeF046D660901fCc1',
    oracle: '0x8fFfFfd4AfB6115b954Bd326cbe7B4BA576818f6',
    stataToken: '0x73edDFa87C71ADdC275c2b9890f5c3a8480bC9E6',
    logoPath: "assets/icons/tokens/usdc.svg",
  ),
  'DAI': Asset(
    name: 'Dai Stablecoin',
    symbol: 'DAI',
    decimals: 18,
    underlying: '0x6B175474E89094C44Da98b954EedeAC495271d0F',
    aToken: '0x018008bfb33d285247A21d44E50697654f754e63',
    sToken: '0x413AdaC9E2Ef8683ADf5DDAEce8f19613d60D1bb',
    vToken: '0xcF8d0c70c850859266f5C338b38F9D663181C314',
    interestRateStrategy: '0x2402C25e7E45b1466c53Ef7766AAd878A4CbC237',
    oracle: '0xAed0c38402a5d19df6E4c03F4E2DceD6e29c1ee9',
    stataToken: '0xaf270C38fF895EA3f95Ed488CEACe2386F038249',
    logoPath: "assets/icons/tokens/dai.svg",
  ),
  'LINK': Asset(
    name: 'ChainLink Token',
    symbol: 'LINK',
    decimals: 18,
    underlying: '0x514910771AF9Ca656af840dff83E8264EcF986CA',
    aToken: '0x5E8C8A7243651DB1384C0dDfDbE39761E8e7E51a',
    sToken: '0x63B1129ca97D2b9F97f45670787Ac12a9dF1110a',
    vToken: '0x4228F8895C7dDA20227F6a5c6751b8Ebf19a6ba8',
    interestRateStrategy: '0x24701A6368Ff6D2874d6b8cDadd461552B8A5283',
    oracle: '0x2c1d072e956AFFC0D435Cb7AC38EF18d24d9127c',
    stataToken: '0x0000000000000000000000000000000000000000',
    logoPath: "assets/icons/tokens/link.svg",
  ),
  'AAVE': Asset(
    name: 'Aave',
    symbol: 'AAVE',
    decimals: 18,
    underlying: '0x7Fc66500c84A76Ad7e9c93437bFc5Ac33E2DDaE9',
    aToken: '0xA700b4eB416Be35b2911fd5Dee80678ff64fF6C9',
    sToken: '0x268497bF083388B1504270d0E717222d3A87D6F2',
    vToken: '0xBae535520Abd9f8C85E58929e0006A2c8B372F74',
    interestRateStrategy: '0x24701A6368Ff6D2874d6b8cDadd461552B8A5283',
    oracle: '0x547a514d5e3769680Ce22B2361c10Ea13619e8a9',
    stataToken: '0x0000000000000000000000000000000000000000',
    logoPath: "assets/icons/tokens/aave.svg",
  ),
  'cbETH': Asset(
    name: 'Coinbase Wrapped Staked ETH',
    symbol: 'cbETH',
    decimals: 18,
    underlying: '0xBe9895146f7AF43049ca1c1AE358B0541Ea49704',
    aToken: '0x977b6fc5dE62598B08C85AC8Cf2b745874E8b78c',
    sToken: '0x82bE6012cea6D147B968eBAea5ceEcF6A5b4F493',
    vToken: '0x0c91bcA95b5FE69164cE583A2ec9429A569798Ed',
    interestRateStrategy: '0x24701A6368Ff6D2874d6b8cDadd461552B8A5283',
    oracle: '0x5f4d15d761528c57a5C30c43c1DAb26Fc5452731',
    stataToken: '0x0000000000000000000000000000000000000000',
    logoPath: "assets/icons/tokens/cbeth.svg",
  ),
  'USDT': Asset(
    name: 'Tether USD',
    symbol: 'USDT',
    decimals: 6,
    underlying: '0xdAC17F958D2ee523a2206206994597C13D831ec7',
    aToken: '0x23878914EFE38d27C4D67Ab83ed1b93A74D4086a',
    sToken: '0x822Fa72Df1F229C3900f5AD6C3Fa2C424D691622',
    vToken: '0x6df1C1E379bC5a00a7b4C6e67A203333772f45A8',
    interestRateStrategy: '0xc77576b02D74BBF9CdC26F3B86FD09d134416df2',
    oracle: '0x3E7d1eAB13ad0104d2750B8863b489D65364e32D',
    stataToken: '0x862c57d48becB45583AEbA3f489696D22466Ca1b',
    logoPath: "assets/icons/tokens/usdt.svg",
  ),
  'rETH': Asset(
    name: 'Rocket Pool ETH',
    symbol: 'rETH',
    decimals: 18,
    underlying: '0xae78736Cd615f374D3085123A210448E74Fc6393',
    aToken: '0xCc9EE9483f662091a1de4795249E24aC0aC2630f',
    sToken: '0x1d1906f909CAe494c7441604DAfDDDbD0485A925',
    vToken: '0xae8593DD575FE29A9745056aA91C4b746eee62C8',
    interestRateStrategy: '0x24701A6368Ff6D2874d6b8cDadd461552B8A5283',
    oracle: '0x05225Cd708bCa9253789C1374e4337a019e99D56',
    stataToken: '0x0000000000000000000000000000000000000000',
    logoPath: "assets/icons/tokens/reth.svg",
  ),
  'LUSD': Asset(
    name: 'Liquity USD',
    symbol: 'LUSD',
    decimals: 18,
    underlying: '0x5f98805A4E8be255a32880FDeC7F6728C6568bA0',
    aToken: '0x3Fe6a295459FAe07DF8A0ceCC36F37160FE86AA9',
    sToken: '0x37A6B708FDB1483C231961b9a7F145261E815fc3',
    vToken: '0x33652e48e4B74D18520f11BfE58Edd2ED2cEc5A2',
    interestRateStrategy: '0xC0B875907514131C2Fd43f0FBf59EdaB84C7e260',
    oracle: '0x3D7aE7E594f2f2091Ad8798313450130d0Aba3a0',
    stataToken: '0xDBf5E36569798D1E39eE9d7B1c61A7409a74F23A',
    logoPath: "assets/icons/tokens/lusd.svg",
  ),
  'CRV': Asset(
    name: 'Curve DAO Token',
    symbol: 'CRV',
    decimals: 18,
    underlying: '0xD533a949740bb3306d119CC777fa900bA034cd52',
    aToken: '0x7B95Ec873268a6BFC6427e7a28e396Db9D0ebc65',
    sToken: '0x90D9CD005E553111EB8C9c31Abe9706a186b6048',
    vToken: '0x1b7D3F4b3c032a5AE656e30eeA4e8E1Ba376068F',
    interestRateStrategy: '0x76884cAFeCf1f7d4146DA6C4053B18B76bf6ED14',
    oracle: '0xCd627aA160A6fA45Eb793D19Ef54f5062F20f33f',
    stataToken: '0x0000000000000000000000000000000000000000',
    logoPath: "assets/icons/tokens/crv.svg",
  ),
  'MKR': Asset(
    name: 'Maker',
    symbol: 'MKR',
    decimals: 18,
    underlying: '0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2',
    aToken: '0x8A458A9dc9048e005d22849F470891b840296619',
    sToken: '0x0496372BE7e426D28E89DEBF01f19F014d5938bE',
    vToken: '0x6Efc73E54E41b27d2134fF9f98F15550f30DF9B1',
    interestRateStrategy: '0x27eFE5db315b71753b2a38ED3d5dd7E9362ba93F',
    oracle: '0xec1D1B3b0443256cc3860e24a46F108e699484Aa',
    stataToken: '0x0000000000000000000000000000000000000000',
    logoPath: "assets/icons/tokens/mkr.svg",
  ),
  'SNX': Asset(
    name: 'Synthetix Network Token',
    symbol: 'SNX',
    decimals: 18,
    underlying: '0xC011a73ee8576Fb46F5E1c5751cA3B9Fe0af2a6F',
    aToken: '0xC7B4c17861357B8ABB91F25581E7263E08DCB59c',
    sToken: '0x478E1ec1A2BeEd94c1407c951E4B9e22d53b2501',
    vToken: '0x8d0de040e8aAd872eC3c33A3776dE9152D3c34ca',
    interestRateStrategy: '0xA6459195d60A797D278f58Ffbd2BA62Fb3F7FA1E',
    oracle: '0xDC3EA94CD0AC27d9A86C180091e7f78C683d3699',
    stataToken: '0x0000000000000000000000000000000000000000',
    logoPath: "assets/icons/tokens/snx.svg",
  ),
  'BAL': Asset(
    name: 'Balancer',
    symbol: 'BAL',
    decimals: 18,
    underlying: '0xba100000625a3754423978a60c9317c58a424e3D',
    aToken: '0x2516E7B3F76294e03C42AA4c5b5b4DCE9C436fB8',
    sToken: '0xB368d45aaAa07ee2c6275Cb320D140b22dE43CDD',
    vToken: '0x3D3efceb4Ff0966D34d9545D3A2fa2dcdBf451f2',
    interestRateStrategy: '0xd9d85499449f26d2A2c240defd75314f23920089',
    oracle: '0xdF2917806E30300537aEB49A7663062F4d1F2b5F',
    stataToken: '0x0000000000000000000000000000000000000000',
    logoPath: "assets/icons/tokens/bal.svg",
  ),
  'UNI': Asset(
    name: 'Uniswap',
    symbol: 'UNI',
    decimals: 18,
    underlying: '0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984',
    aToken: '0xF6D2224916DDFbbab6e6bd0D1B7034f4Ae0CaB18',
    sToken: '0x2FEc76324A0463c46f32e74A86D1cf94C02158DC',
    vToken: '0xF64178Ebd2E2719F2B1233bCb5Ef6DB4bCc4d09a',
    interestRateStrategy: '0x27eFE5db315b71753b2a38ED3d5dd7E9362ba93F',
    oracle: '0x553303d460EE0afB37EdFf9bE42922D8FF63220e',
    stataToken: '0x0000000000000000000000000000000000000000',
    logoPath: "assets/icons/tokens/uni.svg",
  ),
  'LDO': Asset(
    name: 'Lido DAO Token',
    symbol: 'LDO',
    decimals: 18,
    underlying: '0x5A98FcBEA516Cf06857215779Fd812CA3beF1B32',
    aToken: '0x9A44fd41566876A39655f74971a3A6eA0a17a454',
    sToken: '0xa0a5bF5781Aeb548db9d4226363B9e89287C5FD2',
    vToken: '0xc30808705C01289A3D306ca9CAB081Ba9114eC82',
    interestRateStrategy: '0x27eFE5db315b71753b2a38ED3d5dd7E9362ba93F',
    oracle: '0xb01e6C9af83879B8e06a092f0DD94309c0D497E4',
    stataToken: '0x0000000000000000000000000000000000000000',
    logoPath: "assets/icons/tokens/ldo.svg",
  ),
  'ENS': Asset(
    name: 'Ethereum Name Service',
    symbol: 'ENS',
    decimals: 18,
    underlying: '0xC18360217D8F7Ab5e7c516566761Ea12Ce7F9D72',
    aToken: '0x545bD6c032eFdde65A377A6719DEF2796C8E0f2e',
    sToken: '0x7617d02E311CdE347A0cb45BB7DF2926BBaf5347',
    vToken: '0xd180D7fdD4092f07428eFE801E17BC03576b3192',
    interestRateStrategy: '0xf6733B9842883BFE0e0a940eA2F572676af31bde',
    oracle: '0x5C00128d4d1c2F4f652C267d7bcdD7aC99C16E16',
    stataToken: '0x0000000000000000000000000000000000000000',
    logoPath: "assets/icons/tokens/ens.svg",
  ),
  'ONE_INCH': Asset(
    name: '1inch',
    symbol: '1INCH',
    decimals: 18,
    underlying: '0x111111111117dC0aa78b770fA6A738034120C302',
    aToken: '0x71Aef7b30728b9BB371578f36c5A1f1502a5723e',
    sToken: '0x4b62bFAff61AB3985798e5202D2d167F567D0BCD',
    vToken: '0xA38fCa8c6Bf9BdA52E76EB78f08CaA3BE7c5A970',
    interestRateStrategy: '0xf6733B9842883BFE0e0a940eA2F572676af31bde',
    oracle: '0xc929ad75B72593967DE83E7F7Cda0493458261D9',
    stataToken: '0x0000000000000000000000000000000000000000',
    logoPath: "assets/icons/tokens/1inch.svg",
  ),
  'FRAX': Asset(
    name: 'Frax',
    symbol: 'FRAX',
    decimals: 18,
    underlying: '0x853d955aCEf822Db058eb8505911ED77F175b99e',
    aToken: '0xd4e245848d6E1220DBE62e155d89fa327E43CB06',
    sToken: '0x219640546c0DFDDCb9ab3bcdA89B324e0a376367',
    vToken: '0x88B8358F5BC87c2D7E116cCA5b65A9eEb2c5EA3F',
    interestRateStrategy: '0x2402C25e7E45b1466c53Ef7766AAd878A4CbC237',
    oracle: '0xB9E1E3A9feFf48998E45Fa90847ed4D467E8BcfD',
    stataToken: '0xEE66abD4D0f9908A48E08AE354B0f425De3e237E',
    logoPath: "assets/icons/tokens/frax.svg",
  ),
  'GHO': Asset(
    name: 'Gho token',
    symbol: 'GHO',
    decimals: 18,
    underlying: '0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f',
    aToken: '0x00907f9921424583e7ffBfEdf84F92B7B2Be4977',
    sToken: '0x3f3DF7266dA30102344A813F1a3D07f5F041B5AC',
    vToken: '0x786dBff3f1292ae8F92ea68Cf93c30b34B1ed04B',
    interestRateStrategy: '0x00524e8E4C5FD2b8D8aa1226fA16b39Cad69B8A0',
    oracle: '0xD110cac5d8682A3b045D5524a9903E031d70FCCd',
    stataToken: '0x0000000000000000000000000000000000000000',
    logoPath: "assets/icons/tokens/gho.svg",
  ),
  'RPL': Asset(
    name: 'Rocket Pool',
    symbol: 'RPL',
    decimals: 18,
    underlying: '0xD33526068D116cE69F19A9ee46F0bd304F21A51f',
    aToken: '0xB76CF92076adBF1D9C39294FA8e7A67579FDe357',
    sToken: '0x41e330fd8F7eA31E2e8F02cC0C9392D1403597B4',
    vToken: '0x8988ECA19D502fd8b9CCd03fA3bD20a6f599bc2A',
    interestRateStrategy: '0xD87974E8ED49AB16d5053ba793F4e17078Be0426',
    oracle: '0x4E155eD98aFE9034b7A5962f6C84c86d869daA9d',
    stataToken: '0x0000000000000000000000000000000000000000',
    logoPath: "assets/icons/tokens/rpl.svg",
  ),
  'sDAI': Asset(
    name: 'sDAI',
    symbol: 'sDAI',
    decimals: 18,
    underlying: '0x83F20F44975D03b1b09e64809B757c47f942BEeA',
    aToken: '0x4C612E3B15b96Ff9A6faED838F8d07d479a8dD4c',
    sToken: '0x48Bc45f084988bC01933EA93EeFfEBC0416534f6',
    vToken: '0x8Db9D35e117d8b93C6Ca9b644b25BaD5d9908141',
    interestRateStrategy: '0xdef8F50155A6cf21181E29E400E8CffAE2d50968',
    oracle: '0x29081f7aB5a644716EfcDC10D5c926c5fEe9F72B',
    stataToken: '0x0000000000000000000000000000000000000000',
    logoPath: "assets/icons/tokens/sdai.svg",
  ),
  'STG': Asset(
    name: 'Stargate Finance',
    symbol: 'STG',
    decimals: 18,
    underlying: '0xAf5191B0De278C7286d6C7CC6ab6BB8A73bA2Cd6',
    aToken: '0x1bA9843bD4327c6c77011406dE5fA8749F7E3479',
    sToken: '0xc3115D0660b93AeF10F298886ae22E3Dd477E482',
    vToken: '0x655568bDd6168325EC7e58Bf39b21A856F906Dc2',
    interestRateStrategy: '0x27eFE5db315b71753b2a38ED3d5dd7E9362ba93F',
    oracle: '0x7A9f34a0Aa917D438e9b6E630067062B7F8f6f3d',
    stataToken: '0x0000000000000000000000000000000000000000',
    logoPath: "assets/icons/tokens/stg.svg",
  ),
  'KNC': Asset(
    name: 'Kyber Network Crystal',
    symbol: 'KNC',
    decimals: 18,
    underlying: '0xdeFA4e8a7bcBA345F687a2f1456F5Edd9CE97202',
    aToken: '0x5b502e3796385E1e9755d7043B9C945C3aCCeC9C',
    sToken: '0xdfEE0C9eA1309cB9611F33972E72a72166fcF548',
    vToken: '0x253127Ffc04981cEA8932F406710661c2f2c3fD2',
    interestRateStrategy: '0xf6733B9842883BFE0e0a940eA2F572676af31bde',
    oracle: '0xf8fF43E991A81e6eC886a3D281A2C6cC19aE70Fc',
    stataToken: '0x0000000000000000000000000000000000000000',
    logoPath: "assets/icons/tokens/knc.svg",
  ),
  'FXS': Asset(
    name: 'Frax Share',
    symbol: 'FXS',
    decimals: 18,
    underlying: '0x3432B6A60D23Ca0dFCa7761B7ab56459D9C964D0',
    aToken: '0x82F9c5ad306BBa1AD0De49bB5FA6F01bf61085ef',
    sToken: '0x61dFd349140C239d3B61fEe203Efc811b518a317',
    vToken: '0x68e9f0aD4e6f8F5DB70F6923d4d6d5b225B83b16',
    interestRateStrategy: '0xf6733B9842883BFE0e0a940eA2F572676af31bde',
    oracle: '0x6Ebc52C8C1089be9eB3945C4350B68B8E4C2233f',
    stataToken: '0x0000000000000000000000000000000000000000',
    logoPath: "assets/icons/tokens/fxs.svg",
  ),
  'crvUSD': Asset(
    name: 'Curve USD',
    symbol: 'crvUSD',
    decimals: 18,
    underlying: '0xf939E0A03FB07F59A73314E73794Be0E57ac1b4E',
    aToken: '0xb82fa9f31612989525992FCfBB09AB22Eff5c85A',
    sToken: '0xb55C604075D79486b8A329c396Fc711Be54B5330',
    vToken: '0x028f7886F3e937f8479efaD64f31B3fE1119857a',
    interestRateStrategy: '0x44CaDF6E49895640D9De85ac01d97D44429Ad0A4',
    oracle: '0xEEf0C605546958c1f899b6fB336C20671f9cD49F',
    stataToken: '0x848107491E029AFDe0AC543779c7790382f15929',
    logoPath: "assets/icons/tokens/crvusd.svg",
  ),
};

Map<String, Asset> sepoliaAssets = {
  'DAI': Asset(
    name: 'Dai Stablecoin',
    symbol: 'DAI',
    decimals: 18,
    underlying: '0xFF34B3d4Aee8ddCd6F9AFFFB6Fe49bD371b8a357',
    aToken: '0x29598b72eb5CeBd806C5dCD549490FdA35B13cD8',
    sToken: '0xbEF786E742edB13361ff2f005b901A82c23AA491',
    vToken: '0x22675C506A8FC26447aFFfa33640f6af5d4D4cF0',
    interestRateStrategy: '0xA813CC4d67821fbAcF24659e414A1Cf6c551373c',
    oracle: '0x9aF11c35c5d3Ae182C0050438972aac4376f9516',
    stataToken: '0x0e09fabb73bd3ade0a17ecc321fd13a19e81ce82',
    logoPath: "assets/icons/tokens/dai.svg",
  ),
  'LINK': Asset(
    name: 'ChainLink Token',
    symbol: 'LINK',
    decimals: 18,
    underlying: '0xf8Fb3713D459D7C1018BD0A49D19b4C44290EBE5',
    aToken: '0x3FfAf50D4F4E96eB78f2407c090b72e86eCaed24',
    sToken: '0x8f7440aa789924626ab9f5687AF305da2ffB996b',
    vToken: '0x34a4d932E722b9dFb492B9D8131127690CE2430B',
    interestRateStrategy: '0xCA30c502d52F905FB3D04eE60cA48F5A1A89f8dB',
    oracle: '0x14fC51b7df22b4D393cD45504B9f0A3002A63F3F',
    stataToken: '0x8227a989709a757f25dF251C3C3e71CA38627836',
    logoPath: "assets/icons/tokens/link.svg",
  ),
  'USDC': Asset(
    name: 'USD Coin',
    symbol: 'USDC',
    decimals: 6,
    underlying: '0x94a9D9AC8a22534E3FaCa9F4e7F2E2cf85d5E4C8',
    aToken: '0x16dA4541aD1807f4443d92D26044C1147406EB80',
    sToken: '0x42A218F7bd03c63c4835496506492A383EfcF726',
    vToken: '0x36B5dE936eF1710E1d22EabE5231b28581a92ECc',
    interestRateStrategy: '0x5CB1008969a2d5FAcE8eF32732e6A306d0D0EF2A',
    oracle: '0x98458D6A99489F15e6eB5aFa67ACFAcf6F211051',
    stataToken: '0x8A88124522dbBF1E56352ba3DE1d9F78C143751e',
    logoPath: "assets/icons/tokens/usdc.svg",
  ),
  'WBTC': Asset(
    name: 'Wrapped Bitcoin',
    symbol: 'WBTC',
    decimals: 8,
    underlying: '0x29f2D40B0605204364af54EC677bD022dA425d03',
    aToken: '0x1804Bf30507dc2EB3bDEbbbdd859991EAeF6EefF',
    sToken: '0xc7AEA6Cf353b4FA27aBf1b4A8D536A4e87383EB5',
    vToken: '0xEB016dFd303F19fbDdFb6300eB4AeB2DA7Ceac37',
    interestRateStrategy: '0xCA30c502d52F905FB3D04eE60cA48F5A1A89f8dB',
    oracle: '0x784B90bA1E9a8cf3C9939c2e072F058B024C4b8a',
    stataToken: '0x131a121bda71ED810bCAf2aC9079214925e59C18',
    logoPath: "assets/icons/tokens/wbtc.svg",
  ),
  'WETH': Asset(
    name: 'Wrapped Ether',
    symbol: 'WETH',
    decimals: 18,
    underlying: '0xC558DBdd856501FCd9aaF1E62eae57A9F0629a3c',
    aToken: '0x5b071b590a59395fE4025A0Ccc1FcC931AAc1830',
    sToken: '0xEb45D5A0efF06fFb88f6A70811c08375A8de84A3',
    vToken: '0x22a35DB253f4F6D0029025D6312A3BdAb20C2c6A',
    interestRateStrategy: '0xCA30c502d52F905FB3D04eE60cA48F5A1A89f8dB',
    oracle: '0xDde0E8E6d3653614878Bf5009EDC317BC129fE2F',
    stataToken: '0x162B500569F42D9eCe937e6a61EDfef660A12E98',
    logoPath: "assets/icons/tokens/eth.svg",
  ),
  'USDT': Asset(
    name: 'Tether USD',
    symbol: 'USDT',
    decimals: 6,
    underlying: '0xaA8E23Fb1079EA71e0a56F48a2aA51851D8433D0',
    aToken: '0xAF0F6e8b0Dc5c913bbF4d14c22B4E78Dd14310B6',
    sToken: '0xEAF54fA3b1C7243033C2893c6B807f9cEaBCf0AF',
    vToken: '0x9844386d29EEd970B9F6a2B9a676083b0478210e',
    interestRateStrategy: '0x5CB1008969a2d5FAcE8eF32732e6A306d0D0EF2A',
    oracle: '0x4e86D3Aa271Fa418F38D7262fdBa2989C94aa5Ba',
    stataToken: '0x978206fAe13faF5a8d293FB614326B237684B750',
    logoPath: "assets/icons/tokens/usdt.svg",
  ),
  'AAVE': Asset(
    name: 'Aave',
    symbol: 'AAVE',
    decimals: 18,
    underlying: '0x88541670E55cC00bEEFD87eB59EDd1b7C511AC9a',
    aToken: '0x6b8558764d3b7572136F17174Cb9aB1DDc7E1259',
    sToken: '0x4F15CaD6ebAE920a773bF00C6E941cccCB704915',
    vToken: '0xf12fdFc4c631F6D361b48723c2F2800b84B519e6',
    interestRateStrategy: '0xCA30c502d52F905FB3D04eE60cA48F5A1A89f8dB',
    oracle: '0xda678Ef100c13504edDb8a228A1e8e4CB139f189',
    stataToken: '0x56771cEF0cb422e125564CcCC98BB05fdc718E77',
    logoPath: "assets/icons/tokens/aave.svg",
  ),
  'EURS': Asset(
    name: 'STASIS EURS',
    symbol: 'EURS',
    decimals: 2,
    underlying: '0x6d906e526a4e2Ca02097BA9d0caA3c382F52278E',
    aToken: '0xB20691021F9AcED8631eDaa3c0Cd2949EB45662D',
    sToken: '0x08878209484D8178DD1FFA50AB1689F21aDBB856',
    vToken: '0x94482C7A7477196259D8a0f74fB853277Fa5a75b',
    interestRateStrategy: '0x5CB1008969a2d5FAcE8eF32732e6A306d0D0EF2A',
    oracle: '0xCbE15C1f40f1D7eE1De3756D1557d5Fdc2A50bBD',
    stataToken: '0x72B49a461900e11632C95dfa563e7173438D4e3E',
    logoPath: "assets/icons/tokens/eurs.svg",
  ),
  'GHO': Asset(
    name: 'Gho token',
    symbol: 'GHO',
    decimals: 18,
    underlying: '0xc4bF5CbDaBE595361438F8c6a187bDc330539c60',
    aToken: '0xd190eF37dB51Bb955A680fF1A85763CC72d083D4',
    sToken: '0xdCA691FB9609aB814E59c62d70783da1c056A9b6',
    vToken: '0x67ae46EF043F7A4508BD1d6B94DB6c33F0915844',
    interestRateStrategy: '0x521247B4d0a51E71DE580dA2cBF99EB40a44b3Bf',
    oracle: '0x00f7fecFAEbEd9499e1f3f9d04E755a21E5fc47C',
    stataToken: '0x0',
    logoPath: "assets/icons/tokens/gho.svg",
  )
};

List<String> sepoliaAssetsList = [
  'DAI',
  'LINK',
  'USDC',
  'WBTC',
  'WETH',
  'USDT',
  'AAVE',
  'EURS',
  'GHO',
];

List<String> ethereumAssetsList = [
  'DAI',
  'LINK',
  'AAVE',
  'cbETH',
  'USDT',
  'rETH',
  'LUSD',
  'CRV',
  'MKR',
  'SNX',
  'BAL',
  'UNI',
  'LDO',
  'ENS',
  'ONE_INCH',
  'FRAX',
  'GHO',
  'RPL',
  'sDAI',
  'STG',
  'KNC',
  'FXS',
  'crvUSD',
];

// Future<List<TokenInfo>> fetchTokens(String assetPath) async {
//   final jsonStr = await rootBundle.loadString(assetPath);
//   final List<dynamic> jsonList = jsonDecode(jsonStr);
//   return jsonList.map((json) => TokenInfo.fromJson(json)).toList();
// }

// Future<void> initAssets(String assetPath) async {
//   final tokens = await fetchTokens(assetPath);
//   final filteredTokens = tokens.where((token) => token.chainId == 1);

//   for (var token in filteredTokens) {
//     if (ethereumAssets.containsKey(token.symbol)) {
//       ethereumAssets[token.symbol]!.tokenInfo = token;
//     }
//   }

//   for (var assetKey in sepoliaAssetsList) {
//     if (ethereumAssets.containsKey(assetKey)) {
//       TokenInfo? tokenInfo = ethereumAssets[assetKey]?.tokenInfo;
//       if (tokenInfo != null) {
//         tokenInfo.chainId = 11155111;
//         tokenInfo.address = sepoliaAssets[assetKey]!.underlying;
//         sepoliaAssets[assetKey]?.tokenInfo = tokenInfo;
//       }
//     }
//   }
// }

class ChainAssets {
  final Map<String, Asset> assets;
  final List<String> assetList;
  ChainAssets(this.assets, this.assetList);
}

final ethereumChainAssets = ChainAssets(ethereumAssets, ethereumAssetsList);
final sepoliaChainAssets = ChainAssets(sepoliaAssets, sepoliaAssetsList);

Map<int, ChainAssets> chainAssets = {
  1: ethereumChainAssets,
  11155111: sepoliaChainAssets,
};

class TokenAddress {
  final String tokenAddress;

  TokenAddress({required this.tokenAddress});

  factory TokenAddress.fromJson(Map<String, dynamic> json) {
    return TokenAddress(
      tokenAddress: json['tokenAddress'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tokenAddress': tokenAddress,
    };
  }

  @override
  String toString() {
    return tokenAddress;
  }
}

class BridgeInfo {
  final Map<String, TokenAddress> bridgeInfo;

  BridgeInfo({required this.bridgeInfo});

  factory BridgeInfo.fromJson(Map<String, dynamic> json) {
    var bridgeInfo = json.map((key, value) =>
        MapEntry(key, TokenAddress.fromJson(value as Map<String, dynamic>)));
    return BridgeInfo(
      bridgeInfo: bridgeInfo,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bridgeInfo':
          bridgeInfo.map((key, value) => MapEntry(key, value.toJson())),
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class Extension {
  final bool isNative;
  final BridgeInfo? bridgeInfo;

  Extension({required this.isNative, this.bridgeInfo});

  factory Extension.fromJson(Map<String, dynamic> json) {
    return Extension(
      isNative: json['isNative'] == true,
      bridgeInfo: json['bridgeInfo'] != null
          ? BridgeInfo.fromJson(json['bridgeInfo'] as Map<String, dynamic>)
          : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'isNative': isNative,
      'bridgeInfo': bridgeInfo?.toJson(),
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class Token {
  final String name;
  final String symbol;
  final int decimals;
  final String address;
  final int chainId;
  final String logoURI;
  final Extension? extensions;

  Token({
    required this.name,
    required this.symbol,
    required this.decimals,
    required this.address,
    required this.chainId,
    required this.logoURI,
    this.extensions,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      name: json['name'],
      symbol: json['symbol'],
      decimals: json['decimals'],
      address: json['address'],
      chainId: json['chainId'],
      logoURI: json['logoURI'],
      extensions: json['extensions'] == null
          ? null
          : Extension.fromJson(json['extensions'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'symbol': symbol,
      'decimals': decimals,
      'address': address,
      'chainId': chainId,
      'logoURI': logoURI,
      'extensions': extensions?.toJson(),
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class TokenList {
  final Map<String, Map<String, Token>> tokens;

  Token? getToken(String chainId, String symbol) {
    return tokens[chainId]?[symbol];
  }

  // 私有构造函数
  TokenList._privateConstructor({required this.tokens});

  // 单例对象
  static final TokenList _instance = TokenList._privateConstructor(
    tokens: _initTokenList(),
  );

  // 工厂构造函数返回单例对象
  factory TokenList() {
    return _instance;
  }

  static Map<String, Map<String, Token>> _parseTokenList(
      Map<String, dynamic> jsonMap) {
    return jsonMap.map((key, value) => MapEntry(
          key,
          (value as Map<String, dynamic>)
              .map((key, value) => MapEntry(key, Token.fromJson(value))),
        ));
  }

  static Map<String, Map<String, Token>> _initTokenList() {
    final jsonMap = jsonDecode(tokenList_json) as Map<String, dynamic>;
    return _parseTokenList(jsonMap);
  }

  // factory TokenList.fromJson(Map<String, dynamic> json) {
  //   return TokenList._privateConstructor(
  //     tokens: _parseTokenList(json),
  //   );
  // }
}
