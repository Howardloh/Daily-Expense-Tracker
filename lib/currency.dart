import 'package:flutter/material.dart';
import 'package:app/api/api_client.dart';
import 'package:app/drop_down.dart';
import 'package:hexcolor/hexcolor.dart';

class Currency extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Currency> {
  //call the API
  ApiClient client = ApiClient();

  //setting main color
  Color mainColor = const Color(0xFF212936);
  Color secondColor = const Color(0xff2849E5);

  //setting the varaible
  late List<String> currencies = [];
  late String from = 'USD';
  late String to = 'MYR';

  //variables for exchange rate
  double rate = 1;
  String result = '';

  //Make function to call API
  Future<List<String>> getCurrencyList() async {
    return await client.getCurrencies();
  }

  @override
  void initState() {
    (() async {
      List<String> list = await client.getCurrencies();
      setState(() {
        currencies = list;
      });
    })();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: HexColor("#831483"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/calendar");
            },
          )),
      backgroundColor: mainColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 200.0,
                child: Text(
                  "Currency Converter",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextField(
                        onSubmitted: (value) async {
                          rate = await client.getRate(from, to);
                          setState(() {
                            result =
                                (rate * double.parse(value)).toStringAsFixed(3);
                          });
                        },
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: "Input value to convert",
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 18.0,
                              color: secondColor,
                            )),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          customDropDown(currencies, from, (val) {
                            setState(() {
                              from = val;
                            });
                          }),
                          FloatingActionButton(
                            onPressed: () {
                              String temp = from;
                              setState(() {
                                from = to;
                                to = temp;
                              });
                            },
                            child: const Icon(Icons.swap_horiz),
                            elevation: 0.0,
                            backgroundColor: secondColor,
                          ),
                          customDropDown(currencies, to, (val) {
                            setState(() {
                              to = val;
                            });
                          })
                        ],
                      ),
                      const SizedBox(height: 50.0),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Result",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${result}",
                              style: TextStyle(
                                color: secondColor,
                                fontSize: 36.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
