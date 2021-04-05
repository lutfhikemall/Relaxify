part of 'pages.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    if (user != null) {
      return HomePage();
    } else {
      return SplashPage();
    }
  }
}
