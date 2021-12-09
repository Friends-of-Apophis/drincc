import 'package:flutter/material.dart';
import 'namepage.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '',
        home: Scaffold(
          backgroundColor: Colors.black,
          body: Builder(builder: (context) {
            return Container(
              
        margin: const EdgeInsets.symmetric(vertical: 50.0),
              child: Center(
                child: ListView(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                      "Welcome to Drincc",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    )),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => NamePage()));
                    },
                    child: Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.white, style: BorderStyle.solid)),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Continue',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontStyle: FontStyle.normal)),
                      ),
                    ),
                  ),
                ]),
              ),
            );
          }),
        ));
  }
}
