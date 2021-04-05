part of 'pages.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: UserService().getUser,
      initialData: UserModel.initialData(),
      child: Scaffold(
        body: ListHomeWidget(),
      ),
    );
  }
}
