import 'dart:async';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'coin_data.dart';
import 'package:bitcoin_flutter/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String rateBTC = '?';
  String rateETH = '?';
  String rateLTC = '?';

  CoinData coinData1 = CoinData();

  // void updateUI(dynamic data) {
  //   setState(() {
  //     if (data == null) {
  //       rate = '?';
  //       return;
  //     }
  //     //rate = data['rate'];
  //     rate = data as double;
  //   });
  // }

  DropdownButton<String> getAndroidList() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String item in currenciesList) {
      var newItem = DropdownMenuItem(child: Text(item), value: item);
      dropDownItems.add(newItem);
    }
    return DropdownButton<String>(
      items: dropDownItems,
      value: selectedCurrency,
      onChanged: (value) {
        print(selectedCurrency);
        setState(
          () {
            selectedCurrency = value!;
          },
        );
      },
    );
  }

  CupertinoPicker getIosList() {
    List<Text> pickerItems = [];
    for (String item in currenciesList) {
      var newItem = Text(
        item,
        style: const TextStyle(fontSize: 20.0),
      );
      pickerItems.add(newItem);
    }
    return CupertinoPicker(
      onSelectedItemChanged: (int value) {
        //if (selectedCurrency == 'USD') {}
        //print(currenciesList[value]);
        setState(() {
          selectedCurrency = currenciesList[value];
          getData();
        });
      },
      itemExtent: 32.0,
      children: pickerItems,
    );
  }

  void getData() async {
    try {
      double data1 =
          await coinData1.getDataFromAPI(selectedCurrency, cryptoList[0]);
      double data2 =
          await coinData1.getDataFromAPI(selectedCurrency, cryptoList[1]);
      double data3 =
          await coinData1.getDataFromAPI(selectedCurrency, cryptoList[2]);
      setState(() {
        rateBTC = data1.toStringAsFixed(0);
        rateETH = data2.toStringAsFixed(0);
        rateLTC = data3.toStringAsFixed(0);
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //updateUI(widget.coinData);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coin Ticker'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Cards(
            bitCoin: cryptoList[0],
            rate: rateBTC,
            currency: selectedCurrency,
          ),
          Cards(
            bitCoin: cryptoList[1],
            rate: rateETH,
            currency: selectedCurrency,
          ),
          Cards(
            bitCoin: cryptoList[2],
            rate: rateLTC,
            currency: selectedCurrency,
          ),
          Container(
            height: 150,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 15.0),
            color: Colors.lightBlue,
            child: getIosList(),
          ),
        ],
      ),
    );
  }
}

class Cards extends StatelessWidget {
  Cards({required this.bitCoin, required this.rate, required this.currency});
  final String bitCoin;
  final String rate;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $bitCoin = $rate $currency',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
