import 'package:flutter/material.dart';
import 'package:healthy_app/pages/weight_page.dart';
import 'package:healthy_app/theme.dart';
import 'package:healthy_app/widgets/button/button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _currentIndex = 0;
  String _gender = '';
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Center(
          child: _currentIndex == 0
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/image_welcome.png'),
                    Text(
                      'Welcome to the Scale App,\nyour personal health tracker',
                      style: fontSemibold.copyWith(
                        fontSize: 20,
                        color: textPrimaryColor,
                      ),
                    ),
                  ],
                )
              : _currentIndex == 1
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/image_gender.png'),
                        Text(
                          'Select gender',
                          style: fontSemibold.copyWith(
                            fontSize: 20,
                            color: textPrimaryColor,
                          ),
                        ),
                        ListTile(
                          title: const Text('Male'),
                          leading: Radio(
                            value: 'male',
                            groupValue: _gender,
                            onChanged: (String? value) {
                              setState(() {
                                _gender = value!;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Female'),
                          leading: Radio(
                            value: 'female',
                            groupValue: _gender,
                            onChanged: (String? value) {
                              setState(() {
                                _gender = value!;
                              });
                            },
                          ),
                        )
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/image_date.png'),
                        Text(
                          'Date of your birth',
                          style: fontSemibold.copyWith(
                            fontSize: 20,
                            color: textPrimaryColor,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => _selectDate(context),
                          child: const Text('Select date'),
                        ),
                        selectedDate != null
                            ? Text(
                                '${selectedDate?.day}/${selectedDate?.month}/${selectedDate?.year}',
                              )
                            : const SizedBox(),
                      ],
                    ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16),
        child: ButtonWidget(
          label: _currentIndex == 0
              ? "Get Started"
              : _currentIndex == 1
                  ? "Continue"
                  : "Save",
          isDisabled: (_currentIndex == 1 && _gender == '') ||
              (_currentIndex == 2 && selectedDate == null),
          onClick: () {
            if (_currentIndex < 2) {
              setState(() {
                _currentIndex += 1;
              });
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (conext) => WeightPage(
                    gender: _gender,
                    dateOfBirth: selectedDate!,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

List<Step> getSteps() {
  return <Step>[
    Step(
      title: SizedBox(),
      content: Column(
        children: [Image.asset('assets/images/image_welcome.png')],
      ),
    ),
    Step(
      title: SizedBox(),
      content: Column(
        children: [Image.asset('assets/images/image_welcome.png')],
      ),
    ),
  ];
}
