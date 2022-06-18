import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'src/locations.dart' as locations;
// import 'package:flutter/material.dart';
// //import 'package:latlong/latlong.dart';
// import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
// import 'dart:convert';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();

    setState(() {
      for (final office in googleOffices.offices) {
        print(office.name);
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar:PreferredSize(
          preferredSize: Size.fromHeight(100.0), // here the desired height
          child:  AppBar(
          title: const Text('DISEASE IDENTIFICATION AND MONITORING \n Highest cases:Bangalore - Corona-1.5L Dengue-1185 and active cases-648 \n Lowest Cases:Agumbe - Corona-587 Dengue-11 and Active cases-0'),
          toolbarHeight:100.0,
          backgroundColor: Colors.green[700],
          ),
        ),
        
        
       
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: const CameraPosition(
            target: LatLng(0, 0),
            zoom: 2,
          ),
          markers: _markers.values.toSet(),
        ),
      ),
    );
  }
}
