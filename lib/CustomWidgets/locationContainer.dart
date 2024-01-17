import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocationDetailsWidget extends StatefulWidget {
  final String location;
  final String latitude;
  final String longitude;

  LocationDetailsWidget({
    required this.location,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<LocationDetailsWidget> createState() => _LocationDetailsWidgetState();
}

class _LocationDetailsWidgetState extends State<LocationDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(15.0),
      ),
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Location: ${widget.location}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Latitude: ${widget.latitude}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
          SizedBox(height: 8.0),

          Text(
            'Longitude: ${widget.longitude}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
          SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
