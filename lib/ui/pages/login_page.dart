part of 'pages.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  TextEditingController _phone = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 30),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Hello,\nWelcome!",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Image.asset(
                        "assets/il_login.png",
                        width: 148,
                      )
                    ],
                  ),
                  SizedBox(height: 50),
                  Row(
                    children: [
                      Container(
                        child: Text('+62'),
                      ),
                      SizedBox(width: 16),
                      Container(
                        width: 290,
                        child: TextFormField(
                          controller: _phone,
                          decoration: InputDecoration(
                            hintText: "Enter phone number here",
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Phone can't be empty";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Container(
                    child: isSigningIn
                        ? SpinKitFadingCircle(
                            color: Color(0XFFF25D9C),
                          )
                        : TextButton(
                            onPressed: () => _signIn(auth),
                            child: Text(
                              "Send OTP",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: Color(0XFFF25D9C),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              minimumSize: Size(200, 60),
                            ),
                          ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    "or Sign in with",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0XFF9A9A9A),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(width: 4),
                      Image.asset("assets/Google.png", width: 26, height: 26),
                      SizedBox(width: 24),
                      Image.asset("assets/Facebook.png", width: 26, height: 26),
                      SizedBox(width: 24),
                      Image.asset("assets/twitter.png", width: 26, height: 26),
                      SizedBox(width: 24),
                      Image.asset("assets/phone.png", width: 26, height: 26),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _signIn(auth) async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isSigningIn = true;
      });

      await Future.delayed(Duration(milliseconds: 600));

      String result = await auth.signIn(phone: _phone.text, context: context);

      if (result == 'success') {
        Navigator.of(context).pushNamed('/verify');
      }

      setState(() {
        isSigningIn = false;
      });
    }
  }
}
