import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<List<dynamic>> _data = [];

  @override
  void initState() { 
    super.initState();
     _loadCSV();
  } // Display the contents from the CSV file

  void _loadCSV() async {
    final _rawData = await rootBundle.loadString("assets/mycsv.csv");
    List<List<dynamic>> _listData =
    const CsvToListConverter().convert(_rawData);
    
    setState(() {
      _data = _listData;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _data.length,
        itemBuilder: (_, index) {
          return Card(
            margin: const EdgeInsets.all(3),
            color: index == 0 ? Color.fromARGB(255, 255, 230, 167) : Colors.white,
            child: ListTile(
              leading: Text(_data[index][0].toString()),
              title: Text(_data[index][1]),
              trailing: Text(_data[index][2].toString()),
            ),
          );
        },
      ),
    );
  }
}