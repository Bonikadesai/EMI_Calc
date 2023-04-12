import 'package:flutter/material.dart';

class EmiCalc extends StatefulWidget {
  const EmiCalc({Key? key}) : super(key: key);

  @override
  State<EmiCalc> createState() => _EmiCalcState();
}

class _EmiCalcState extends State<EmiCalc> {
  var p;
  var r;
  var n;

  double ans = 0;
  double la = 0;
  double ir = 0;
  double lt = 0;

  double sliderVal = 0;
  Color activeColor = Colors.green;

  List myValues = [
    {
      'title': "Loan Amount",
      'min': 10000.0,
      'max': 1000000.0,
      'value': 10000.0,
      'label': '₹',
    },
    {
      'title': "Interest Rate",
      'min': 6.0,
      'max': 20.0,
      'value': 6.0,
      'label': '%',
    },
    {
      'title': "Loan Tenure",
      'min': 6.0,
      'max': 120.0,
      'value': 6.0,
      'label': 'Months',
    },
  ];

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.grid_view_outlined,
        ),
        title: const Text("Emi app"),
        centerTitle: true,
        backgroundColor: const Color(0xff20295C),
        elevation: 0,
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: h,
              width: w,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff20295C),
                    Color(0xff0F2027),
                  ],
                  stops: [0.2, 0.4],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Container(
              height: h * 0.7,
              width: w,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    ...myValues
                        .map(
                          (e) => mySliderBox(
                            title: e['title'],
                            label: e['label'],
                            min: e['min'].toDouble(),
                            max: e['max'].toDouble(),
                            index: myValues.indexOf(e),
                          ),
                        )
                        .toList(),
                    SizedBox(
                      height: 35,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Ink(
                        child: InkWell(
                          child: Container(
                            height: 75,
                            width: 200,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xff20295C),
                              ),
                              color: Color(0xffE7EAFF),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              "Calculate",
                              style: TextStyle(
                                fontSize: 30,
                                color: Color(0xff20295C),
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              p = la;
                              r = ir;
                              n = lt;
                              r = r / 12 / 100;
                              ans = (p * r((1 + r) * n) ~/ (((1 + r) * n) - 1))
                                  .toDouble();
                            });
                          },
                          onDoubleTap: () {
                            setState(() {
                              ans = 0;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mySliderBox({
    required String title,
    required String label,
    required double min,
    required double max,
    required int index,
  }) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Column(
        children: [
          Text(title),
          Stack(
            alignment: Alignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffE5E6E8),
                ),
              ),
              Text(
                "${myValues[index]['value'].toInt().toString()} $label",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Slider(
            min: min,
            max: max,
            value: myValues[index]['value'].toDouble(),
            onChanged: (val) {
              setState(() {
                myValues[index]['value'] = val;
              });
            },
          ),
        ],
      ),
    );
  }
}
