import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart' as latlng2;
import 'package:myapp/providers/future_provider/user_location_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main_screens/home_screen.dart';

class UserLocation extends ConsumerStatefulWidget {
  const UserLocation({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserLocationState();
}

class _UserLocationState extends ConsumerState<UserLocation> {
  latlng2.LatLng? currentPosition;
  bool showButton = false;

  @override
  void initState() {
    super.initState();
    fetchLocation();
    Timer(const Duration(seconds: 2), () {
      setState(() {
        showButton = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: const Text('Location'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              if (currentPosition != null) {
                await saveLocationToFirestore();
                ref.invalidate(userLocationProvider);
              }
            },
            icon: const Icon(Icons.location_on_outlined, color: Colors.black),
          ),
        ],
      ),
      body: Consumer(builder: (context, ref, child) {
        final userLocation = ref.watch(userLocationProvider);
        return userLocation.when(data: (position) {
          currentPosition = position; // Store the current position
          return Column(
            children: [
              Expanded(
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: position,
                    initialZoom: 15,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.myapp',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: position,
                          width: 60,
                          height: 60,
                          alignment: Alignment.centerLeft,
                          child: const Icon(
                            Icons.location_pin,
                            size: 60,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (showButton)
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => const Home()));
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)))),
                    child: const Text(
                      'Set as Address',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
            ],
          );
        }, error: (error, track) {
          return Center(child: Text('Error: $error'));
        }, loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
      }),
    );
  }

  Future<void> fetchLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        setState(() {
          currentPosition = latlng2.LatLng(position.latitude, position.longitude);
        });

        // Automatically save location to Firestore
        await saveLocationToFirestore();
      }
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  Future<void> saveLocationToFirestore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final phone = prefs.getString('user_phone');
    if (currentPosition != null && phone != null) {
      await FirebaseFirestore.instance.collection('users').doc(phone).update({
        'latlong': GeoPoint(currentPosition!.latitude, currentPosition!.longitude),
      });
    }
  }
}
