part of 'models.dart';

class UserModel {
  final String id;
  final String name;
  final String profession;
  final String phone;
  final String email;
  final int editEmail;
  final int editPhone;
  final int editPassword;
  final DateTime updatedAt;

  UserModel({
    this.id,
    this.name,
    this.profession,
    this.phone,
    this.email,
    this.editEmail,
    this.editPhone,
    this.editPassword,
    this.updatedAt,
  });

  factory UserModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.exists ? snapshot.data() : {};

    return UserModel(
        id: snapshot.id,
        name: data['name'] ?? '',
        profession: data['profession'] ?? '',
        phone: data['phone'] ?? '',
        email: data['email'] ?? '',
        editEmail: data['edit_email'] ?? 0,
        editPhone: data['edit_phone'] ?? 0,
        editPassword: data['edit_password'] ?? 0,
        updatedAt: data['updated_at'] != null && data['updated_at'] is Timestamp
            ? Timestamp(
                data['updated_at'].seconds,
                data['updated_at'].nanoseconds,
              ).toDate()
            : null);
  }

  factory UserModel.initialData() {
    return UserModel(
      id: '',
      name: '',
      profession: '',
      phone: '',
      email: '',
      editEmail: 0,
      editPhone: 0,
      editPassword: 0,
      updatedAt: null,
    );
  }
}
