import 'package:flutter/material.dart';
import 'package:sayi_tahmin_app/model/user_model.dart';
import 'package:sayi_tahmin_app/product/constants/app_keys.dart';
import 'package:sayi_tahmin_app/view/i_got_it_view.dart';
import 'package:sayi_tahmin_app/widgets/custom_card.dart';
import 'package:sayi_tahmin_app/widgets/custom_elevated_button.dart';
import 'package:sayi_tahmin_app/widgets/custom_text_field.dart';

class DetailView extends StatefulWidget {
  const DetailView({super.key});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  @override
  void initState() {
    super.initState();
    _minController = TextEditingController();
    _maxController = TextEditingController();
    _userController = TextEditingController();
  }

  @override
  void dispose() {
    _minController.dispose();
    _maxController.dispose();
    _userController.dispose();
    super.dispose();
  }

  late final TextEditingController _userController;

  late final TextEditingController _minController;
  late final TextEditingController _maxController;

  final bool barrierDismissible = false;

  List<UserModel> users = [];
  int userId = 0;
  void setterUserId() {
    setState(() {
      userId++;
    });
  }

  void setController() {
    setState(() {
      _userController.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(AppKeys.kAppName),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                AppKeys.kSpacingNumbersKey,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Divider(),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        maxLength: 3,
                        keyboardType: TextInputType.number,
                        controller: _minController,
                        hintText: AppKeys.kMinKey,
                      ),
                    ),
                    Expanded(
                      child: CustomTextField(
                        maxLength: 3,
                        keyboardType: TextInputType.number,
                        controller: _maxController,
                        hintText: AppKeys.kMaxKey,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                flex: 4,
                child: GridView.builder(
                  itemCount: users.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onLongPress: () {
                        _showDeleteAlertDialog(context, index);
                      },
                      child: CustomCard(
                        user: users[index],
                        size: 48,
                      ),
                    );
                  },
                ),
              ),
              CustomElevatedButton(
                  onPressed: () {
                    if (_minController.text.isEmpty && _maxController.text.isEmpty) {
                      _showSnackBar(context, AppKeys.kSnacMessNum);
                      if (users.isEmpty) {
                        _showSnackBar(context, AppKeys.kSnacMessUser);
                      }
                    } else if (users.isEmpty) {
                      _showSnackBar(context, AppKeys.kSnacMessUser);
                    } else {
                      if (int.parse(_maxController.text) > int.parse(_minController.text)) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IGotItView(
                              min: int.parse(_minController.text),
                              max: int.parse(_maxController.text),
                              users: users,
                            ),
                          ),
                        );
                      } else {
                        if (int.parse(_maxController.text) == int.parse(_minController.text)) {
                          _showSnackBar(context, AppKeys.kSnacMessNum1);
                        } else {
                          _showSnackBar(context, AppKeys.kSnacMessNum2);
                        }
                      }
                    }
                  },
                  title: AppKeys.kNextKey),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCustomDialog(context: context, status: barrierDismissible);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      (SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      )),
    );
  }

  void showCustomDialog({required BuildContext context, bool status = false}) {
    showDialog(
      barrierDismissible: status,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: CustomTextField(
            controller: _userController,
            maxLength: 20,
            keyboardType: TextInputType.name,
            hintText: AppKeys.kUserNameKey,
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  if (_userController.text != '') {
                    setState(() {
                      status = false;
                    });
                    UserModel newUser = UserModel(userId: userId, userName: _userController.text);
                    users.add(newUser);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar((const SnackBar(
                      content: Text(AppKeys.kSnacMessUser2),
                      backgroundColor: Colors.red,
                    )));
                  }
                });
                setController();
                Navigator.pop(context);
              },
              child: const Text(AppKeys.kAddKey),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteAlertDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Emin misiniz?'),
          content: const Text('Bu kullanıcıyı silmek istediğinizden emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(AppKeys.kCancelKey),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  users.removeWhere((element) => element.userName == users[index].userName);
                });
                Navigator.of(context).pop();
              },
              child: const Text(AppKeys.kDeleteKey),
            ),
          ],
        );
      },
    );
  }
}
