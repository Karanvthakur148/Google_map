import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'location_tracking.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({ required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   late GoogleMapController _controller;

  final CameraPosition _initialPosition =
  const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(22.800639, 75.908108),
      zoom: 25.4746);

  final List<Marker> markers = [];

  addMarker(cordinate) {
    int id = Random().nextInt(100);

    setState(() {
      markers
          .add(Marker(position: cordinate, markerId: MarkerId(id.toString())));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _initialPosition,
        mapType: MapType.normal,
        onMapCreated: (controller) {
          setState(() {
            _controller = controller;
          });
        },
        markers: markers.toSet(),
        onTap: (cordinate) {
          _controller.animateCamera(CameraUpdate.newLatLng(cordinate));
          addMarker(cordinate);
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 50),
        child: FloatingActionButton(
          onPressed: () {
           // _controller.animateCamera(CameraUpdate.zoomOut());
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return
              const LocationTracking();
            },));
          },
          child: const Icon(Icons.zoom_out),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}