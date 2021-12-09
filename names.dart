import 'package:shared_preferences/shared_preferences.dart';

class Names {  
  void save(List<String> stringList) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setStringList('names', stringList);
  }

  Future<List<String>> load() async {    
    var prefs = await SharedPreferences.getInstance();    
    List<String>? list = prefs.getStringList("names");
    list == null ? list = [] : list;
    return list;
  }

  void addName(String name) async {
    var prefs = await SharedPreferences.getInstance();
    List<String>? list = prefs.getStringList("names");
    list == null ? list = [] : list;
    list.add(name);
    save(list);
  }

  Future<void> remove() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
