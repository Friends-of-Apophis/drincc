import 'package:drincc/names.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';


class NamePage extends StatefulWidget {
  NamePage({Key? key}) : super(key: key);

  @override
  _NamePageState createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  Names names = Names();
  String name = " ";
  List<String> nameslist = [];
  var prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    names.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '',
        home: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: Container(
              child: const Text('Names',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontStyle: FontStyle.italic)),
              padding:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
            ),
            bottom: PreferredSize(
                child: Container(
                  color: Colors.white,
                  height: 1.0,
                ),
                preferredSize: Size.fromHeight(1.0)),
            backgroundColor: Colors.black,
          ),
          body: Builder(builder: (context) {
            return Center(
                child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const App()));
                    },
                    child: const Text('Add the players',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontStyle: FontStyle.normal)),
                    style: TextButton.styleFrom(
                      shadowColor: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (value) => {name = value},
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        fillColor: Colors.black,
                        filled: true,
                        hintText: "name",
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),borderSide: BorderSide(color: Colors.white, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(1),borderSide: BorderSide(color: Colors.white, width: 1.0),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        names.addName(name);
                        setState(() {
                          nameslist.add(name);
                        });
                        name = " ";
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          shadowColor:
                              MaterialStateProperty.all<Color>(Colors.white)),
                      child: const Text("Save name")),
                  ElevatedButton(
                      onPressed: () {
                        names.remove();
                        setState(() {
                          nameslist = [];
                        });
                        name = " ";
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          shadowColor:
                              MaterialStateProperty.all<Color>(Colors.white)),
                      child: const Text("Clear")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const App()));
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          shadowColor:
                              MaterialStateProperty.all<Color>(Colors.white)),
                      child: const Text("Continue")),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(8),
                      itemCount: nameslist.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            height: 50,
                            child: Text(
                              nameslist[index],
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ));
                      })
                ],
              ),
            ));
          }),
        ));
  }
}
