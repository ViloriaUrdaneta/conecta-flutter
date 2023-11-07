class FCMTokenManager {
  String? _token;

  FCMTokenManager._privateConstructor();
  static final FCMTokenManager instance = FCMTokenManager._privateConstructor();

  String? get token => _token;

  void setToken(String token) {
    _token = token;
  }
}
