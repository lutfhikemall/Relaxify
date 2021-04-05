part of 'pages.dart';

class VerifyPhonePage extends StatefulWidget {
  final String phone;

  VerifyPhonePage({this.phone});

  @override
  _VerifyPhonePageState createState() => _VerifyPhonePageState();
}

class _VerifyPhonePageState extends State<VerifyPhonePage> {
  String _otp;

  bool isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    final user = Provider.of<UserService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Phone Number'),
        backgroundColor: Color(0XFFF25D9C),
      ),
      body: SafeArea(
        child: Center(
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              Form(
                child: Column(
                  children: [
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
                          _otp = value;
                        });
                      },
                    ),
                    SizedBox(height: 24.0),
                    Container(
                      child: isSigningIn
                          ? SpinKitFadingCircle(
                              color: Color(0XFFF25D9C),
                            )
                          : TextButton(
                              onPressed: () => _otp != null && _otp.length == 6
                                  ? _onSubmit(auth, user)
                                  : null,
                              child: Text(
                                'Verify',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                minimumSize: Size(
                                  MediaQuery.of(context).size.width,
                                  40.0,
                                ),
                                backgroundColor:
                                    _otp != null && _otp.length == 6
                                        ? Color(0XFFF25D9C)
                                        : Colors.grey[300],
                              ),
                            ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onSubmit(auth, user) async {
    setState(() {
      isSigningIn = true;
    });

    UpdateResult result = await auth.verifyPhoneOTP(smsCode: _otp);

    if (result.status == 'success') {
      await user.editProfile(data: {
        'phone': widget.phone,
        'edit_phone': FieldValue.increment(1),
      });

      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      setState(() {
        isSigningIn = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.message),
        ),
      );
    }
  }
}
