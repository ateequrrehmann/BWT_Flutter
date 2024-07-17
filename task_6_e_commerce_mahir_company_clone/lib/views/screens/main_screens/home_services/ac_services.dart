import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/providers/future_provider/home_services_data_provider.dart';
import 'package:myapp/views/reusable_widgets/reusableCardForServices.dart';

import '../../../shimmer_effect/services_card_skeleton.dart';

class ACServices extends ConsumerStatefulWidget {
  const ACServices({super.key});

  @override
  ConsumerState<ACServices> createState() => _ACServicesState();
}

class _ACServicesState extends ConsumerState<ACServices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('AC SERVICES'),
        ),
        body: Consumer(builder: (context, ref, child) {
          final service = ref.watch(homeServicesProvider('ac_services'));
          return service.when(data: (serviceData) {
            return ListView.builder(
                itemCount: serviceData.length,
                itemBuilder: (context, index) {
              final data = serviceData[index];
              return Column(
                children: [
                  reusableCardForServices(
                      context,
                      data.serviceName,
                      data.per,
                      data.price,
                      'https://firebasestorage.googleapis.com/v0/b/mahircompanyclone.appspot.com/o/default_image%2Favatar.png?alt=media&token=1c65efe5-cb3c-4a6e-9fff-3e0ed9e5b661',
                      data.available),
                ],
              );
            });
          }, error: (error, track) {
            return Center(child: Text('checking+$error'));
          }, loading: () {
            return ListView.separated(
                itemBuilder: (context, index)=>const ServicesCardSkeleton(),
                separatorBuilder: (context, indext)=>const SizedBox(height: 16,),
                itemCount: 5
            );
          });
        }));
  }
}
