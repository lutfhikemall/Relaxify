part of 'pages.dart';

class EditEmailPage extends StatefulWidget {
  final UserModel data;

  EditEmailPage({this.data});

  @override
  _EditEmailPageState createState() => _EditEmailPageState();
}

class _EditEmailPageState extends State<EditEmailPage> {
  TextEditingController _email = TextEditingController();
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
        title: Text('Edit Email'),
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
                    TextFormField(
                      controller: _email,
                      decoration: InputDecoration(
                        hintText: 'Email',
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Email can't be empty";
                        }
                        if (value == user.currentUser.email) {
                          return "Email can't be same with your older email!";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24.0),
                    Container(
                      child: isSigningIn
                          ? SpinKitFadingCircle(
                              color: Color(0XFFF25D9C),
                            )
                          : TextButton(
                              onPressed: () => _onSubmit(auth, user),
                              child: Text(
                                'Save',
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
      _email = TextEditingController(text: widget.data.email ?? '');
    });
  }

  void _onSubmit(auth, user) async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isSigningIn = true;
      });

      UpdateResult result = await auth.updateEmail(email: _email.text);

      if (result.status == 'success') {
        await user.editProfile(data: {
          'email': _email.text,
          'edit_email': FieldValue.increment(1),
        });

        Navigator.of(context).pop();
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
}
