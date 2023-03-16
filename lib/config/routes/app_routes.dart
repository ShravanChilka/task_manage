enum Pages {
  login,
  home,
  create,
  error,
}

extension AppPageExtension on Pages {
  String get screenPath {
    switch (this) {
      case Pages.login:
        return '/';
      case Pages.home:
        return '/home';
      case Pages.error:
        return '/error';
      case Pages.create:
        return '/create';
      default:
        return '/';
    }
  }

  String get screenName {
    switch (this) {
      case Pages.home:
        return 'HOME';
      case Pages.login:
        return 'LOGIN';
      case Pages.error:
        return 'ERROR';
      case Pages.create:
        return 'CREATE';
      default:
        return 'LOGIN';
    }
  }

  String get screenTitle {
    switch (this) {
      case Pages.home:
        return 'Home';
      case Pages.login:
        return 'Login';
      case Pages.error:
        return 'Error';
      case Pages.create:
        return 'Create';
      default:
        return 'Login';
    }
  }
}
