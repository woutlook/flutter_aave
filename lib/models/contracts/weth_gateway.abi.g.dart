// @dart=3.0
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_local_variable, unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:web3dart/web3dart.dart' as _i1;import 'dart:typed_data' as _i2;final _contractAbi = _i1.ContractAbi.fromJson('[{"inputs":[{"internalType":"address","name":"weth","type":"address"},{"internalType":"address","name":"owner","type":"address"},{"internalType":"contract IPool","name":"pool","type":"address"}],"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"previousOwner","type":"address"},{"indexed":true,"internalType":"address","name":"newOwner","type":"address"}],"name":"OwnershipTransferred","type":"event"},{"stateMutability":"payable","type":"fallback"},{"inputs":[],"name":"POOL","outputs":[{"internalType":"contract IPool","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"WETH","outputs":[{"internalType":"contract IWETH","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"},{"internalType":"uint256","name":"interestRateMode","type":"uint256"},{"internalType":"uint16","name":"referralCode","type":"uint16"}],"name":"borrowETH","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"","type":"address"},{"internalType":"address","name":"onBehalfOf","type":"address"},{"internalType":"uint16","name":"referralCode","type":"uint16"}],"name":"depositETH","outputs":[],"stateMutability":"payable","type":"function"},{"inputs":[{"internalType":"address","name":"to","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"}],"name":"emergencyEtherTransfer","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"token","type":"address"},{"internalType":"address","name":"to","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"}],"name":"emergencyTokenTransfer","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"getWETHAddress","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"owner","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"renounceOwnership","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"},{"internalType":"uint256","name":"rateMode","type":"uint256"},{"internalType":"address","name":"onBehalfOf","type":"address"}],"name":"repayETH","outputs":[],"stateMutability":"payable","type":"function"},{"inputs":[{"internalType":"address","name":"newOwner","type":"address"}],"name":"transferOwnership","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"},{"internalType":"address","name":"to","type":"address"}],"name":"withdrawETH","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"},{"internalType":"address","name":"to","type":"address"},{"internalType":"uint256","name":"deadline","type":"uint256"},{"internalType":"uint8","name":"permitV","type":"uint8"},{"internalType":"bytes32","name":"permitR","type":"bytes32"},{"internalType":"bytes32","name":"permitS","type":"bytes32"}],"name":"withdrawETHWithPermit","outputs":[],"stateMutability":"nonpayable","type":"function"},{"stateMutability":"payable","type":"receive"}]', 'Weth_gateway.abi', );class Weth_gateway.abi extends _i1.GeneratedContract {Weth_gateway.abi({required _i1.EthereumAddress address, required _i1.Web3Client client, int? chainId, }) : super(_i1.DeployedContract(_contractAbi, address, ), client, chainId, );

