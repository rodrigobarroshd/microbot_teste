import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:microbot/models/order.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Demo MicroBot",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ); // MaterialApp
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool loading = false;
  Order? order;




  Future<void> checkout() async {

    setState(() {
      loading = true;
    });

    try {
      final response = await Dio().post(
          'https://parseapi.back4app.com/functions/checkout',
          options: Options(
            headers: {
              'X-Parse-Application-Id': 'qKfrSCqZ2ofB3uDRKvX922XbO7nJpl5BraSKXrgZ',
              'X-Parse-REST-API-Key': 'xQOVNAQzWw8s8ZRs5NWsoEKCWfUnvPDB1MtDRel9',
              'X-Parse-Session-Token': 'r:165efdc378d10f438a6cddbc214af63c',
              'Content-Type': 'application/json'
            },
          ),
          data: {
            "total": 0.01
          }

      );

      // order = Order.fromJson(response.data['result']);
      // print(order.qrCodeImage);
      setState(() {
        order = Order.fromJson(response.data['result']);
      });

    } on DioException catch (e) {
      print(e.response);
    }

    setState(() {
      loading = false;
    });
  }


  


















@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Demo MicroBot'),
      backgroundColor: const Color(0xFFF37021),
    ),
    body: Builder(builder: (_){
      if(loading) {
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Color(0xFFF37021)),
          ),
        );
      }

      if(order != null){
        return Center(
          child: Image.memory(base64Decode(order!.qrCodeImage.substring(22))),
        );
      }

      return Center(
        child: ElevatedButton(
          onPressed: () {
            checkout();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF37021),
            fixedSize: const Size(150, 50),
          ),
          child: const Text('Gerar cobrança'),
        ),
      );

    },)
  );
}}
