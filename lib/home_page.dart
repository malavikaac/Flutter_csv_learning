import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
   final 
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CSV"),
        centerTitle: true
      ),
      body:Column(
        children: [
          TextFormField( ),
          TextFormField( ),
          
        ],
      ),
    );
  }
}