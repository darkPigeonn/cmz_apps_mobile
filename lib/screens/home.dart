import 'dart:convert';

import 'package:cmz_apps/screens/transactions/input_transaction.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url  =  'https://script.google.com/macros/s/AKfycbzDBSFhAB8N_by2G6QwprMqF31-mVTEimYniMW654ucc23CT0jMg0OGhAOl8XCjRIRe/exec';

  List<dynamic> sheetData = [];

  Future<void> fetchSheetData() async {
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) {
      print(response.body);
      setState(() {
        sheetData = json.decode(response.body);
      });
    }else{
      throw Exception('Failed to load sheet data');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSheetData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                // header start 
                Container(
                  child: Row(
                    children: [
                      Text('Come Zone Apps', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
                // header end 

                //summary start
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 120,
                  child: Card(
                    child: Container(                      
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tabungan saat ini'),
                          Text('Rp. 50.000.000', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  ),
                ),
                //summary end
              ],
            ),
          ),
        ),
      ),
      floatingActionButton:   FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> InputTransaction()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}