import 'package:flutter/material.dart';
import 'package:sayi_tahmin_app/model/user_model.dart';
import 'package:sayi_tahmin_app/product/constants/app_keys.dart';
import 'package:sayi_tahmin_app/view/home_view.dart';
import 'package:sayi_tahmin_app/widgets/custom_elevated_button.dart';
import 'package:sayi_tahmin_app/widgets/custom_text_field.dart';

class GuessingView extends StatefulWidget {
  const GuessingView({super.key, required this.users, required this.answer});
  final List<UserModel> users;
  final int answer;

  @override
  State<GuessingView> createState() => _GuessingViewState();
}

class _GuessingViewState extends State<GuessingView> {
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    _answerController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  late final PageController _pageController;

  int _currentPageIndex = 0;

  late final TextEditingController _answerController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(AppKeys.kAppName),
      ),
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        itemCount: widget.users.length,
        onPageChanged: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return Column(
            children: [
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.person,
                        size: 72,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Text(
                          widget.users[_currentPageIndex].userName,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: CustomTextField(
                          hintText: 'Cevabınız',
                          keyboardType: TextInputType.number,
                          maxLength: 3,
                          controller: _answerController,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CustomElevatedButton(
                    onPressed: () {
                      if (int.parse(_answerController.text) == widget.answer) {
                        _showAlertDialog(context);
                      } else {
                        if (_currentPageIndex < widget.users.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          _pageController.animateToPage(
                            0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.linear,
                          );
                        }
                        _answerController.text = '';
                      }
                    },
                    title: 'SIRADAKİ'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'TEBRİKLER SEN BİLDİN!',
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.users[_currentPageIndex].userName,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Text(
                widget.answer.toString(),
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeView(),
                    ),
                    (route) => false);
              },
              child: const Text('BİTİR'),
            ),
          ],
        );
      },
    );
  }
}
