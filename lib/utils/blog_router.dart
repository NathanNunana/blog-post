part of blog_utils;

class BlogRouter {
  static const decisionRoute = '/';
  static const landingRoute = '/landing';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case landingRoute:
        return _route(
          const LandingPage(),
        );
      default:
        return _route(
          Scaffold(
            appBar: AppBar(
              title: const Text('Blog Post'),
            ),
            body: const Center(
              child: Text('Unknown page'),
            ),
          ),
        );
    }
  }

  static MaterialPageRoute _route(Widget page, {bool fullscreen = false}) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => page,
      fullscreenDialog: fullscreen,
    );
  }
}
