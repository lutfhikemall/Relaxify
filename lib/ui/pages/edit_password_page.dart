part of 'pages.dart';

class EditPasswordPage extends StatefulWidget {
  @override
  _EditPasswordPageState createState() => _EditPasswordPageState();
}

class _EditPasswordPageState extends State<EditPasswordPage> {
  TextEditingController _password = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    final user = Provider.of<UserService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Password'),
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
                      controller: _password,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Password can't be empty";
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

  void _onSubmit(auth, user) async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isSigningIn = true;
      });

      UpdateResult result = await auth.updatePassword(password: _password.text);

      if (result.status == 'success') {
        await user.editProfile(data: {
          'password': _password.text,
          'edit_password': FieldValue.increment(1),
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
