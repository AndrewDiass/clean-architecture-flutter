import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:meta/meta.dart';
import 'package:test/test.dart';

class RemoveAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoveAuthentication({@required this.httpClient, @required this.url});

  Future<void> auth() async {
    await httpClient.request(url: url);
  }
}

abstract class HttpClient {
  Future<void> request({@required String url});
}

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  test('Shuld call HttpClient with correct URl', () async {
    final httpClient = HttpClientSpy();
    final url = faker.internet.httpUrl();
    final sut = RemoveAuthentication(httpClient: httpClient, url: url);
    sut.auth();

    verify(httpClient.request(url: url));
  });
}