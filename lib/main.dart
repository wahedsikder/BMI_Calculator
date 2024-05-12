import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BmiCalculator(),
    );
  }
}

class BmiCalculator extends StatefulWidget {
  const BmiCalculator({super.key});

  @override
  State<BmiCalculator> createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {

  TextEditingController ageController = TextEditingController();
  TextEditingController ftController = TextEditingController();
  TextEditingController inchController = TextEditingController();
  TextEditingController wtController = TextEditingController();

  double? ans = 0;
  bool changeMaleGenderColor = false;
  bool changeFemaleGenderColor = false;



  // MySnackBar(context, message) {
  //   return ScaffoldMessenger.of(context)
  //       .showSnackBar(SnackBar(content: Text(message)));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calclulator"),
        backgroundColor: Colors.pink.shade50,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  dispose();
                });
              },
              icon: Icon(Icons.replay_rounded)),
          IconButton(onPressed: () {

          }, icon: Icon(Icons.more_vert)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      controller: ageController,
                      decoration: InputDecoration(
                        labelText: "Age",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      controller: ftController,
                      decoration: InputDecoration(
                        labelText: "Ht (ft)",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      controller: inchController,
                      decoration: InputDecoration(
                        labelText: "Ht (in)",
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    height: 100,
                    child: InkWell(
                      onTap: () {
                        changeMaleGenderColor = true;
                        changeFemaleGenderColor = false;
                        setState(() {});
                      },
                      child: Icon(
                        Icons.male,
                        color:
                        changeMaleGenderColor == true ? Colors.green : null,
                        size: 28,
                      ),
                    ),
                  ),
                  const Text(
                    ' | ',
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(
                    height: 100,
                    child: InkWell(
                      onTap: () {
                        changeFemaleGenderColor = true;
                        changeMaleGenderColor = false;
                        setState(() {});
                      },
                      child: Icon(Icons.female,
                          color: changeFemaleGenderColor == true
                              ? Colors.green
                              : null,
                          size: 28),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  SizedBox(
                    width: 90,
                    child: TextFormField(
                      controller: wtController,
                      decoration: InputDecoration(labelText: "Weight (kg)"),
                    ),
                  ),
                  SizedBox(
                    width: 70,
                  ),
                  IconButton(
                      onPressed: () {

                        double? ft = double.tryParse(ftController.text)?? 0;
                        double? inch = double.tryParse(inchController.text)?? 0;
                        double? wt = double.tryParse(wtController.text)?? 0;

                        double? meter = (ft * 12 + inch) * 0.0254;

                        ans = wt / (meter * meter);

                        setState(() {

                        });

                      },
                      icon: Icon(
                        Icons.check_rounded,
                        size: 35,
                      ))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 250,
                child: SfRadialGauge(axes: <RadialAxis>[
                  RadialAxis(minimum: 16, maximum: 41, ranges: <GaugeRange>[
                    GaugeRange(
                        startValue: 16, endValue: 18.4, color: Colors.green),
                    GaugeRange(
                        startValue: 18.5, endValue: 24.9, color: Colors.orange),
                    GaugeRange(startValue: 25, endValue: 41, color: Colors.red)
                  ], pointers: <GaugePointer>[
                    NeedlePointer(value: ans?.toDouble()?? 0)
                  ], annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                        widget: Container(
                            child: Text(ans?.toStringAsFixed(1)?? '0',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold))),
                        angle: 90,
                        positionFactor: 0.5)
                  ])
                ]),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Very Severely Underweight',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: (ans?.toDouble() ?? 0) <= 15.9
                                ? Colors.green
                                : Colors.black,
                            letterSpacing: 0.4
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '<- 15.9',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: (ans?.toDouble() ?? 0) <= 15.9
                                ? Colors.green
                                : Colors.black,
                            letterSpacing: 0.4
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Severely Underweight',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: ((ans?.toDouble() ?? 0) >= 16.0 &&
                                    (ans?.toDouble() ?? 0) <= 16.9)
                                ? Colors.green
                                : Colors.black,
                            letterSpacing: 0.4
                        ),
                      ),
                      Text(
                        '16.0 - 16.9',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: ((ans?.toDouble() ?? 0) >= 16.0 &&
                                    (ans?.toDouble() ?? 0) <= 16.9)
                                ? Colors.green
                                : Colors.black,
                            letterSpacing: 0.4
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Underweight',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: ((ans?.toDouble() ?? 0) >= 17.0 &&
                                    (ans?.toDouble() ?? 0) <= 18.4)
                                ? Colors.green
                                : Colors.black,
                            letterSpacing: 0.4
                        ),
                      ),
                      Text(
                        '17.0 - 18.4',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: ((ans?.toDouble() ?? 0) >= 17.0 &&
                                    (ans?.toDouble() ?? 0) <= 18.4)
                                ? Colors.green
                                : Colors.black,
                            letterSpacing: 0.4
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Normal',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: ((ans?.toDouble() ?? 0) >= 18.5 &&
                                    (ans?.toDouble() ?? 0) <= 24.9)
                                ? Colors.green
                                : Colors.black,
                            letterSpacing: 0.4
                        ),
                      ),
                      Text(
                        '18.5 - 24.9',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: ((ans?.toDouble() ?? 0) >= 18.5 &&
                                    (ans?.toDouble() ?? 0) <= 24.9)
                                ? Colors.green
                                : Colors.black,
                            letterSpacing: 0.4
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Overweight',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: ((ans?.toDouble() ?? 0) >= 25.0 &&
                                    (ans?.toDouble() ?? 0) <= 29.9)
                                ? Colors.green
                                : Colors.black,
                            letterSpacing: 0.4
                        ),
                      ),
                      Text(
                        '25.0 - 29.9',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: ((ans?.toDouble() ?? 0) >= 25.0 &&
                                    (ans?.toDouble() ?? 0) <= 29.9)
                                ? Colors.green
                                : Colors.black,
                            letterSpacing: 0.4
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Obese Class |',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: ((ans?.toDouble() ?? 0) >= 30.0 &&
                                    (ans?.toDouble() ?? 0) <= 34.9)
                                ? Colors.green
                                : Colors.black,
                            letterSpacing: 0.4
                        ),
                      ),
                      Text(
                        '30.0 - 34.9',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: ((ans?.toDouble() ?? 0) >= 30.0 &&
                                    (ans?.toDouble() ?? 0) <= 34.9)
                                ? Colors.green
                                : Colors.black,
                            letterSpacing: 0.4
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Obese Class ||',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: ((ans?.toDouble() ?? 0) >= 35.0 &&
                                    (ans?.toDouble() ?? 0) <= 39.9)
                                ? Colors.green
                                : Colors.black,
                            letterSpacing: 0.4
                        ),
                      ),
                      Text(
                        '35.0 - 39.9',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: ((ans?.toDouble() ?? 0) >= 35.0 &&
                                    (ans?.toDouble() ?? 0) <= 39.9)
                                ? Colors.green
                                : Colors.black,
                            letterSpacing: 0.4
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Obese Class |||',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: (ans?.toDouble() ?? 0) >= 45.0
                                ? Colors.green
                                : Colors.black,
                            letterSpacing: 0.4
                        ),
                      ),
                      Text(
                        '>= 45.0',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: (ans?.toDouble() ?? 0) >= 45.0
                                ? Colors.green
                                : Colors.black,
                            letterSpacing: 0.4
                        ),
                      )
                    ],
                  ),
                  Center(
                    child: Text(
                      "Normal Weight: 117.9 - 159.4 lb",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 24,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    ageController.clear();
    ftController.clear();
    inchController.clear();
    wtController.clear();
  }
}
