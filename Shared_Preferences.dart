dependencies:
  cupertino_icons: ^1.0.2
  flutter:
    sdk: flutter
  shared_preferences: ^2.2.1  // Add this Package in your pubspec.yaml file

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesApp extends StatefulWidget {
  const SharedPreferencesApp({super.key});

  @override
  State<SharedPreferencesApp> createState() => SharedPreferencesAppState();
}

class SharedPreferencesAppState extends State<SharedPreferencesApp> {
  SharedPreferences? prefs;
  String? data;
  int? counter;
  double? decimal;
  bool? isstored;
  List<String> lang=[];
  TextEditingController textcontroller=TextEditingController();
  @override
  void initState() {
    super.initState();
    initialize();
  }
  initialize()async{
    prefs=await SharedPreferences.getInstance();
    getdata();
  }
  adddata()async{
    await prefs!.setString('Data', 'Khoob Coding');
    await prefs!.setInt('counter', 1000);
    await prefs!.setDouble('decimal', 99.99);
    await prefs!.setBool('isstored', true);
    await prefs!.setStringList('lang', ['Python','Dart','Java']);
    print(prefs!.containsKey('Data'));//will return true if present
    print(prefs!.getKeys());// return all the keys which are present in the database
    
  }
  getdata(){
    data=prefs!.getString('Data') ??'No Data';
    counter=prefs!.getInt('counter')??0;
    decimal=prefs!.getDouble('decimal')??0.00;
    isstored=prefs!.getBool('isstored')??false;
    lang=prefs!.getStringList('lang')?? ['No Data'];
    setState(() {
      
    });
  }
  removedata()async{
    await prefs!.remove('Data');
    setState(() {
      
    });
  }
  cleardata()async{
    await prefs!.clear();
    setState(() {
      
    });
  }
  editdata(String data)async{
    await prefs!.setString('Data', data);
    getdata();
  }
  reloaddata()async{
    await prefs!.reload().then((value) {
      debugPrint('data Reloaded');
      getdata();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shared Preferences App',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 47, 125, 251),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
               Text(
                data??'',
                style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 37,
                    fontWeight: FontWeight.bold),
              ),
               Text(
                counter.toString(),
                style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 37,
                    fontWeight: FontWeight.bold),
              ),
               Text(
                decimal.toString(),
                style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 37,
                    fontWeight: FontWeight.bold),
              ),
               Text(
                isstored.toString(),
                style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 37,
                    fontWeight: FontWeight.bold),
              ),
               Text(
                lang.toString(),
                style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 37,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                width: 250,
                child: TextFormField(
                  controller: textcontroller,
                  onEditingComplete: () {
                    editdata(textcontroller.text);
                  },
                  decoration: InputDecoration(
                      hintText: 'Write something',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                    fixedSize: const MaterialStatePropertyAll(Size(220, 35)),
                    backgroundColor: const MaterialStatePropertyAll(
                      Colors.red,
                    )),
                onPressed: adddata,
                child: const Text('Add Data'),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                    fixedSize: const MaterialStatePropertyAll(Size(220, 35)),
                    backgroundColor: const MaterialStatePropertyAll(
                      Colors.teal,
                    )),
                onPressed: getdata,
                child: const Text('Get Data'),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                    fixedSize: const MaterialStatePropertyAll(Size(220, 35)),
                    backgroundColor: const MaterialStatePropertyAll(
                      Colors.indigo,
                    )),
                onPressed:reloaddata,
                child: const Text(
                  'Reload Data',
                  style: TextStyle(),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                    fixedSize: const MaterialStatePropertyAll(Size(220, 35)),
                    backgroundColor: const MaterialStatePropertyAll(
                      Colors.blue,
                    )),
                onPressed: removedata,
                child: const Text('Remove Data'),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                    fixedSize: const MaterialStatePropertyAll(Size(220, 35)),
                    backgroundColor: MaterialStatePropertyAll(
                      Colors.amber.shade700,
                    )),
                onPressed: cleardata,
                child: const Text(
                  'Clear Data',
                  style: TextStyle(
                    color: Color.fromARGB(255, 33, 33, 33),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
