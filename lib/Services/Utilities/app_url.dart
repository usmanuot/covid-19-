class AppUrl {
  // this is our base url/endpoint
  static const String baseUrl = 'https://disease.sh/v3/covid-19/';

  // fetch world covid states
  static const String worldUrl = '${baseUrl}all';
  static const String countryUrl = '${baseUrl}countries';
}
