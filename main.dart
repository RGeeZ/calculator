import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Calculator',
            textAlign: TextAlign.center,
          ),
        ),
        body: Contain(),
      ),
      theme: ThemeData(
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,
        brightness: Brightness.dark,
      ),
    );
  }
}

class Contain extends StatefulWidget {
  @override
  _ContainState createState() => _ContainState();
}

class _ContainState extends State<Contain> {
  var _formkey = GlobalKey<FormState>();
  @override
  final _minmarg = 5.0;
  var _currencies = ['Rupee', 'Dollar', 'Pound', 'Euro', 'Yen', 'Taka'];
  var _current = 'Rupee';
  var display = '';
  TextEditingController principalControlar = TextEditingController();
  TextEditingController roiControlar = TextEditingController();
  TextEditingController termControlar = TextEditingController();
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Form(
      key: _formkey,
      child: Padding(
        padding: EdgeInsets.all(_minmarg * 2),
        child: ListView(
          children: <Widget>[
            getImageAsset(),
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: TextFormField(
                // ignore: missing_return
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter principle';
                  }
                },
                controller: principalControlar,
                style: textStyle,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Principal',
                    hintText: 'e.g.2000',
                    labelStyle: textStyle,
                    errorStyle:
                        TextStyle(color: Colors.deepOrange, fontSize: 15.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: TextField(
                controller: roiControlar,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Rate of intrest',
                    hintText: 'P.A. 2.5',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: termControlar,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Term',
                          hintText: 'years',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    ),
                  ),
                  Container(
                    width: 10.0,
                  ),
                  Expanded(
                    child: DropdownButton<String>(
                        items: _currencies.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: _current,
                        onChanged: (String newValueSelected) {
                          _onDropDownItemSelected(newValueSelected);
                        }),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                /* Expanded(
                child:RaisedButton(
                  TextColor: Theme.of(context).primaryColorLight,
                  child:(color:Theme.of(context).primaryColorDark,
                      t'Calculate'),

                  onPressed: (){

                    setState(() {
                      if(_formkey.currentState.validate()) {
                        this.display = calculateTotalReturns();
                      }
                    });
                  },

                ),
              ),*/
                Container(
                  width: 5.0,
                ),
                Expanded(
                    child: RaisedButton(
                  color: Theme.of(context).accentColor,
                  child: Text('RESET'),
                  onPressed: () {
                    setState(() {
                      resetit();
                    });
                  },
                )),
              ],
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  this.display,
                  textScaleFactor: 1.5,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/image_hi.jpeg');
    Image image = Image(image: assetImage);
    return Container(
      margin: EdgeInsets.all(_minmarg * 10),
      child: Center(
        child: image,
      ),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._current = newValueSelected;
    });
  }

  String calculateTotalReturns() {
    double principal = double.parse(principalControlar.text);
    double roi = double.parse(roiControlar.text);
    double term = double.parse(termControlar.text);
    double totalAmountPayable = principal + (principal * roi * term) / 100;
    String result = '$term is $totalAmountPayable';
    return result;
  }

  void resetit() {
    principalControlar = "" as TextEditingController;
    roiControlar = '' as TextEditingController;
    termControlar = '' as TextEditingController;
    _current = _currencies[0];
  }
}
