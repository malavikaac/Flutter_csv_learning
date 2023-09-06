import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';


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
  

  @override
  void initState() { 
    super.initState();
     _loadCSV();
 
  } // Display the contents from the CSV file

  void _loadCSV() async {
      final File file = File("assets/mycsv.csv");
    final _rawData = await file.readAsString();
    setState(() {
    List<List<dynamic>> _listData =
    const CsvToListConverter().convert(_rawData);
      _data = _listData;
          print(_data);
    });
  }

 Future<void> _updateCSV( {required String id,required String name,required String age}) async {
    final File file = File("assets/mycsv.csv");
    List<List<dynamic>> csvData = [];

    if (await file.exists()) {
      String fileContent = await file.readAsString();
      csvData = CsvToListConverter().convert(fileContent);
    }

    csvData.add([id,name,age]);
    String newCSVContent = ListToCsvConverter().convert(csvData);

    await file.writeAsString(newCSVContent);
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 241, 229, 247),
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
                    padding: const EdgeInsets.all(16.0),
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
                    _updateCSV(age:ageController.text,id:idController.text,name: nameController.text  );
                  Future.delayed(const Duration(milliseconds: 500),(){
                      _loadCSV();
                  }); 
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
                    color: index == 0 ? Color.fromARGB(255, 232, 219, 250) : Color.fromARGB(255, 239, 224, 243),
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