
/// Route class to access route name and path effectively
library;

class Route {
  String path;
  String name;
  Route({
    required this.path,
    required this.name,
  });
}

class AppRoutes {
  AppRoutes._();
  static Route launch = Route(path: '/launch', name: 'launch');
  static Route onboard = Route(path: '/onboard', name: 'onboard');
  static Route getStarted = Route(path: '/getStarted', name: 'getStarted');

  static Route signUp = Route(path: '/signUp', name: 'signUp');
  static Route signIn = Route(path: '/signIn', name: 'signIn');
  static Route home = Route(path: '/home', name: 'home');
  static Route productDetails = Route(path: '/productDetails', name: 'productDetails');
}
