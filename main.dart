import 'package:drincc/names.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const StartPage());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: const App());
  }
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  String? challenge;
  List<String> names = ["robin", "michele", "simon", "gergö", "ale", "flo"];
  String? name;
  var random = Random();
  Names namesclass = Names();

  void loadNamesFromPrefs() {
    var prefs = SharedPreferences.getInstance();
    prefs.then((value) {
      names = value.getStringList("names") ?? [];
    });
  }

  void getChallenge() async {
    final response = await http.get(Uri.parse(
        'https://drincc.azurewebsites.net/api/getChallenge?code=6TkEl/q59vrfdenzW1Fv274hW7PnheSVF8As6MVNzGOLDLZp3wOyzA=='));
    if (response.statusCode == 200) {
      setState(() {
        challenge = response.body;
      });
    }
  }

  void getName() {
    int rand = random.nextInt(names.length);
    setState(() {
      name = names[rand];
    });
  }

  @override
  void initState() {
    getChallenge();
    getName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Container(
          child: const Text('Challenge',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontStyle: FontStyle.italic)),
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
        ),
        bottom: PreferredSize(
            child: Container(
              color: Colors.white,
              height: 1.0,
            ),
            preferredSize: Size.fromHeight(1.0)),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(border: Border.all()),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Center(
                  child: Text(name ?? '',
                      style: (const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontStyle: FontStyle.italic))),
                ),
                margin: const EdgeInsets.only(bottom: 100.0),
              ),
              Container(
                child: Center(
                  child: Text(challenge ?? '',
                      style: (const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontStyle: FontStyle.italic))),
                ),
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.white),
                ),
                padding: const EdgeInsets.all(10.0),
                width: 800,
                margin: const EdgeInsets.only(bottom: 100.0),
              ),
              Align(
                child: TextButton(
                  onPressed: () {
                    getChallenge();
                    getName();
                  },
                  child: const Text('New Challenge',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontStyle: FontStyle.italic)),
                  style: TextButton.styleFrom(
                    shadowColor: Colors.white,
                  ),
                ),
                alignment: Alignment.bottomCenter,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '',
        home: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: Container(
              child: const Text('',
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
                preferredSize: const Size.fromHeight(1.0)),
            backgroundColor: Colors.black,
          ),
          body: Builder(builder: (context) {
            return Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NamePage()));
                },
                child: const Text('Welcome to Drincc',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontStyle: FontStyle.normal)),
                style: TextButton.styleFrom(
                  shadowColor: Colors.white,
                ),
              ),
            );
          }),
        ));
  }
}

class NamePage extends StatefulWidget {
  NamePage({Key? key}) : super(key: key);

  @override
  _NamePageState createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  Names names = Names();
  String name = " ";
  List<String> nameslist = [];

  @override
  void initState() {
    super.initState();
    var prefs = SharedPreferences.getInstance();
    prefs.then((value) {
      nameslist = value.getStringList("names") ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    var prefs = SharedPreferences.getInstance();
    prefs.then((value) {
      nameslist = value.getStringList("names") ?? [];
    });
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
                  TextFormField(
                    onChanged: (value) => {name = value},
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
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
