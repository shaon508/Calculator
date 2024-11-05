import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_project/buttonData.dart';

class calculatorScreen extends StatefulWidget {
  @override
  State<calculatorScreen> createState() => _calculator();
}

class _calculator extends State<calculatorScreen> {
  String number1 = "";
  String operand = "";
  String number2 = "";

  @override
  Widget build(BuildContext context) {
    final Size = MediaQuery.of(context).size;
    return Scaffold(
      //
      //This is appBar of the calculator
      //
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            "Calculator",
            style: TextStyle(
              color: Colors.orange,
              fontFamily: 'NewFont',
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      //
      //This is the body of the calculator
      //
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  //  color: Colors.white24,
                  alignment: Alignment.bottomRight,
                  child: Text(
                    textAlign: TextAlign.end,
                    (number1 == "" && operand == "" && number2 == "")
                        ? "0"
                        : "$number1$operand$number2",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 48,
                    ),
                  ),
                ),
              ),
            ),
            //   SizedBox(
            //    height: 16,
            //   ),
            Wrap(
              children: calculatorButton.buttonValues
                  .map((value) => SizedBox(
                        height: Size.width / 5,
                        width: (value == calculatorButton.equal)
                            ? Size.width / 2
                            : Size.width / 4,
                        child: configureButton(value),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget configureButton(value) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(100),
        color: [calculatorButton.del, calculatorButton.clr].contains(value)
            ? Colors.blue.shade200
            : [
                calculatorButton.per,
                calculatorButton.multiply,
                calculatorButton.divide,
                calculatorButton.add,
                calculatorButton.subtract,
                calculatorButton.equal
              ].contains(value)
                ? Colors.orange
                : Colors.white24,
        child: InkWell(
          onTap: () => onButtonTap(value),
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onButtonTap(String value) {
    if (value == calculatorButton.del) {
      delete();
      return;
    } else if (value == calculatorButton.clr) {
      clear();
      return;
    } else if (value == calculatorButton.per) {
      convertToPercantage();
      return;
    } else if (value == calculatorButton.equal) {
      mainCalculation();
      return;
    }
    appendValue(value);
  }

  void mainCalculation() {
    if (number1.isEmpty || operand.isEmpty || number2.isEmpty) return;
    final num1 = double.parse(number1);
    final num2 = double.parse(number2);
    var result = 0.0;
    switch (operand) {
      case calculatorButton.add:
        result = num1 + num2;
        break;
      case calculatorButton.subtract:
        result = num1 - num2;
        break;
      case calculatorButton.multiply:
        result = num1 * num2;
        break;
      case calculatorButton.divide:
        result = num1 / num2;
        break;
    }
    setState(() {
      number1 = "$result";
      if (number1.endsWith(".0")) {
        number1 = number1.substring(0, number1.length - 2);
      }
      operand = "";
      number2 = "";
    });
  }

  void delete() {
    if (number2.isNotEmpty) {
      number2 = number2.substring(0, number2.length - 1);
    } else if (operand.isNotEmpty) {
      operand = "";
    } else if (number1.isNotEmpty) {
      number1 = number1.substring(0, number1.length - 1);
    }
    setState(() {});
  }

  void clear() {
    number1 = "";
    operand = "";
    number2 = "";
    setState(() {});
  }

  void convertToPercantage() {
    if (number1.isNotEmpty && operand.isNotEmpty && number2.isNotEmpty) {
      mainCalculation();
    }
    if (operand.isNotEmpty) {
      return;
    }
    final ans = double.parse(number1);
    setState(() {
      number1 = "${(ans / 100)}";
      operand = "";
      number2 = "";
    });
  }

  void appendValue(String value) {
    if (value != calculatorButton.dot && int.tryParse(value) == null) {
      if (number1.isNotEmpty && number2.isNotEmpty) {
        mainCalculation();
      }
      operand = value;
    } else if (number1.isEmpty || operand.isEmpty) {
      if (value == calculatorButton.dot &&
          number1.contains(calculatorButton.dot)) {
        return;
      } else if ((number1.isEmpty || number1 == calculatorButton.n0) &&
          value == calculatorButton.dot) {
        value = "0.";
      }
      number1 += value;
    } else if (number2.isEmpty || operand.isNotEmpty) {
      if (value == calculatorButton.dot &&
          number2.contains(calculatorButton.dot)) {
        return;
      } else if ((number2.isEmpty || number2 == calculatorButton.n0) &&
          value == calculatorButton.dot) {
        value = "0.";
      }
      number2 += value;
    }
    setState(() {});
  }
}
