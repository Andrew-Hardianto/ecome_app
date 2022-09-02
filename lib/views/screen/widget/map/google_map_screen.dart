import 'dart:async';

import 'package:ecome_app/models/map.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  final OfficeLocation initialLocation;

  const MapScreen({
    Key? key,
    this.initialLocation = const OfficeLocation(
      officeLatitude: -6.2793,
      officeLongitude: 107.0054,
      toleranceInMeter: 100,
    ),
  }) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final GoogleMapController _mapCtrl;
  Location _location = Location();
  final Set<Marker> newMarker = new Set();

  getLocation(GoogleMapController _cntlr) async {
    _mapCtrl = _cntlr;
    try {
      await _location.onLocationChanged.listen((LocationData currentLocation) {
        _mapCtrl.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(
                    currentLocation.latitude!, currentLocation.longitude!),
                zoom: 15),
          ),
        );

        setState(() {
          newMarker.add(Marker(
            markerId: MarkerId('m1'),
            position:
                LatLng(currentLocation.latitude!, currentLocation.longitude!),
          ));
        });
      });
    } catch (err) {
      print('PlatformException $err');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _mapCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.officeLatitude,
            widget.initialLocation.officeLongitude,
          ),
          zoom: 16,
        ),
        markers: newMarker,
        onMapCreated: getLocation,
        // myLocationEnabled: true,
      ),
    );
  }
}
