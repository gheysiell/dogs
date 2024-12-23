import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static const String apiUrl = 'https://api.thedogapi.com/v1/';
  static const String apiUrlCdn = 'https://cdn2.thedogapi.com/';
  static final String apiKey = dotenv.env['API_KEY'] ?? '';
  static const String genericExceptionMessage = 'generic exception in';
  static const String timeoutExceptionMessage = 'timeout exception in';
  static const Duration timeoutDurationRemoteHttp = Duration(seconds: 10);
}
