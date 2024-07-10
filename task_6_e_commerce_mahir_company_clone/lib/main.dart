import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/HomeServices.dart';
import 'CleaningServices.dart';

void main() {
  runApp(ResponsiveSizer(builder: (context, orientation, screenType) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/HomeServices': (context) => const HomeService(),
        '/CleaningServices': (context) => const CleaningService(),
      },
    );
  }));
}



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int myIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          "Mahir Company",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 1.w,
                      ),
                      Text(
                        "Welcome to Mahir Company",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 1.sp,
                      ),
                      Text(
                        "Hello, Farkhanda",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 1.w,
                  ),
                  SizedBox(
                    width: 43.w,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon:  Icon(
                        Icons.attach_money_rounded,
                        size: 20.sp,
                        color: Colors.white,
                      ),
                      label:  Text(
                        "0 Coins",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.sp,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 1.5.h),
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                      ),
                    ),
                  ),
                   SizedBox(
                    width: 3.w,
                  ),
                  SizedBox(
                    width: 43.w,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon:  Icon(
                        Icons.account_balance_wallet_rounded,
                        size: 20.sp,
                        color: Colors.white,
                      ),
                      label:  Text(
                        "100 Wallet",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.sp,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 1.5.h),
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
               SizedBox(
                height: 2.h,
              ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/HomeServices');
                    },
                    child: Card(
                      color: Colors.white70,
                      //margin: const EdgeInsets.all(20.0),
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Padding(
                            padding: EdgeInsets.only(top: 2.h),
                            child: Text(
                              "Home Services",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(1.5.w, 1.h, 0.0, 0.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 4.h,
                                  child: TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.blue[400],
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.sp),
                                        )),
                                    child:  Text(
                                      "RESIDENTIAL",
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ),
                                ),
                                 SizedBox(
                                  width: 1.w,
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      0.0, 0.0, 2.w, 0.0),
                                  child: SizedBox(
                                    height: 4.h,
                                    child: TextButton(
                                      onPressed: () {},
                                      style: TextButton.styleFrom(
                                          backgroundColor: Colors.blue[400],
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.sp),
                                          )),
                                      child:  Text(
                                        "COMMERCIAL",
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                           Center(
                            child: Image(
                              image: AssetImage("lib/assets/toolbox.png"),
                              width: 20.w,
                              height: 20.h,
                            ),
                          ),
                           SizedBox(
                            height:1.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.white70,
                    //margin: const EdgeInsets.all(20.0),
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Padding(
                          padding: EdgeInsets.only(top: 1.5.h, left: 1.w, right: 1.w),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Personal Care and",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Beauty Services",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding:  EdgeInsets.only(left: 1.w, right: 1.w, top: 1.h),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 4.h,
                                  width: 30.w,
                                  child: TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.pink[200],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.sp),
                                      ),
                                    ),
                                    child: Text(
                                      "FEMALES ONLY",
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                         Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Image(
                              image: AssetImage("lib/assets/carebox.png"),
                              width: 20.w,
                              height: 20.h,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/CleaningServices');
                    },
                    child: Card(
                      color: Colors.white70,
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.sp),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Cleaning Service",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    2.w, 0.0, 1.w, 2.h),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 4.h,
                                      child: TextButton(
                                        onPressed: () {},
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.blue[200],
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.sp),
                                          ),
                                        ),
                                        child: Text(
                                          "RESIDENTIAL",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                      child: TextButton(
                                        onPressed: () {},
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.blue[200],
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.sp),
                                          ),
                                        ),
                                        child: Text(
                                          "COMMERCIAL",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Center(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 7.w, right: 0.0),
                                  child: Image(
                                    image: AssetImage("lib/assets/cleaning.png"),
                                    width: 25.w,
                                    height: 25.w,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Row(
                children: [
                  Card(
                    color: Colors.white70,
                    child: Row(
                      children: [
                        Column(
                          children: [
                             Padding(
                              padding: EdgeInsets.all(8.sp),
                              child: Row(
                                children: [
                                  Text(
                                    "Maintained by ",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Image(
                                    image: AssetImage("lib/assets/mahir.png"),
                                    width: 13.w,
                                    height: 13.w,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(2.w, 0.0, 1.w, 2.h),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 4.h,
                                    child: TextButton(
                                      onPressed: () {},
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.blue[400],
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.sp),
                                        ),
                                      ),
                                      child: Text(
                                        "RESIDENTIAL",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                    child: TextButton(
                                      onPressed: () {},
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.blue[400],
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.sp),
                                        ),
                                      ),
                                      child:  Text(
                                        "COMMERCIAL",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Center(
                              child: Padding(
                                padding: EdgeInsets.only(left: 12.w, right: 0.0),
                                child: Image(
                                  image: AssetImage("lib/assets/maintenance.png"),
                                  width: 20.w,
                                  height: 20.w,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Card(
                color: Colors.white70,
                child: Container(
                  width: 88.w,
                  height: 15.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    image: const DecorationImage(
                      image: AssetImage("lib/assets/offer.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
