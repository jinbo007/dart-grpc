import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/services.dart';

void fetchDio() async {
  final dio = Dio();

  // TODO: always update to the latest fingerprint.
  // openssl s_client -servername pinning-test.badssl.com \
  //    -connect pinning-test.badssl.com:443 < /dev/null 2>/dev/null \
  //    | openssl x509 -noout -fingerprint -sha256
  String fingerprint =
      // 'update-with-latest-sha256-hex-ee5ce1dfa7a53657c545c62b65802e4272';
      // should look like this:
      'ee5ce1dfa7a53657c545c62b65802e4272878dabd65c0aadcf85783ebb0b4d5c';
  // '9ee66a02e0af04405c3e9570b039427af237cab3404d42d56dad235969ce626a';

  // Don't trust any certificate just because their root cert is trusted
  dio.httpClientAdapter = IOHttpClientAdapter()
    ..onHttpClientCreate = (_) {
      final client = HttpClient(
        context: SecurityContext(withTrustedRoots: false),
      );
      // You can test the intermediate / root cert here. We just ignore it.
      client.badCertificateCallback = (cert, host, port) => true;
      return client;
    }
    ..validateCertificate = (cert, host, port) {
      // Check that the cert fingerprint matches the one we expect
      // We definitely require _some_ certificate
      if (cert == null) return false;
      // Validate it any way you want. Here we only check that
      // the fingerprint matches the OpenSSL SHA256.
      final f = sha256.convert(cert.der).toString();
      print(f);
      return fingerprint == f;
    };

  Response? response;

  // // Normally this certificate would normally be accepted, but all
  // // certs are refused initially, and it is still checked.
  // response = await dio.get('https://sha256.badssl.com/');
  // print(response.data);
  // response = null;
  //
  // // Normally this certificate would be rejected because its host isn't covered in the certificate.
  // response = await dio.get('https://wrong.host.badssl.com/');
  // print(response.data);
  // response = null;

  try {
    // This certificate doesn't have the same fingerprint.
    // response = await dio.get('https://bad.host.badssl.com/');
    response = await dio.get('https://www.baidu.com/');
    print(response.data);
  } on DioError catch (e) {
    print(e.message);
    print(response?.data);
    dio.close(force: true);
  }
}

void fetchDioWithCert() async {
  final dio = Dio();
  // ByteData bytes = await rootBundle.load('certificates/baidu.cer');
  ByteData byes = await rootBundle.load('certificates/baidu.cer');
  // ByteData byes = await rootBundle.load('certificates/stackoverflow.cer');
  Uint8List certByteList = byes.buffer.asUint8List();
  // Uint8List certByteList = File("lib/certificates/baidu.cer").readAsBytesSync();
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (client) {
    SecurityContext sc = SecurityContext();
    sc.setTrustedCertificatesBytes(certByteList);
    HttpClient httpClient = HttpClient(context: sc);
    return httpClient;
  };
  try {
    var response = await dio.get('https://www.baidu.com/');
    print(response.data);
  } catch (error) {
    if (error is DioError) {
      print(error.toString());
    } else {
      print('Unexpected Error');
    }
  }
}