/// The optional [atBlock] parameter can be used to view historical data. When
/// set, the function will be evaluated in the specified block. By default, the
/// latest on-chain block will be used.
Future<_i1.EthereumAddress> POOL({_i1.BlockNum? atBlock}) async  { final function = self.abi.functions  [
2
];
assert(checkSignature(function, '7535d246'));
final params = [];
final response =  await read(function, params, atBlock, );
return  (response  [
0
] as _i1.EthereumAddress); } 
/// The optional [atBlock] parameter can be used to view historical data. When
/// set, the function will be evaluated in the specified block. By default, the
/// latest on-chain block will be used.
Future<_i1.EthereumAddress> WETH({_i1.BlockNum? atBlock}) async  { final function = self.abi.functions  [
3
];
assert(checkSignature(function, 'ad5c4648'));
final params = [];
final response =  await read(function, params, atBlock, );
return  (response  [
0
] as _i1.EthereumAddress); } 
/// The optional [transaction] parameter can be used to override parameters
/// like the gas price, nonce and max gas. The `data` and `to` fields will be
/// set by the contract.
Future<String> borrowETH(({_i1.EthereumAddress $param0, BigInt amount, BigInt interestRateMode, BigInt referralCode}) args, {required _i1.Credentials credentials, _i1.Transaction? transaction, }) async  { final function = self.abi.functions  [
4
];
assert(checkSignature(function, '66514c97'));
final params = [args.$param0, args.amount, args.interestRateMode, args.referralCode, ];
return  write(credentials, transaction, function, params, ); } 
/// The optional [transaction] parameter can be used to override parameters
/// like the gas price, nonce and max gas. The `data` and `to` fields will be
/// set by the contract.
Future<String> depositETH(({_i1.EthereumAddress $param4, _i1.EthereumAddress onBehalfOf, BigInt referralCode}) args, {required _i1.Credentials credentials, _i1.Transaction? transaction, }) async  { final function = self.abi.functions  [
5
];
assert(checkSignature(function, '474cf53d'));
final params = [args.$param4, args.onBehalfOf, args.referralCode, ];
return  write(credentials, transaction, function, params, ); } 
/// The optional [transaction] parameter can be used to override parameters
/// like the gas price, nonce and max gas. The `data` and `to` fields will be
/// set by the contract.
Future<String> emergencyEtherTransfer(({_i1.EthereumAddress to, BigInt amount}) args, {required _i1.Credentials credentials, _i1.Transaction? transaction, }) async  { final function = self.abi.functions  [
6
];
assert(checkSignature(function, 'eed88b8d'));
final params = [args.to, args.amount, ];
return  write(credentials, transaction, function, params, ); } 
/// The optional [transaction] parameter can be used to override parameters
/// like the gas price, nonce and max gas. The `data` and `to` fields will be
/// set by the contract.
Future<String> emergencyTokenTransfer(({_i1.EthereumAddress token, _i1.EthereumAddress to, BigInt amount}) args, {required _i1.Credentials credentials, _i1.Transaction? transaction, }) async  { final function = self.abi.functions  [
7
];
assert(checkSignature(function, 'a3d5b255'));
final params = [args.token, args.to, args.amount, ];
return  write(credentials, transaction, function, params, ); } 
/// The optional [atBlock] parameter can be used to view historical data. When
/// set, the function will be evaluated in the specified block. By default, the
/// latest on-chain block will be used.
Future<_i1.EthereumAddress> getWETHAddress({_i1.BlockNum? atBlock}) async  { final function = self.abi.functions  [
8
];
assert(checkSignature(function, 'affa8817'));
final params = [];
final response =  await read(function, params, atBlock, );
return  (response  [
0
] as _i1.EthereumAddress); } 
/// The optional [atBlock] parameter can be used to view historical data. When
/// set, the function will be evaluated in the specified block. By default, the
/// latest on-chain block will be used.
Future<_i1.EthereumAddress> owner({_i1.BlockNum? atBlock}) async  { final function = self.abi.functions  [
9
];
assert(checkSignature(function, '8da5cb5b'));
final params = [];
final response =  await read(function, params, atBlock, );
return  (response  [
0
] as _i1.EthereumAddress); } 
/// The optional [transaction] parameter can be used to override parameters
/// like the gas price, nonce and max gas. The `data` and `to` fields will be
/// set by the contract.
Future<String> renounceOwnership({required _i1.Credentials credentials, _i1.Transaction? transaction, }) async  { final function = self.abi.functions  [
10
];
assert(checkSignature(function, '715018a6'));
final params = [];
return  write(credentials, transaction, function, params, ); } 
/// The optional [transaction] parameter can be used to override parameters
/// like the gas price, nonce and max gas. The `data` and `to` fields will be
/// set by the contract.
Future<String> repayETH(({_i1.EthereumAddress $param12, BigInt amount, BigInt rateMode, _i1.EthereumAddress onBehalfOf}) args, {required _i1.Credentials credentials, _i1.Transaction? transaction, }) async  { final function = self.abi.functions  [
11
];
assert(checkSignature(function, '02c5fcf8'));
final params = [args.$param12, args.amount, args.rateMode, args.onBehalfOf, ];
return  write(credentials, transaction, function, params, ); } 
/// The optional [transaction] parameter can be used to override parameters
/// like the gas price, nonce and max gas. The `data` and `to` fields will be
/// set by the contract.
Future<String> transferOwnership(({_i1.EthereumAddress newOwner}) args, {required _i1.Credentials credentials, _i1.Transaction? transaction, }) async  { final function = self.abi.functions  [
12
];
assert(checkSignature(function, 'f2fde38b'));
final params = [args.newOwner];
return  write(credentials, transaction, function, params, ); } 
/// The optional [transaction] parameter can be used to override parameters
/// like the gas price, nonce and max gas. The `data` and `to` fields will be
/// set by the contract.
Future<String> withdrawETH(({_i1.EthereumAddress $param17, BigInt amount, _i1.EthereumAddress to}) args, {required _i1.Credentials credentials, _i1.Transaction? transaction, }) async  { final function = self.abi.functions  [
13
];
assert(checkSignature(function, '80500d20'));
final params = [args.$param17, args.amount, args.to, ];
return  write(credentials, transaction, function, params, ); } 
/// The optional [transaction] parameter can be used to override parameters
/// like the gas price, nonce and max gas. The `data` and `to` fields will be
/// set by the contract.
Future<String> withdrawETHWithPermit(({_i1.EthereumAddress $param20, BigInt amount, _i1.EthereumAddress to, BigInt deadline, BigInt permitV, _i2.Uint8List permitR, _i2.Uint8List permitS}) args, {required _i1.Credentials credentials, _i1.Transaction? transaction, }) async  { final function = self.abi.functions  [
14
];
assert(checkSignature(function, 'd4c40b6c'));
final params = [args.$param20, args.amount, args.to, args.deadline, args.permitV, args.permitR, args.permitS, ];
return  write(credentials, transaction, function, params, ); } 
/// Returns a live stream of all OwnershipTransferred events emitted by this contract.
Stream<OwnershipTransferred> ownershipTransferredEvents({_i1.BlockNum? fromBlock, _i1.BlockNum? toBlock, }) { final event = self.event('OwnershipTransferred');
final filter = _i1.FilterOptions.events(contract: self, event: event, fromBlock: fromBlock, toBlock: toBlock, );
return  client.events(filter).map((_i1.FilterEvent result) { final decoded = event.decodeResults(result.topics!, result.data!, );
return  OwnershipTransferred(decoded, result, ); } ); } 
 }
class OwnershipTransferred {OwnershipTransferred(List<dynamic> response, this.event, ) : previousOwner = (response[0] as _i1.EthereumAddress), newOwner = (response[1] as _i1.EthereumAddress);

final _i1.EthereumAddress previousOwner;

final _i1.EthereumAddress newOwner;

final _i1.FilterEvent event;

 }
