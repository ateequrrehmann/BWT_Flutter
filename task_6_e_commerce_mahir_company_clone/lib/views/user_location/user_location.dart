import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:myapp/providers/future_provider/user_location_provider.dart';

import '../screens/main_screens/home_screen.dart';

class UserLocation extends ConsumerStatefulWidget {
  const UserLocation({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserLocationState();
}

class _UserLocationState extends ConsumerState<UserLocation> {
  LatLng? currentPosition;

  @override
  void initState() {
    super.initState();
    fetchLocation();
    Timer(const Duration(seconds: 5), () {
      Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: ElevatedButton(
          onPressed: () {
            //later we have to add latitude and longitude in firebase
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Home()));
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
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black12,
          title: const Text(
            'Location',
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  ref.invalidate(userLocationProvider);
                },
                icon:
                    const Icon(Icons.location_on_outlined, color: Colors.black))
          ],
        ),
        body: Consumer(builder: (context, ref, child) {
          final userLocation = ref.watch(userLocationProvider);
          return userLocation.when(data: (currentPosition) {
            return FlutterMap(
                options: MapOptions(
                  initialCenter: currentPosition,
                  // initialCenter: LatLng(33.6995, 73.0363),
                  initialZoom: 15,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName:
                        'com.example.task_6_e_commerce_mahir_company_clone',
                  ),
                  MarkerLayer(markers: [
                    Marker(
                        point: currentPosition,
                        width: 60,
                        height: 60,
                        alignment: Alignment.centerLeft,
                        child: const Icon(
                          Icons.location_pin,
                          size: 60,
                          color: Colors.red,
                        )),
                  ]),
                ]);
          }, error: (error, track) {
            return Center(child: Text('checking+$error'));
          }, loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
        }));
  }

  Future<void> fetchLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }
}
