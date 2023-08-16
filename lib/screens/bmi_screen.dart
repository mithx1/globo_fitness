import 'package:flutter/material.dart';
import 'package:globo_fitness/shared/menu_bottom.dart';
import 'package:globo_fitness/shared/menu_drawer.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({Key? key}) : super(key: key);

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  final TextEditingController txtHeight = TextEditingController();
  final TextEditingController txtWeight = TextEditingController();
  final double fontSize = 18;
  String result = '';
  bool isMetric = true;
  bool isImperial = false;
  double? height;
  double? weight;
  late List<bool> isSelected;
  String heightMessage = '';
  String weightMessage = '';

  @override
  void initState() {
    isSelected = [isMetric, isImperial];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    heightMessage =
        'Please insert your height in ${(isMetric) ? 'meters' : 'inches'}';
    weightMessage =
        'Please insert your weight in ${(isMetric) ? 'kilos' : 'pounds'}';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
      ),
      drawer: const MenuDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: ToggleButtons(
                  isSelected: isSelected,
                  onPressed: toggleMeasure,
                  children: [
                    MetricToggle(fontSize: fontSize),
                    ImperialToggle(fontSize: fontSize)
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: heightMessage,
                  alignLabelWithHint: true,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                ),
                controller: txtHeight,
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: TextField(
                decoration: InputDecoration(
                    hintText: weightMessage,
                    alignLabelWithHint: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0)),
                controller: txtWeight,
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: findBmi,
                  child: Text(
                    'Calculate BMI',
                    style: TextStyle(fontSize: fontSize),
                  )),
            ),
            Text(
              'Result: $result',
              style: TextStyle(fontSize: fontSize),
            )
          ],
        ),
      ),
      bottomNavigationBar: const MenuBottom(),
    );
  }

  void toggleMeasure(value) {
    if (value == 0) {
      isMetric = true;
      isImperial = false;
    } else {
      isMetric = false;
      isImperial = true;
    }

    setState(() {
      isSelected = [isMetric, isImperial];
    });
  }

  void findBmi() {
    double bmi = 0.0;
    double height = double.tryParse(txtHeight.text) ?? 0;
    double weight = double.tryParse(txtWeight.text) ?? 0;

    if (isMetric) {
      bmi = weight / (height * height);
    } else {
      bmi = weight * 703 / (height * height);
    }
    setState(() {
      result = 'Your bmi is ${bmi.toStringAsFixed(2)}';
    });
  }
}

/// this is a toggle
class ImperialToggle extends StatelessWidget {
  const ImperialToggle({
    super.key,
    required this.fontSize,
  });

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        'Imperial',
        style: TextStyle(fontSize: fontSize),
      ),
    );
  }
}

/// this is a toggle
class MetricToggle extends StatelessWidget {
  const MetricToggle({
    super.key,
    required this.fontSize,
  });

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        'Metric',
        style: TextStyle(fontSize: fontSize),
      ),
    );
  }
}
