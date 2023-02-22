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

/// Dart implementation of the gRPC helloworld.Greeter server.
import 'dart:io';
import 'dart:typed_data';

import 'package:app/grpc.dart';
import 'package:app/grpc/lib/src/generated/helloworld.pbgrpc.dart';

class GreeterService extends GreeterServiceBase {
  @override
  Future<HelloReply> sayHello(call, HelloRequest request) async {
    return HelloReply()..message = 'Hello, ${request.name}!';
  }

  @override
  Future<HelloReply> sayHelloAgain(
      ServiceCall call, HelloRequest request) async {
    return HelloReply()..message = 'Hello again, ${request.name}!';
  }
}

Future<void> main(List<String> args) async {
  final server = Server.create(
    services: [GreeterService()],
    codecRegistry: CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
  );

  await server.serve(port: 50053, security: serverCredential);
  print('Server listening on port ${server.port}...');
}

final serverCredential = ServerTlsCredentials(
    certificate: File('lib/cert/server-cert.pem').readAsBytesSync(),
    certificatePassword: "",
    privateKey: File('lib/cert/server-key.pem').readAsBytesSync(),
    privateKeyPassword: "");

//
// class MyChannelCredentials extends ChannelCredentials {
//   final Uint8List? certificateChain;
//   final Uint8List? privateKey;
//
//   MyChannelCredentials({
//     Uint8List? trustedRoots,
//     this.certificateChain,
//     this.privateKey,
//     String? authority,
//     BadCertificateHandler? onBadCertificate,
//   }) : super.secure(
//             certificates: trustedRoots,
//             authority: authority,
//             onBadCertificate: onBadCertificate);
//
//   @override
//   SecurityContext? get securityContext {
//     final ctx = super.securityContext;
//     if (certificateChain != null) {
//       ctx?.useCertificateChainBytes(certificateChain!);
//     }
//     if (privateKey != null) {
//       ctx?.usePrivateKeyBytes(privateKey!);
//     }
//     return ctx;
//   }
// }
//
// final credential = MyChannelCredentials(
//   trustedRoots: File('pems/ca-cert.pem').readAsBytesSync(),
//   certificateChain: File('pems/client-cert.pem').readAsBytesSync(),
//   privateKey: File('pems/client-key.pem').readAsBytesSync(),
//   authority: 'localhost',
// );
