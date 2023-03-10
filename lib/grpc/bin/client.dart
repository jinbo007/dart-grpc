// Copyright (c) 2018, the gRPC project authors. Please see the AUTHORS file
// for details. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/// Dart implementation of the gRPC helloworld.Greeter client.
import 'dart:io';

import 'package:app/grpc/lib/src/generated/helloworld.pbgrpc.dart';
import 'package:app/src/client/call.dart';
import 'package:app/src/client/http2_channel.dart';
import 'package:app/src/client/options.dart';
import 'package:app/src/client/transport/http2_credentials.dart';
import 'package:app/src/shared/codec.dart';
import 'package:app/src/shared/codec_registry.dart';
//
// ////Test no secure grpc
// Future<void> main(List<String> args) async {
//   final channel = ClientChannel(
//     'localhost',
//     port: 50053,
//     options: ChannelOptions(
//       credentials: ChannelCredentials.insecure(),
//       codecRegistry:
//           CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
//     ),
//   );
//   final stub = GreeterClient(channel);
//
//   final name = args.isNotEmpty ? args[0] : 'world';
//
//   try {
//     var response = await stub.sayHello(
//       HelloRequest()..name = name,
//       options: CallOptions(compression: const GzipCodec()),
//     );
//     print('Greeter client received: ${response.message}');
//     response = await stub.sayHelloAgain(HelloRequest()..name = name);
//     print('Greeter client received: ${response.message}');
//   } catch (e) {
//     print('Caught error: $e');
//   }
//   await channel.shutdown();
// }

// Test secure grpc
Future<void> main(List<String> args) async {
  final trustedRoot = File('lib/cert/ca-cert.pem').readAsBytesSync();
  final channelCredentials = ChannelCredentials.secure(
      certificates: trustedRoot, onBadCertificate: allowBadCertificate);
  final channelOptions = ChannelOptions(credentials: channelCredentials);
  final channel =
      ClientChannel("localhost", port: 50053, options: channelOptions);

  final stub = GreeterClient(channel);

  final name = args.isNotEmpty ? args[0] : 'world';

  try {
    var response = await stub.sayHello(
      HelloRequest()..name = name,
      options: CallOptions(compression: const GzipCodec()),
    );
    print('Greeter client received: ${response.message}');
    response = await stub.sayHelloAgain(HelloRequest()..name = name);
    print('Greeter client received: ${response.message}');
  } catch (e) {
    print('Caught error: $e');
  }
  await channel.shutdown();
}

bool allowBadCertificate(X509Certificate certificate, String host){
  print('Greeter client received: ${certificate.pem}');
  print('Greeter client received: ${host}');
  return true;
}
