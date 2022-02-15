import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import './sendToServer.dart';
import './widgets/popUp.dart';
import './widgets/listView.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.white, fontFamily: 'Staatliches-Regular'),
        home: TabBarDemo());
  }
}

class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Staatliches-Regular'),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              indicatorColor: Colors.white,
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(
                  text: "FILE",
                ),
                Tab(
                  text: "Tables",
                ),
              ],
            ),
            title: const Text(
              'cyber-physical systems',
              style: TextStyle(fontFamily: 'Staatliches-Regular'),
            ),
            backgroundColor: Colors.blueAccent,
            centerTitle: true,
          ),
          body: TabBarView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Open your file here",
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        child: SizedBox(
                          width: screenWidth * 0.7,
                          child: ElevatedButton(
                            child: const Text('PICK FILE'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                            ),
                            //aaa
                            onPressed: () async {
                              final res = await FilePicker.platform.pickFiles();
                              if (res == null) return;
                              final pickedFile = await res.files.first;
                              int resReq =
                                  await sendFileToProcessing(pickedFile);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    buildPopupDialog(context, resReq),
                              );
                            },
                          ),
                        ),
                      ),
                      /*
                      * Future adding of several files
                      *
                      Padding(
                        padding: EdgeInsets.all(screenWidth*0.05),
                        child: SizedBox(
                          width: screenWidth * 0.7,
                          child: ElevatedButton(
                            child: const Text('PICK FILES'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                            ),
                            onPressed: () async {
                              FilePickerResult? res = await FilePicker.platform.pickFiles(allowMultiple: true);
                              if (res == null) return;
                              final pickedFile = res.files;
                              print(pickedFile);
                              // sendFilesToProcessing(files);
                            },
                          ),
                        ),
                      ),
                      */
                    ],
                  )
                ],
              ),
              projectWidget(),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              children: const <Widget>[
                ListTile(
                  title: Text("Lab 1"),
                  trailing: Icon(Icons.arrow_back),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
