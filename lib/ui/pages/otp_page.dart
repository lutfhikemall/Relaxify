part of 'pages.dart';

class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  String _smsCode;

  bool isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    return Scaffold(
      body: SafeArea(
          child: Center(
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
                      "Verify,\nOTP",
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
                PinCodeTextField(
                  appContext: context,
                  length: 6,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 60,
                    fieldWidth: 50,
                  ),
                  onChanged: (String value) {
                    setState(() {
                      _smsCode = value;
                    });
                  },
                ),
                SizedBox(height: 40),
                Container(
                  child: isSigningIn
                      ? SpinKitFadingCircle(
                          color: Color(0XFFF25D9C),
                        )
                      : TextButton(
                          onPressed: () =>
                              _smsCode != null && _smsCode.length == 6
                                  ? _verify(auth)
                                  : null,
                          child: Text(
                            "Verify",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor:
                                _smsCode != null && _smsCode.length == 6
                                    ? Color(0XFFF25D9C)
                                    : Colors.grey[350],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            minimumSize: Size(200, 60),
                          ),
                        ),
                ),
                SizedBox(height: 40),
              ],
            )
          ],
        ),
      )),
    );
  }

  void _verify(auth) async {
    setState(() {
      isSigningIn = true;
    });

    await Future.delayed(Duration(microseconds: 600));

    SignInSignUpResult result = await auth.verifyOTP(
      smsCode: _smsCode,
      context: context,
    );

    if (result.user == null) {
      setState(() {
        isSigningIn = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.message),
        ),
      );
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
    }
  }
}
