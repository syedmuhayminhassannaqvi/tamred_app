import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding; // Use an alias to resolve naming conflicts
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tamred_app/registration_Screen/createNewAccount/let_explore.dart';
import '../../CustomWidgets/locationContainer.dart';
import 'googlemaps.dart';
import 'otpVerification.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';



class Choose_Nickname extends StatefulWidget {
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;
  final String gender;
  final String dateOfBirth;
   Choose_Nickname({Key? key, required this.firstName, required this.lastName, required this.email, required this.password, required this.confirmPassword, required this.username, required this.gender, required this.dateOfBirth}) : super(key: key);

  @override
  State<Choose_Nickname> createState() => _Choose_NicknameState();
}

class _Choose_NicknameState extends State<Choose_Nickname> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nickNameController = TextEditingController();
  late GoogleMapController mapController;
  TextEditingController _addressController = TextEditingController();
  LatLng? selectedLocation;
  bool isDisabled = true;

  bool _isLocationFetched = false;
  bool _isVerifying = false;
  bool termsAndConditions = false;
  bool privacyPolicy = false;
  bool marketing = false;

  String? location = '';
  double? latitude;
  double? longitude;
  String? city = '';
  String? state = '';
  String? country = '';

  String formatDate(String inputDate) {
    // Parse the input date in the current format
    List<String> dateParts = inputDate.split('-');
    DateTime parsedDate = DateTime(int.parse(dateParts[2]), int.parse(dateParts[0]), int.parse(dateParts[1]));

    // Format the parsed date into the desired format "yyyy-MM-dd"
    String formattedDate = "${parsedDate.year.toString().padLeft(4, '0')}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.day.toString().padLeft(2, '0')}";

    return formattedDate;
  }


  Future<void> getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Location services are not enabled!");
      return;
    }

    // Check location permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Location permissions are denied!");
        return;
      }
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
    );

    // Extract coordinates
    latitude = position.latitude;
    longitude = position.longitude;

    // Reverse geocode to get city, state, and country
    List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(position.latitude, position.longitude);
    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0];
      city = placemark.locality;
      state = placemark.administrativeArea;
      country = placemark.country;
    }
    setState(() {
      // Set state here to trigger a rebuild with the updated data
      location = "${city ?? ''}, ${state ?? ''}, ${country ?? ''}";
      latitude = position.latitude;
      longitude = position.longitude;
    });
    setState(() {
      _isLocationFetched = true; // Set the location fetched flag to true
    });

    setState(() {
      defaultLocation = LatLng(latitude ?? 0, longitude ?? 0);
    });

    print("Location: $location");
    print("Latitude: $latitude");
    print("Longitude: $longitude");
    print("City: $city");
    print("State: $state");
    print("Country: $country");
  }


  TextEditingController _locationController = TextEditingController();

  Future<void> _selectLocationFromMap() async {
    LocationData? selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => GoogleMapScreen(initialLatitude: latitude, initialLongitude: longitude),
      ),
    );

    if (selectedLocation != null) {
      setState(() {
        // Update UI with the selected location details
        location = selectedLocation.country; // Example: Assigning country to 'location'
        latitude = selectedLocation.latitude;
        longitude = selectedLocation.longitude;
        city = selectedLocation.city;
        state = selectedLocation.state;

        // Update other fields or perform actions with received location data
      });
    } else {
      // Handle if no location data is received
    }

    _locationController.text = '${selectedLocation?.country ?? ''}, '
        '${selectedLocation?.city ?? ''}, '
        '${selectedLocation?.state ?? ''} ';

  }




  Future<void> _updateLocationInfo(LatLng location) async {
    List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(location.latitude, location.longitude);
    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0];
      setState(() {
        city = placemark.locality;
        country = placemark.country;
        _addressController.text = '${city ?? ''}, ${country ?? ''}';
      });
    }
  }



  LatLng? defaultLocation; // Store the default location

  @override
  void initState() {
    super.initState();
    getLocation();
    disableFieldForSomeTime();
  }

  Future<void> disableFieldForSomeTime() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      isDisabled = false; // After 5 seconds, enable the field
    });
  }


  String? _validateNickName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a nickname';
    }
    return null;
  }

  Future<String?> signUpUser(BuildContext context,String email,) async {

    String baseUrl = "https://morally-smiling-viper.ngrok-free.app/api";
    String signUpUrl = "$baseUrl/signup";

    String formattedDateOfBirth = formatDate(widget.dateOfBirth);


    Map<String, dynamic> userData = {
      "username": widget.username,
      "first_name": widget.firstName,
      "last_name": widget.lastName,
      "email": widget.email,
      "date_of_birth": formattedDateOfBirth,
      "gender": widget.gender,
      "password": widget.password,
      "password_confirmation": widget.confirmPassword,
      "nickname": _nickNameController.text,
      "location": location, // Handle null values with null-aware operator
      "latitude": latitude.toString(),
      "longitude": longitude.toString(),
      "city": city,
      "state": state,
      "country": country,
      "terms_and_conditions": termsAndConditions.toString(),
      "privacy_policy": privacyPolicy.toString(),
      "marketing": marketing.toString(),
    };

    print('userData $userData');

    Map<String, String> headers = {
      "Accept": "application/json",
    };

    try {
      final response = await http.post(
        Uri.parse(signUpUrl),
        headers: headers,
        body: userData,
      );

      if (response.statusCode == 200) {
        print("User signed up successfully");
        Map<String, dynamic> responseBody = json.decode(response.body);
        String token = responseBody['token'];
        String email = widget.email;
        String username = widget.username;

        if (token != null) {
          await requestEmailVerification(baseUrl, token, email,); // Call verifyEmail here with obtained token and entered OTP
          return token;
        }
      } else {
        print("Error message: ${response.body}");
        Get.snackbar(
          "Error",
          " sign up Email is invalid to share otp",
          duration: Duration(seconds: 10),
          snackStyle: SnackStyle.FLOATING,
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );

      }
    } catch (e) {
      print('Error during signup: $e');
      Get.snackbar(
        "Server Offline",
        "Failed to connect to the server",
        duration: Duration(seconds: 10),
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
      Get.to(Lets_Explore());
    }
    return null;
  }

  String baseUrl = 'https://morally-smiling-viper.ngrok-free.app/api';
  String? token ;
  Future<void> requestEmailVerification(String baseUrl, String token, String email) async {
    setState(() {
      _isVerifying = true;
    });

    final String requestUrl = '$baseUrl/email/verification/request';
    final Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final Map<String, String> body = {
      'email': email,
    };

    try {
      final response = await http.post(
        Uri.parse(requestUrl),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        print('Email verification request sent successfully.');
        Get.to(() => OTP_Verification(
          email: widget.email,
          token: token,
        ));
        Get.snackbar(
          "Email",
          "OTP is Send To your email",
          duration: Duration(seconds: 10),
          snackStyle: SnackStyle.FLOATING,
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
      } else {
        setState(() {
          _isVerifying = false;
        });
        Get.snackbar(
          "Error",
          "Email is not Valid for otp.",
          duration: Duration(seconds: 10),
          snackStyle: SnackStyle.FLOATING,
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
        print('Failed to send email verification request. Error: ${response.body}');
      }
    } catch (e) {
      setState(() {
        _isVerifying = false;
      });
      print('Failed to connect to the server. Error: $e');
      Get.snackbar(
        "Server Offline",
        "Failed to connect to the server.",
        duration: Duration(seconds: 10),
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Color(0xff222222),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Icon(Icons.arrow_back,color: Colors.white,size: 35,),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Row(
                children: [
                  Text("Create Your Account",style: TextStyle(
                      fontFamily: 'Urbanist',
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width*0.05
                  ),),
                ],
              ),
              Row(
                children: [
                  Text("Choose your nickname",style: TextStyle(
                      fontFamily: 'Urbanist',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width*0.08
                  ),),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _nickNameController,
                  validator: _validateNickName,
                  style: TextStyle(
                      color: Colors.white), // Change the color of typed text here
                  decoration: InputDecoration(
                    labelText: 'Nick Name',
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Color(0xff858585),
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Color(0xffFCD240),
                        width: 1.0,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.black87,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.017,
                      horizontal: 30,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              GestureDetector(
                onTap: isDisabled ? null : _selectLocationFromMap,                child: AbsorbPointer(
                  // AbsorbPointer to disable editing the address field
                  child: TextFormField(
                    controller: _locationController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Select Your Location',
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.location_pin,color: Colors.red,),
                    ),
                  ),

                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),

              CheckboxListTile(
                activeColor: Colors.blue,
                title: Text('Terms and Conditions',
                  style: TextStyle(
                  color: Colors.blue
                ),),
                value: termsAndConditions,
                onChanged: (newValue) {
                  setState(() {
                    termsAndConditions = newValue ?? false;
                  });
                },
              ),
              // Checkbox for Privacy Policy
              CheckboxListTile(
                activeColor: Colors.blue,
                title: Text('Privacy Policy',
                  style: TextStyle(
                    color: Colors.blue
                ),
              ),
                value: privacyPolicy,
                onChanged: (newValue) {
                  setState(() {
                    privacyPolicy = newValue ?? false;
                  });
                },
              ),
              // Checkbox for Marketing
              CheckboxListTile(
                activeColor: Colors.blue,
                title: Row(
                  children: [
                    Text('Marketing',
                      style: TextStyle(
                          color: Colors.blue
                      ),
                    ),
                    SizedBox(width: 5,),
                    Text('(optional)',
                      style: TextStyle(
                        fontSize: 10,
                          color: Colors.white
                      ),
                    ),
                  ],
                ),
                value: marketing,
                onChanged: (newValue) {
                  setState(() {
                    marketing = newValue ?? false;
                  });
                },
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
              LinearPercentIndicator(
                lineHeight: 4,
                backgroundColor: Colors.grey.withOpacity(0.7),
                percent: 0.7,
                progressColor: Colors.white,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              _isVerifying // Check if verification is in progress
                  ? CircularProgressIndicator(
                color: Color(0xffFCD240),
              ) // Show circular progress indicator
                  : SizedBox(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              TextButton(
                onPressed: (termsAndConditions && privacyPolicy && _isLocationFetched)
                    ? () async {
                  if (_formKey.currentState!.validate()) {
                    if (location != null && latitude != null && longitude != null) {
                      String? obtainedToken = await signUpUser(context, widget.email);
                      if (obtainedToken != null) {
                        await requestEmailVerification(baseUrl, obtainedToken, widget.email);
                      }
                    } else {
                      // Handle case where location data is not available yet
                      // Show a message or perform actions accordingly
                      print('Location data is not available yet');
                    }
                  }
                }
                : null, // Set onPressed to null if termsAndConditions or privacyPolicy is false
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xffFCD240),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "Next",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                      ),
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
