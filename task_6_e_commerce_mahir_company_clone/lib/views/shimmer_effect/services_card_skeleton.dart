import 'package:flutter/material.dart';
import 'package:myapp/views/shimmer_effect/skeleton.dart';

class ServicesCardSkeleton extends StatelessWidget {
  const ServicesCardSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Skeleton(height: 120, width: 120,),
        const SizedBox(width: 16,),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Skeleton(width: 80,),
            SizedBox(height: 16/2,),
            Skeleton(),
            SizedBox(height: 16/2,),
            Skeleton(),
            SizedBox(height: 16/2,),
            Row(
              children: [
                Expanded(child: Skeleton()),
              ],
            )
          ],
        ))
      ],
    );
  }
}
