import 'package:flutter/material.dart';
import 'dart:math';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: const App(title: ''));
  }
}

class App extends StatefulWidget {
  const App({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  String? challenge;
  List<String> names = ["robin", "michele", "simon", "gergö", "ale", "flo"];
  String? name;
  var random = Random();

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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => StartPage()));
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

class StartPage extends StatefulWidget {
  StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text("Welcom to drincc",
            style: TextStyle(
                fontSize: 40,
                color: Colors.white,
                fontStyle: FontStyle.italic)),
      ),
    );
  }
}
