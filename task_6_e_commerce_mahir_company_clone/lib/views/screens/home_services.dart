import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeService extends StatefulWidget {
  const HomeService({super.key});

  @override
  State<HomeService> createState() => _HomeServiceState();
}

class _HomeServiceState extends State<HomeService> {
  int myIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110.0),
        child: AppBar(
          elevation: 50.0,
          title: const Text(
            "Home Services",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.call,
                      ),
                      color: Colors.blue,
                      style: IconButton.styleFrom(
                        iconSize: 30.0,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications,
                      ),
                      color: Colors.blue,
                      style: IconButton.styleFrom(
                        iconSize: 30.0,
                      ),
                    ),
                  ],

                ),

              ],
            ),
          ],
          flexibleSpace: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white30,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        hintText: "Search",
                        prefixIcon: const Icon(
                          Icons.search,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
             SizedBox(
              height: 1.h,
            ),
            Card(
              color: Colors.white70,
              child: Container(
                width: 88.w,
                height: 15.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.sp),
                  image: const DecorationImage(
                    image: AssetImage("lib/assets/screen2TopImage1.jpg"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),

            // Container(
            //   width: 400.0,
            //   height: 120.0,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(20.0),
            //     image: const DecorationImage(
            //       image: AssetImage("lib/assets/screen2TopImage1.jpg"),
            //       fit: BoxFit.fill,
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
              child: Column(

                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                           Text(
                            "Trending Services",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                            ),
                          ),
                          SizedBox(
                            width: 17.w,
                          ),
                          TextButton(
                              onPressed: () {},
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.sp),
                                ),
                              padding: EdgeInsets.symmetric(vertical: 2.w, horizontal: 2.5.h),
                            ),

                              child: const Text(
                                "View All",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Card(
                          child: Container(
                            width: 80.w,
                            height: 18.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: const DecorationImage(
                                image: AssetImage("lib/assets/acrepair.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Card(
                          child: Container(
                            width: 80.w,
                            height: 18.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: const DecorationImage(
                                image: AssetImage("lib/assets/carservice.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "All Services",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Card(
                            color: Colors.white70,
                            child: Container(
                              width: 25.w,
                              height: 25.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.sp),
                                image: const DecorationImage(
                                  image: AssetImage("lib/assets/ac.png"),
                                ),
                              ),

                            ),
                          ),
                          Card(
                            color: Colors.white70,
                            child: Container(
                              width: 25.w,
                              height: 25.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.sp),
                                image: const DecorationImage(
                                  image: AssetImage("lib/assets/carpenter.png"),
                                ),
                              ),

                            ),
                          ),
                          Card(
                            color: Colors.white70,
                            child: Container(
                              width: 25.w,
                              height: 25.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.sp),
                                image: const DecorationImage(
                                  image: AssetImage("lib/assets/electrician.png"),
                                ),
                              ),

                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(5.w, 0.0, 0.0, 1.h),
                            child: Text(
                              "AC Services",
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10.w, 0.0, 0.0, 1.h),
                            child: Text(
                              "Carpenter",
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(13.w, 0.0, 0.0, 1.h),

                            child: Text(
                              "Electrician",
                            ),
                          ),
                        ],
                      ),
                       SizedBox(
                        height: 1.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Card(
                            color: Colors.white70,
                            child: Container(
                              width: 25.w,
                              height: 25.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.sp),
                                image: const DecorationImage(
                                  image: AssetImage("lib/assets/geyser.png"),
                                ),
                              ),

                            ),
                          ),
                          Card(
                            color: Colors.white70,
                            child: Container(
                              width: 25.w,
                              height: 25.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.sp),
                                image: const DecorationImage(
                                  image: AssetImage("lib/assets/handyman.png"),
                                ),
                              ),

                            ),
                          ),
                          Card(
                            color: Colors.white70,
                            child: Container(
                              width: 25.w,
                              height: 25.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.sp),
                                image: const DecorationImage(
                                  image: AssetImage("lib/assets/homeappliances.png"),
                                ),
                              ),

                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(10.w, 0.0, 0.0, 1.h),
                            child: Text(
                              "Geyser",
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(15.w, 0.0, 0.0, 1.h),
                            child: Text(
                              "Handyman",
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(14.w, 0.0, 0.0,0.0),
                              child: Text(
                                "Home",
                              ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(65.w, 0.0, 0.0, 0.0),
                            child: Text(
                              "Appliances",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            myIndex=index;
          });
        },
        currentIndex: myIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list_rounded,
            ),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
