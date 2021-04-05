part of 'widgets.dart';

class ListHomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    final auth = Provider.of<AuthService>(context);

    return SafeArea(
      child: ListView(
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 248,
                decoration: BoxDecoration(
                  color: Color(0XFFF25D9C),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 60),
                    Text(
                      "Welcome, on Full Auth!",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 46),
                    Card(
                      elevation: 2,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Container(
                        width: 315,
                        height: 165,
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Container(
                              width: 116,
                              height: 128,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                image: DecorationImage(
                                  image: AssetImage("assets/pic.png"),
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: Text(
                                        user.name.isNotEmpty
                                            ? user.name
                                            : 'No Name',
                                        style: TextStyle(fontSize: 20),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      user.profession.isNotEmpty
                                          ? user.profession
                                          : 'No Profession',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0XFF9A9A9A),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Changes History :",
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: Color(0XFF9A9A9A),
                                      ),
                                    ),
                                    Card(
                                      margin: EdgeInsets.only(top: 4.0),
                                      color: Color(0XFFF25D9C).withOpacity(0.6),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 8,
                                          horizontal: 16,
                                        ),
                                        width: 155,
                                        height: 47,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  "Email",
                                                  style: TextStyle(
                                                    fontSize: 8,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  user.editEmail.toString(),
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width: 1,
                                              height: 23,
                                              color: Colors.white,
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  "Phone",
                                                  style: TextStyle(
                                                    fontSize: 8,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  user.editPhone.toString(),
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width: 1,
                                              height: 23,
                                              color: Colors.white,
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  "Password",
                                                  style: TextStyle(
                                                    fontSize: 8,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  user.editPassword.toString(),
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 28),
                    ListTile(
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_outline_rounded,
                            color: Color(0XFFF25D9C),
                          )
                        ],
                      ),
                      title: Text("Edit Profile"),
                      subtitle: user.updatedAt != null
                          ? Text(user.updatedAt.toString())
                          : null,
                      trailing: Icon(Icons.navigate_next),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditProfilePage(data: user),
                          ),
                        );
                      },
                      contentPadding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.email_outlined,
                        color: Color(0XFFF25D9C),
                      ),
                      title: Text("Edit Email"),
                      trailing: Icon(Icons.navigate_next),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditEmailPage(data: user),
                          ),
                        );
                      },
                      contentPadding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.phone_outlined,
                        color: Color(0XFFF25D9C),
                      ),
                      title: Text("Edit Phone"),
                      trailing: Icon(Icons.navigate_next),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditPhonePage(data: user),
                          ),
                        );
                      },
                      contentPadding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.vpn_key_outlined,
                        color: Color(0XFFF25D9C),
                      ),
                      title: Text("Edit Password"),
                      trailing: Icon(Icons.navigate_next),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditPasswordPage(),
                          ),
                        );
                      },
                      contentPadding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    ListTile(
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.exit_to_app_outlined,
                            color: Color(0XFFEB5757),
                          )
                        ],
                      ),
                      title: Text(
                        "Logout",
                        style: TextStyle(
                          color: Color(0XFFEB5757),
                        ),
                      ),
                      subtitle: Text("Exit from Full Auth"),
                      trailing: Icon(Icons.navigate_next),
                      onTap: () => konfirmasiDialog(context, auth),
                      contentPadding: EdgeInsets.only(left: 16, right: 16),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

void konfirmasiDialog(BuildContext context, auth) {
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: Text("Perhatian"),
        content: Text("Apakah kamu yakin ingin keluar dari full auth?"),
        actions: [
          TextButton(
            child: Text("Ok"),
            onPressed: () async {
              Navigator.of(context).pop();
              await auth.signOut();
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          TextButton(
            child: Text(
              "Batal",
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      );
    },
  );
}
