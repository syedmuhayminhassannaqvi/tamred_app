import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class GoogleMapScreen extends StatefulWidget {
  final double? initialLatitude;
  final double? initialLongitude;

  GoogleMapScreen({Key? key, this.initialLatitude, this.initialLongitude}) : super(key: key);

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  late GoogleMapController mapController;
  TextEditingController _addressController = TextEditingController();
  late LocationData locationData;

  Set<Marker> markers = {};

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  void _onMapTapped(LatLng latLng) async {
    final List<Placemark> placemarks = await placemarkFromCoordinates(
      latLng.latitude,
      latLng.longitude,
    );

    if (placemarks.isNotEmpty) {
      final Placemark place = placemarks.first;
      setState(() {
        markers.clear();
        markers.add(
          Marker(
            markerId: MarkerId('Tapped Location'),
            position: latLng,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          ),
        );
        _addressController.text = '${place.street}, ${place.subThoroughfare}, ${place.locality}, ${place.country}}';
      });

      // Assign the LocationData object to the class-level variable
      locationData = LocationData(
        country: place.country ?? '',
        city: place.locality ?? '',
        latitude: latLng.latitude,
        longitude: latLng.longitude,
        state: place.administrativeArea ?? '',
      );
    }
  }
  void _onTextChanged(String value) async {
    if (value.isNotEmpty) {
      List<Location> locations = await locationFromAddress(value);
      if (locations.isNotEmpty) {
        Location firstResult = locations.first;
        mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(firstResult.latitude, firstResult.longitude),
            zoom: 10.0,
          ),
        ));
      }
    }
  }

  void _onSearchIconClicked() {
    String value = _addressController.text;
    _onTextChanged(value);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Location'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.initialLatitude ?? 0.0, widget.initialLongitude ?? 0.0),
              zoom: 12.0,
            ),
            onMapCreated: (controller) {
              setState(() {
                mapController = controller;
              });
            },
            markers: markers,
            onTap: _onMapTapped,
          ),
          Positioned(
            top: 20.0,
            left: 20.0,
            right: 20.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
               child: TextField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    hintText: 'Type country or city...',
                    contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: _onSearchIconClicked,
                    ), // Icon you want to display
                  ),
                   // onChanged: _onTextChanged,
                )
            ),
          ),
          Positioned(
            bottom: 20.0,
            left: 20.0,
            right: 20.0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 60.0,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back(result: locationData);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(width: 2, color: Colors.blue),
                    ),
                    primary: Colors.white,
                  ),
                  child: Text(
                    'Save Location',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

class LocationData {
  final String country;
  final String city;
  final double latitude;
  final double longitude;
  final String state;

  LocationData({
    required this.country,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.state,
  });
}

