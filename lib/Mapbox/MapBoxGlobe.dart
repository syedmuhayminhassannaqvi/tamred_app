import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:ui';
import 'package:morphable_shape/morphable_shape.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart'; // Contains Flutter's Size class




import '../CustomWidgets/MapSlider.dart';
import '../CustomWidgets/MapSlider.dart';
import '../CustomWidgets/triangle.dart';
import '../demo.dart';

class MapBoxGlobe extends StatefulWidget {
  @override
  State createState() => MapBoxGlobeState();
}

class MapBoxGlobeState extends State<MapBoxGlobe> {
  MapboxMap? mapboxMap;
  var isLight = true;

  _onMapCreated(MapboxMap mapboxMap) {
    this.mapboxMap = mapboxMap;
    mapboxMap.style;
    mapboxMap.compass;
  }

  // Add functions from LocationPageBodyState
  Widget _getPermission() {
    return TextButton(
      child: Text('get location permission'),
      onPressed: () async {
        Get.snackbar(
          "Request",
          "To Get Current Location",
          duration: Duration(seconds: 2),
          snackStyle: SnackStyle.FLOATING,
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
        var status = await Permission.locationWhenInUse.request();
        print("Location granted : $status");
      },
    );
  }
  Widget _show() {
    return TextButton(
      child: Text('show location'),
      onPressed: () {
        Get.snackbar(
          "Current Location",
          "Showing current location",
          duration: Duration(seconds: 2),
          snackStyle: SnackStyle.FLOATING,
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
        mapboxMap?.location
            .updateSettings(LocationComponentSettings(enabled: true));

      },
    );
  }
  Widget _hide() {
    return TextButton(
      child: Text('hide location'),
      onPressed: () {
        Get.snackbar(
          "Location",
          "Location has been hide",
          duration: Duration(seconds: 2),
          snackStyle: SnackStyle.FLOATING,
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
        mapboxMap?.location
            .updateSettings(LocationComponentSettings(enabled: false));
      },
    );
  }

  // Include other functions as required...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          MapWidget(
            key: ValueKey("mapWidget"),
            resourceOptions: ResourceOptions(
                accessToken: 'pk.eyJ1Ijoid2FpenNoYWhpZCIsImEiOiJjbHFjNjZkbnMwMDRhMmxrM2UzcmJ3bXJiIn0.wuPPxrc95SCBYYgA_QglVg'
            ),
            styleUri: MapboxStyles.SATELLITE_STREETS,
            mapOptions: MapOptions(
              pixelRatio: 2,
              // size: Size(width: 2,height: 1)
            ),
            onMapCreated: _onMapCreated,
          ),
          Container(
            height: 40,
            width: double.infinity,
            color: Colors.black,
          ),
          MapSlider()
        ],
      ),
    );
  }
}



