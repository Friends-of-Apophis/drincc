import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Names {
  Future<void> save(stringList) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setStringList('names', stringList);
  }

  Future<void> load() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.getStringList('names');
  }

  Future<void> remove() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove('names');
  }
}
