class RouteConstants {
  RouteConstants._();

  static const String splash = '/splash';
  static const String welcome = '/welcome';
  static const String home = '/';
  static const String trending = '/trending';
  static const String continueWatching = '/continue-watching';
  static const String movieDetails = '/movie/:id';
  static const String categories = '/categories';
  static const String search = '/search';
  static const String myList = '/my-list';
  static const String profile = '/profile';
  static const String settings = '/settings';

  static String movieDetailsPath(String id) => '/movie/$id';
}
