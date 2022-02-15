import 'package:flutter/material.dart';
import '../sendToServer.dart';

Widget projectWidget() {
  return FutureBuilder<List<Album>>(
    builder: (context, projectSnap) {
      if (projectSnap.connectionState == ConnectionState.none &&
          projectSnap.data == null) {
        return const CircularProgressIndicator();
      }
      if (projectSnap.connectionState == ConnectionState.done) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: projectSnap.data!.length,
              itemBuilder: (context, index) {
                Album project = projectSnap.data![index];
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(project.name),
                      // Widget to display the list of project
                    ],
                  ),
                );
              },
            ) ,
          ],
        );
      }
      return Container();
    },
    future: fetchAlbum(),
  );
}
