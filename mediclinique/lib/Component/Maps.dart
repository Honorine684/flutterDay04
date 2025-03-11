import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() {
    return MapsState();
  }
}

class MapsState extends State<Maps> {
String locationadress = "Cliquer ici pour choisir une adresse";
  double latitude = 23;
  double longitude = 89;
  String? baseUri;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        
        padding: EdgeInsets.all(16.0),
        child: InkWell(
          child: Text(locationadress,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
          onTap: () {
            showModal(context);
          },
        ),
      ),
    );
  }

  // bottomSheet
  void showModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        
        return Container(
          height: 600,
          color: Colors.red,
          child: Center(
            child: OpenStreetMapSearchAndPick(
             // center: LatLong(latitude, longitude), 
              baseUri: 'https://www.openstreetmap.org/#map=7/9.336/2.313',
              buttonColor: Colors.blue,
              buttonText: 'Set Current Location',
              onPicked: (pickedData) {
                Navigator.pop(context);
                setState(() {
                  locationadress = pickedData.address as String;
                  latitude = pickedData.latLong.latitude;
                  longitude = pickedData.latLong.longitude; 
                });
              },
            ),
          ),
        );
      },
    );
  }
}