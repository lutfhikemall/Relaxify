part of 'pages.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView(
            children: [
              Column(
                children: [
                  SizedBox(height: 100),
                  Image.asset(
                    "assets/Illustration.png",
                    width: 195,
                    height: 222,
                  ),
                  SizedBox(height: 55),
                  Text(
                    "Welcome to Relaxify!",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur\n adipiscing elit. Risus euismod lacus,\n pharetra dui.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 70),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0XFFF25D9C),
                      minimumSize: Size(300, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0XFFF25D9C),
                      ),
                    ),
                  ),
                  SizedBox(height: 35),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
