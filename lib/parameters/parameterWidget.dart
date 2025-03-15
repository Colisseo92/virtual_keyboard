import 'package:flutter/material.dart';
import 'package:virtual_keyboard/parameters/services/ParameterManager.dart';

void showSettingsMenu(BuildContext context, Parameter parameter) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Allows fullscreen height if needed
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return AnimatedContainer(
        duration: Duration(milliseconds: 300), // Smooth animation
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height, // Adjust size as needed
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Settings", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
            Divider(),
            SafeArea(
              child: ExpansionTile(
                leading: Icon(Icons.palette),
                title: Text("Theme"),
                children: [
                  ListTile(
                    leading: Icon(Icons.dark_mode),
                    title: Text("Dark"),
                    onTap: (){
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.light_mode),
                    title: Text("Light"),
                    onTap: (){
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.palette),
              title: Text("Change Theme"),
              onTap: () {
                // Handle theme change
              },
            ),
            ListTile(
              leading: Icon(Icons.tune),
              title: Text("Adjust Sensitivity"),
              onTap: () {
                // Handle sensitivity adjustment
              },
            ),
          ],
        ),
      );
    },
  ).then((value){
    print("Option closed");
  });
}