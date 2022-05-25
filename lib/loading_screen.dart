import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'coin_data.dart';
import 'price_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

CoinData coinData1 = CoinData();

class _LoadingScreenState extends State<LoadingScreen> {
  Future<void> getData() async {
    //var responseData = await coinData1.getDataFromAPI('USD');

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) {
    //     return PriceScreen(coinData: responseData);
    //   }),
    // );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.fallingDot(
            color: Colors.lightBlue, size: 20.0),
      ),
    );
  }
}
