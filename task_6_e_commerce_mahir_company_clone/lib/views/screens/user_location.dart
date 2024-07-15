import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:myapp/providers/future_provider/user_location_provider.dart';

class UserLocation extends StatefulWidget {
  const UserLocation({super.key});

  @override
  State<UserLocation> createState() => _UserLocationState();
}

class _UserLocationState extends State<UserLocation> {
  LatLng? currentPosition;

  @override
  void initState() {
    super.initState();
    fetchLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child){
      final currentPosition=ref.watch(userLocationProvider as ProviderListenable<LatLng>);
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black12,
            title: const Text(
              'Location',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            actions: [
              IconButton(onPressed: (){ref.invalidate(userLocationProvider);}, icon: const Icon(Icons.refresh))
            ],
          ),
          body: Stack(
            children: [
              FlutterMap(
                  options: MapOptions(
                    initialCenter: currentPosition,
                    // initialCenter: LatLng(33.6995, 73.0363),
                    initialZoom: 3.2,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.task_6_e_commerce_mahir_company_clone',
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
                  ])
            ],

          )
      );
    });

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
