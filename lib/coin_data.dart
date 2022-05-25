import 'dart:html';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'networking.dart';

const apikey = '54514D56-A2C5-4869-ACD5-218FA5756F37';
const main_url = 'https://rest.coinapi.io/v1/exchangerate/';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  // var dataToSend;
  // Future<dynamic> getDataFromAPI() async {
  //   NetworkHelper networkHelper1 =
  //       NetworkHelper(getUrl: '$main_url?apikey=$apikey');
  //   var responseData = await networkHelper1.getData();
  //   return responseData;
  // }
  Future<dynamic> getDataFromAPI(String currency, String cryptoId) async {
    try {
      //var string = Uri.parse('$main_url/BTC?apikey=$apikey');
      http.Response response = await http
          .get(Uri.parse('$main_url$cryptoId/$currency?apikey=$apikey'));

      if (response.statusCode == 200) {
        String data = response.body;
        var dataToSend = jsonDecode(data);
        return dataToSend['rate'];
      } else {
        print(response.statusCode);
      }
    } catch (error) {
      print(error);
    }
  }
}
