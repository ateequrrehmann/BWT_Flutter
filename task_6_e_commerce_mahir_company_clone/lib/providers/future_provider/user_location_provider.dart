

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';


final userLocationProvider=FutureProvider<LatLng>((ref) async{
  Position position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  return LatLng(position.latitude, position.longitude);
});


//
// try{
// LocationPermission permission=await Geolocator.checkPermission();
// if(permission==LocationPermission.denied){
// permission=await Geolocator.requestPermission();
// }
// Position position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
// setState(() {
// currentPosition=LatLng(position.latitude, position.longitude);
// });
// }catch(e){
// print('Error ${e.toString()}');
// }
// }