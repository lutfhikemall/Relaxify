part of 'pages.dart';

class EditProfilePage extends StatefulWidget {
  final UserModel data;

  EditProfilePage({this.data});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _name = TextEditingController();
  TextEditingController _profession = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isSigningIn = false;

  @override
  void initState() {
    super.initState();
    initFunction();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
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
                      controller: _name,
                      decoration: InputDecoration(
                        hintText: 'Name',
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Name can't be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _profession,
                      decoration: InputDecoration(
                        hintText: 'Profession',
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Profession can't be empty";
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
                              onPressed: () => _onSubmit(user),
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
      _name = TextEditingController(text: widget.data.name ?? '');
      _profession = TextEditingController(text: widget.data.profession ?? '');
    });
  }

  void _onSubmit(user) async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isSigningIn = true;
      });

      await user.editProfile(data: {
        'name': _name.text,
        'profession': _profession.text,
        'updated_at': Timestamp.now(),
      });

      Navigator.of(context).pop();

      setState(() {
        isSigningIn = false;
      });
    }
  }
}
