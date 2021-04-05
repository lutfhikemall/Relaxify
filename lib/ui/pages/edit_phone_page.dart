part of 'pages.dart';

class EditPhonePage extends StatefulWidget {
  final UserModel data;

  EditPhonePage({this.data});

  @override
  _EditPhonePageState createState() => _EditPhonePageState();
}

class _EditPhonePageState extends State<EditPhonePage> {
  TextEditingController _phone = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isSigningIn = false;

  @override
  void initState() {
    super.initState();
    initFunction();
  }

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
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Text('+62'),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _phone,
                            decoration: InputDecoration(
                              hintText: 'Phone Number',
                            ),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Phone number can't be empty!";
                              }
                              if (value ==
                                  user.currentUser.phoneNumber.substring(3)) {
                                return "Phone number can't be same with your old number!";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.0),
                    Container(
                      child: isSigningIn
                          ? SpinKitFadingCircle(
                              color: Color(0XFFF25D9C),
                            )
                          : TextButton(
                              onPressed: () => _onSubmit(auth),
                              child: Text(
                                'Edit',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                minimumSize: Size(
                                  MediaQuery.of(context).size.width,
                                  40.0,
                                ),
                                backgroundColor: Color(0XFFF25D9C),
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

  void initFunction() {
    setState(() {
      _phone = TextEditingController(
          text: widget.data.phone.isNotEmpty
              ? widget.data.phone
              : UserService().currentUser.phoneNumber.substring(3));
    });
  }

  void _onSubmit(auth) async {
    if (_formKey.currentState.validate()) {
      try {
        setState(() {
          isSigningIn = true;
        });

        await Future.delayed(Duration(milliseconds: 600));

        UpdateResult result = await auth.updatePhone(phone: _phone.text);

        if (result.status == 'success') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => VerifyPhonePage(
                phone: _phone.text,
              ),
            ),
          );
        }

        setState(() {
          isSigningIn = false;
        });
      } catch (e) {
        setState(() {
          isSigningIn = false;
        });
        print(e.toString());
      }
    }
  }
}
