import 'package:crimeapp/models/crime_location.dart';
import 'package:crimeapp/services/location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

final Map<String, Marker> _markers = {};

class _MyHomePageState extends State<MyHomePage> {
  Location location = Location();
  CrimeLoc crimeLoc = CrimeLoc();

  var lat;
  var long;
  Future<void> getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    lat = position.latitude;
    long = position.longitude;
    print('hello');
    print(lat);
    print(long);
    // print()
    setState(() {
      _markers.clear();
      final marker = Marker(
        // icon: BitmapDescriptor.hueAzure,
        markerId: MarkerId("curr_loc"),
        position: LatLng(lat, long),
        infoWindow: InfoWindow(title: '${crimeLoc.reportNumber}'),
      );
      _markers["Current Location"] = marker;
    });
  }

  GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getLocation();
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(6.7106326, -1.6365796),
            zoom: 10.0,
          ),
          markers: _markers.values.toSet(),
        ),
      ),
    );
  }
}
