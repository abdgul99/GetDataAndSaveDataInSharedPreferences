// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo App For Shared preference',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final textController;
  String saveText = '';
  String getText = '';
  //save data to sharedPreferences Function
  void saveData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString('text', saveText);
  }

//getting data from sharedPreferences Function
  void getData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    setState(() {
      getText = sharedPreferences.getString('text')!;
    });
  }

  @override
  void initState() {
    textController = TextEditingController();
    //calling the saved data from the shared_preferenses at the starting of app
    getData();
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Push data and Get data'),
          ),
        ),
        body: Material(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            // a Column Widget to hold all other Widgets
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Card(
                  elevation: 10.0,
                  color: Color.fromARGB(255, 92, 142, 230),
                  child: TextField(
                    cursorHeight: 20.0,
                    cursorColor: Colors.black,
                    controller: textController,
                    decoration: InputDecoration(
                        hintText: 'Something to save...',
                        hintStyle: TextStyle(
                            color: Colors.black38, fontWeight: FontWeight.bold),
                        focusColor: Colors.amberAccent,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4.0),
                          ),
                        )),
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      //getting the text field value and assign to saveText String variable
                      saveText = value;
                    },
                  ),
                ),
                Center(
                  child: Card(
                    elevation: 10.0,
                    color: Color.fromARGB(255, 175, 202, 184),
                    child: Container(
                      height: 50.0,
                      child: Center(
                          child: Text(
                        //Showing Saved data to the user
                        'Saved Data: $getText',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Card(
                        elevation: 10.0,
                        // a simple flateButton to save the user input text
                        child: FlatButton(
                          textColor: Colors.white,
                          color: Color.fromARGB(255, 92, 142, 230),
                          highlightColor: Color.fromARGB(255, 0, 0, 0),
                          onPressed: () {
                            setState(() {
                              //calling the savedData function
                              saveData();

                              textController.clear();
                            });
                          },
                          child: Text('Save Data'),
                        ),
                      ),
                      Card(
                        elevation: 10.0,
                        //simple flatButton to get the user saved data
                        child: FlatButton(
                          textColor: Colors.white,
                          color: Color.fromARGB(255, 70, 109, 83),
                          highlightColor: Color.fromARGB(255, 0, 0, 0),
                          onPressed: () {
                            //calling the saved function to show the user saved data
                            getData();
                          },
                          child: Text('Get Data'),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
