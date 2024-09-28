import 'package:flutter/material.dart';
import 'package:healthy_app/theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
    required this.gender,
    required this.dateOfBirth,
    required this.weight,
    required this.height,
    required this.bodyFat,
    required this.muscleMass,
    required this.basalMetabolism,
    required this.viscealFat,
  });

  final String gender;
  final DateTime dateOfBirth;
  final double weight;
  final double height;
  final double bodyFat;
  final double muscleMass;
  final double viscealFat;
  final double basalMetabolism;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double bmiResult = 0;
  String bmiStatus = "";

  // double _roundHeight = height.round(2);
  void checkBmi(bmi) {
    bmiResult = bmi;

    if (bmi <= 18.5) {
      bmiStatus = "Underweight";
    } else if (bmi > 18.5 && bmi < 23.0) {
      bmiStatus = "Normal";
    } else if (bmi >= 23.0 && bmi <= 25) {
      bmiStatus = "Overweight";
    } else if (bmi >= 25.0) {
      bmiStatus = "Obesity";
    }
  }

  Color containerColor() {
    switch (bmiStatus) {
      case "Underweight":
        return infoColor;

      case "Normal":
        return successColor;

      case "Overweight":
        return warningColor;

      case "Obesity":
        return dangerColor;

      default:
        return infoColor;
    }
  }

  Color textColor() {
    if (bmiStatus == 'Overweight') {
      return textPrimaryColor;
    }

    return whiteColor;
  }

  @override
  void initState() {
    super.initState();

    int roundHeight = widget.height.round();
    double convertHeight = roundHeight / 100;
    double countBmi = widget.weight / (convertHeight * convertHeight);

    checkBmi(countBmi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: const Text('Profile Overview', style: fontSemibold),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Image.asset('assets/images/image_profile.png'),
              const SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  color: containerColor(),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.all(16),
                child: RichText(
                  text: TextSpan(
                    text: 'Your BMI (Body Mass Index) is ',
                    style: TextStyle(color: textColor()),
                    children: [
                      TextSpan(
                          text: '${bmiResult.toStringAsFixed(2)} [$bmiStatus]',
                          style: fontSemibold)
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text('Result', style: fontSemibold.copyWith(fontSize: 16)),
              const SizedBox(height: 10),
              Table(
                border: TableBorder.all(),
                columnWidths: const <int, TableColumnWidth>{
                  0: FixedColumnWidth(150),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(children: [
                    const ContentTable(widget: Text('Gender')),
                    ContentTable(
                      widget: Text(widget.gender.toUpperCase()),
                    ),
                  ]),
                  TableRow(children: [
                    const ContentTable(widget: Text('Date of Birth')),
                    ContentTable(
                      widget: Text(
                        '${widget.dateOfBirth.day}/${widget.dateOfBirth.month}/${widget.dateOfBirth.year}',
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    const ContentTable(widget: Text('BMI')),
                    ContentTable(
                      widget: Text(bmiResult.toStringAsFixed(2)),
                    ),
                  ]),
                  TableRow(children: [
                    const ContentTable(widget: Text('Weight')),
                    ContentTable(
                      widget: Text('${widget.weight.toStringAsFixed(0)} Kg'),
                    ),
                  ]),
                  TableRow(children: [
                    const ContentTable(widget: Text('Height')),
                    ContentTable(
                      widget: Text('${widget.height.toStringAsFixed(0)} cm'),
                    )
                  ]),
                  TableRow(children: [
                    const ContentTable(widget: Text('Body Fat')),
                    ContentTable(
                      widget: Text(
                        widget.bodyFat != 0
                            ? '${widget.bodyFat.toStringAsFixed(0)} %'
                            : '-',
                      ),
                    )
                  ]),
                  TableRow(children: [
                    const ContentTable(widget: Text('Muscle Mass')),
                    ContentTable(
                      widget: Text(
                        widget.muscleMass != 0
                            ? '${widget.muscleMass.toStringAsFixed(0)} kg'
                            : '-',
                      ),
                    )
                  ]),
                  TableRow(children: [
                    const ContentTable(widget: Text('Basal Metabolism')),
                    ContentTable(
                      widget: Text(
                        widget.basalMetabolism != 0
                            ? '${widget.basalMetabolism.toStringAsFixed(0)} kg'
                            : '-',
                      ),
                    )
                  ]),
                  TableRow(children: [
                    const ContentTable(widget: Text('Visceal Fat')),
                    ContentTable(
                      widget: Text(
                        widget.viscealFat != 0
                            ? '${widget.viscealFat.toStringAsFixed(0)} kg'
                            : '-',
                      ),
                    )
                  ]),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ContentTable extends StatelessWidget {
  const ContentTable({super.key, required this.widget});

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: widget,
    );
  }
}
