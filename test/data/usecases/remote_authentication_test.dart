import 'dart:html';

import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:meta/meta.dart';
import 'package:test/test.dart';

import 'package:manguinho_app/domains/usecases/usecases.dart';

class RemoveAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoveAuthentication({@required this.httpClient, @required this.url});

  Future<void> auth(AuthenticationParams params) async {
    final body = {
      'email': params.email,
      'password': params.secret,
    };
    await httpClient.request(url: url, method: 'post', body: body);
  }
}

abstract class HttpClient {
  Future<void> request({
    @required String url,
    @required String method,
    Map body,
  });
}

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  RemoveAuthentication sut;
  HttpClientSpy httpClient;
  String url;

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoveAuthentication(httpClient: httpClient, url: url);
  });
  test('Shuld call HttpClient with correct values', () async {
    final params = AuthenticationParams(
        email: faker.internet.email(), secret: faker.internet.password());
    sut.auth(params);

    verify(
      httpClient.request(
          url: url,
          method: 'post',
          body: {'email': params.email, 'password': params.secret}),
    );
  });
}
