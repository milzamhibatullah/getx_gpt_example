class Routes {
  static Future<String> get initialRoute async {
    /// setup where screen to be initial
    return SPLASH;
  }

  static const HOME = '/home';
  static const SPLASH = '/splash';
  static const AUTH = '/auth';
}
