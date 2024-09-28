import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthy_app/pages/profile_page.dart';
import 'package:healthy_app/theme.dart';
import 'package:healthy_app/widgets/button/button.dart';
import 'package:healthy_app/widgets/textfield/textfield.dart';

class WeightPage extends StatefulWidget {
  const WeightPage({
    super.key,
    required this.gender,
    required this.dateOfBirth,
  });

  final String gender;
  final DateTime dateOfBirth;

  @override
  State<WeightPage> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  final TextEditingController _weight = TextEditingController();
  final TextEditingController _height = TextEditingController();
  final TextEditingController _bodyFat = TextEditingController();
  final TextEditingController _muscleMass = TextEditingController();
  final TextEditingController _viscealFat = TextEditingController();
  final TextEditingController _basalMetabolism = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? validate(String value, String field) {
    if (value.isEmpty) {
      return '$field is required';
    }

    return null;
  }

  void onSave() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(
            gender: widget.gender,
            dateOfBirth: widget.dateOfBirth,
            weight: double.parse(_weight.text),
            height: double.parse(_height.text),
            bodyFat: _bodyFat.text != '' ? double.parse(_bodyFat.text) : 0,
            muscleMass:
                _muscleMass.text != '' ? double.parse(_muscleMass.text) : 0,
            basalMetabolism: _basalMetabolism.text != ''
                ? double.parse(_basalMetabolism.text)
                : 0,
            viscealFat:
                _viscealFat.text != '' ? double.parse(_viscealFat.text) : 0,
          ),
        ),
      );

      // _weight.text = '';
      // _height.text = '';
      // _bodyFat.text = '';
      // _muscleMass.text = '';
      // _viscealFat.text = '';
      // _basalMetabolism.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        title: const Text('Form Weight', style: fontSemibold),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextfieldWidget(
                  label: "Weight",
                  controller: _weight,
                  validator: (value) => validate(value!, 'Weight'),
                  hintText: 'e.g., 60 or 60.5 kg',
                  textInputFormatter: [
                    LengthLimitingTextInputFormatter(5),
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d{0,3}(\.\d?)?'),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                TextfieldWidget(
                  label: "Height",
                  controller: _height,
                  validator: (value) => validate(value!, 'Height'),
                  hintText: 'e.g., 170 cm',
                  textInputFormatter: [
                    LengthLimitingTextInputFormatter(5),
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d{0,3}(\.\d?)?'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextfieldWidget(
                  label: "Body Fat",
                  controller: _bodyFat,
                  hintText: 'e.g., 15%',
                  textInputFormatter: [
                    LengthLimitingTextInputFormatter(5),
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d{0,2}(\.\d?)?'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextfieldWidget(
                  label: "Muscle Mass",
                  controller: _muscleMass,
                  hintText: 'e.g., 40 kg',
                  textInputFormatter: [
                    LengthLimitingTextInputFormatter(5),
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d{0,2}(\.\d?)?'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextfieldWidget(
                  label: "Visceal Fat",
                  controller: _viscealFat,
                  hintText: 'Allowed 1 - 12 (no decimals)',
                  textInputFormatter: [
                    FilteringTextInputFormatter.digitsOnly,
                    RangeLimitingTextInputFormatter(1, 12),
                  ],
                ),
                const SizedBox(height: 20),
                TextfieldWidget(
                  label: "Basal ",
                  controller: _basalMetabolism,
                  hintText: 'e.g 1200 kcal',
                  textInputFormatter: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20),
        child: ButtonWidget(label: "Save", onClick: onSave),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

/// Custom TextInputFormatter to limit input between min and max values
class RangeLimitingTextInputFormatter extends TextInputFormatter {
  final int min;
  final int max;

  RangeLimitingTextInputFormatter(this.min, this.max);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final int? value = int.tryParse(newValue.text);

    if (value == null || value < min || value > max) {
      // If input is out of range, revert to the old value
      return oldValue;
    }

    return newValue;
  }
}
