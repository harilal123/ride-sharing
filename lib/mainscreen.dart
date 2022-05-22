import 'dart:async';

import 'package:MyTaxi/divider.dart';
import 'package:MyTaxi/searchscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocode/geocode.dart';

// ignore: camel_case_types
class mainscreen extends StatefulWidget {
  const mainscreen({Key? key}) : super(key: key);

  @override
  _mainscreenState createState() => _mainscreenState();
}

// ignore: camel_case_types
class _mainscreenState extends State<mainscreen> {
  Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController newgoogleMapController;
  double bottompaddingMap = 0;
  

  var geolocator = Geolocator();
  late Position currentPosition;
  GeoCode geoCode = GeoCode();
  String addresses="Address";
  
  
  

  void locatepositon() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latlangPosition =
        LatLng(currentPosition.latitude, currentPosition.longitude);
    CameraPosition cameraposition =
        new CameraPosition(target: latlangPosition, zoom: 13.4746);
    newgoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraposition));
    Address address = await geoCode.reverseGeocoding(
        latitude: position.latitude, longitude: position.longitude);
    
    String s3 = "${address.streetAddress}";
    String s4 = "${address.city}";
    String s5 = " ${address.region}";
    print(s3+" "+s4+" "+s5);
    addresses = s3+" "+s4+" "+s5;
    setState(() {
      // ignore: unnecessary_statements
      addresses;
    });
    
   
    
   

  }


    
    
    
  

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(26.79293340709961, 87.2924131598758),
    zoom: 13.4746,
  );
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main screen"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottompaddingMap),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              newgoogleMapController = controller;

              setState(() {
                bottompaddingMap = 265.0;
              });
              locatepositon();
            },
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container(
              height: 270.0,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18.0),
                      topRight: Radius.circular(18.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 16.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 18.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 6.0,
                      ),
                      Text(
                        "Hi there,",
                        style: TextStyle(fontSize: 12.0, color: Colors.white),
                      ),
                      Text(
                        "Where to?,",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "Brand-Bold",
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      GestureDetector(
                        onTap: (() {
                           Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Search(addresses: addresses),
                    ),);
                        }),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 6.0,
                                  spreadRadius: 0.5,
                                  offset: Offset(0.7, 0.7),
                                )
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: Colors.blueAccent,
                                ),
                                SizedBox(width: 10.0),
                                Text("Search Drop off"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      Row(
                        children: [
                          Icon(
                            Icons.home,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Column(
                            
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              
                             
                              Text( addresses,
                                  style: TextStyle(color: Colors.white)),
                                  
                              SizedBox(height: 4),
                              Text(
                                "Your living home Address",
                                style: TextStyle(
                                    color: Colors.white54, fontSize: 10),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      divider(),
                      SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.work,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Add work",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Your office Address",
                                style: TextStyle(
                                    color: Colors.white54, fontSize: 10),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }

}


