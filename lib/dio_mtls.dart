import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/services.dart';

Future<String> getDioInsucure() async {
  final dio = Dio();
  try {
    final response =  await dio.get('http://example.com:3001/');
    print(response.data.toString());
    return response.data.toString();
  } catch (error) {
    print(error);
    return error.toString();
  }

}

/**
 * dio tls
 */
Future<String> getDioTls() async {
  final dio = Dio();
  // final trustedRoot = File('lib/certificates/ca.pem').readAsBytesSync();
  final trustedRoot = await rootBundle.load('assets/certificates/ca.pem');
  // final trustedRoot = await rootBundle.load('assets/certificates/baidu.cer');
  final trustedRootBytes =trustedRoot.buffer.asUint8List();
  (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (client) {
    final sc = SecurityContext();
    sc.setTrustedCertificatesBytes(trustedRootBytes);
    final httpClient = HttpClient(context: sc);
    return httpClient;
  };

  try {
    final response =  await dio.get('https://example.com:3002/');
    // final response =  await dio.get('https://www.baidu.com/');
    print(response.data);
    return response.data;
  } catch (error) {
    print(error);
    return error.toString();
  }

}


/**
 * dio mtls
 */
Future<String> getDiomTls() async {
  final dio = Dio();
  final trustedRoot = await rootBundle.load('assets/certificates/ca.pem');
  final trustedRootBytes =trustedRoot.buffer.asUint8List();
  final clientCert = await rootBundle.load('assets/certificates/client1.pem');
  final clientCertBytes =clientCert.buffer.asUint8List();
  final clientKey = await rootBundle.load('assets/certificates/client1.key');
  final clientKeyBytes =clientKey.buffer.asUint8List();
  (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (client) {
    final sc = SecurityContext();
    sc.setTrustedCertificatesBytes(trustedRootBytes);
    sc.usePrivateKeyBytes(clientKeyBytes);
    sc.useCertificateChainBytes(clientCertBytes);

    final httpClient = HttpClient(context: sc);
    return httpClient;
  };

  try {
    final response =  await dio.get('https://example.com:3003/');
    print(response.data);
    return response.data;
  } catch (error) {
    print(error);
    return error.toString();
  }

}