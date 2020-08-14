import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onicares/home/screens/homepage.dart';
import 'package:onicares/imageviewer/screens/view_image.dart';
import 'package:onicares/login/screen/loginpage.dart';

class Routing {
  static const LogInPageRoute = '/login';
  static const HomePageRoute = '/home';
  static const ViewImagePageRoute = '/imageviewer';

  static Route<dynamic> generateRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case LogInPageRoute:
        return MaterialPageRoute(
          builder: (context) => LogInPage(),
        );
        break;
      case HomePageRoute:
        return MaterialPageRoute(
          builder: (context) {
            FirebaseUser user = routeSettings.arguments;
            return HomePage(user: user);
          },
        );
        break;
      case ViewImagePageRoute:
        return MaterialPageRoute(
          builder: (context) {
            return ViewImagePage(
              imageUrl: routeSettings.arguments,
            );
          },
        );
        break;
      default:
        return MaterialPageRoute(
          builder: (context) => LogInPage(),
        );
        break;
    }
  }
}
