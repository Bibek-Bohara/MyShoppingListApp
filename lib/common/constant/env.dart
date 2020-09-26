class Env {
  Env(this.baseUrl);

  final String baseUrl;
}

mixin EnvValue {
  // static final Env development = Env('http://122.168.0.100:1337');
  static final Env development = Env('http://10.0.0.22:1337');
  static final Env staging = Env('your staging url');
  static final Env production = Env('your production url');
}
