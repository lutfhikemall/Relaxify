part of 'services.dart';

class UserService {
  CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('user');

  User currentUser = FirebaseAuth.instance.currentUser;

  String _user = FirebaseAuth.instance.currentUser.uid;

  Stream<UserModel> get getUser {
    return _userCollection
        .doc(_user)
        .snapshots()
        .map((snapshot) => UserModel.fromDocumentSnapshot(snapshot));
  }

  Future<String> editProfile({
    @required Map<String, dynamic> data,
  }) async {
    try {
      await _userCollection.doc(_user).set(data, SetOptions(merge: true));
      return 'success';
    } catch (e) {
      return e;
    }
  }
}
