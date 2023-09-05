import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final idController = TextEditingController();
final _csvFormKey = GlobalKey<FormState>();
  List<List<dynamic>> _data = [];
  // List<List<dynamic>> _newData = [];

  

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
          print(_data);
    });
  }

void addDataToCSV( List<List<dynamic>> dataToAdd) async {
  final File file = File("assets/mycsv.csv");

  // Read the existing data from the CSV file
  List<List<dynamic>> csvData = [];

  if (await file.exists()) {
    String fileContent = await file.readAsString();
    csvData = CsvToListConverter().convert(fileContent);
  }

  // Add new data to the existing data
  csvData.addAll(dataToAdd);

  // Convert the data back to CSV format
  String csvContent = const ListToCsvConverter().convert(csvData);

  // Write the updated data to the CSV file
  await file.writeAsString(csvContent);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 211, 226, 252),
        title: const Text("CSV" ),
        titleTextStyle: const TextStyle(color:Colors.black,fontSize: 41 ),
        centerTitle: true
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
             Form(
              key: _csvFormKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: idController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText:"ID",
                        hintText: "Enter Your Id"),
                     ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText:"Name",
                        hintText: "Enter Your Name"),
                     ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: ageController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText:"Age",
                        hintText: "Enter Your Age"),
                     ),
                  ),
                 ElevatedButton(
                  onPressed: (){
                    setState(() {
                    _data.add([idController.text,nameController.text,ageController.text]);
                    addDataToCSV(_data);
                      
                    
                    });
                  },
                   child: const Text("Sumbit"))
                  
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                shrinkWrap: true,
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
            ),
          ],
        ),
      ),
    );
  }
}