import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/providers/future_provider/user_data_provider.dart';
import 'package:myapp/views/screens/main_screens/bottom_nav_bar/cleaning_services_bottom_navigation_bar.dart';
import 'package:myapp/views/screens/main_screens/cleaning_services/cleaning_services.dart';
import 'package:myapp/views/screens/main_screens/home_services/home_services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../profile_screen/profile_screen.dart';
import '../registeration_login/register_screen.dart';
import '../user_location/user_location.dart';
import 'bottom_nav_bar/home_services_bottom_navigation_bar.dart';
import 'history/order_history.dart';
import 'order_management/order_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int myIndex = 0;
  String selectedTile = 'HOME';
  var adminPhone;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPhone();
    print('my admin page $adminPhone');
  }

  Future<void> fetchPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      adminPhone = prefs.getString('admin_phone');
    });
    print('my admin page $adminPhone');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mahir Company",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        actions: [
          adminPhone!=''?
              IconButton(onPressed: () async{
                print(adminPhone);
                SharedPreferences prefs=await SharedPreferences.getInstance();
                prefs.setString('verification_id', '');
                prefs.setString('adminPhone', '');
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
              }, icon: Icon(Icons.logout)):Container(),
        ]
      ),
      drawer: adminPhone==''
      ?Consumer(builder: (context, ref, child){
        final data = ref.watch(userFirebaseProvider);
        print(data);
        return data.when(
            data: (user){
              return Drawer(
                elevation: 20.0,
                backgroundColor: const Color(0xFFE9EBEB),
                child: ListView(
                  children: [
                    DrawerHeader(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                      ),
                      child: UserAccountsDrawerHeader(
                        decoration: const BoxDecoration(
                          // color: Color(0xFFEC407A),
                        ),
                        accountName: Text(
                          user.name ,
                          style: const TextStyle(fontSize: 16),
                        ),
                        accountEmail: Text(
                          user.number,
                        ),
                        currentAccountPictureSize: const Size.square(40),
                        currentAccountPicture: CircleAvatar(
                          backgroundImage: user.imageUrl != null && user.imageUrl!.isNotEmpty
                              ? NetworkImage('${user.imageUrl}')
                              : null,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: selectedTile=="HOME"?
                        Colors.grey:Colors.transparent,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: ListTile(
                          title: const Text("H O M E"),
                          leading: const Icon(Icons.home),
                          onTap: () {
                            setState(() {
                              selectedTile="HOME";
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Home(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: selectedTile=="PROFILE"?
                        Colors.grey:Colors.transparent,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: ListTile(
                          title: const Text("P R O F I L E"),
                          leading: const Icon(Icons.person),
                          onTap: () {
                            setState(() {
                              selectedTile="PROFILE";
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfilePage(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: selectedTile=="ORDERS"?
                        Colors.grey:Colors.transparent,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: ListTile(
                          title: const Text("O R D E R S"),
                          leading: const Icon(Icons.list),
                          onTap: () {
                            setState(() {
                              selectedTile="ORDERS";
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: selectedTile=="HISTORY"?
                        Colors.grey:Colors.transparent,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: ListTile(
                          title: const Text("O R D E R  H I S T O R Y"),
                          leading: const Icon(Icons.history_outlined),
                          onTap: () {
                            setState(() {
                              selectedTile="HISTORY";
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HistoryScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: selectedTile=="USERLOCATION"?
                        Colors.grey:Colors.transparent,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: ListTile(
                          title: const Text("U S E R  L O C A T I O N"),
                          leading: const Icon(Icons.location_pin),
                          onTap: () {
                            setState(() {
                              selectedTile="USERLOCATION";
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserLocation(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 200),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: ListTile(
                        title: const Text("L O G O U T"),
                        leading: const Icon(Icons.logout),
                        onTap: () async {
                          SharedPreferences prefs=await SharedPreferences.getInstance();
                          prefs.setString('verification_id', '');
                          prefs.setString('user_phone', '');
                          FirebaseAuth.instance.signOut();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const RegisterScreen()));
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
            error: (error, track){
              return Center(
                child: Text(
                  'error + $error'
                )
              );
            },
            loading: (){
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            },
        );
      },):Container(),

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
                  Consumer(builder: (context, ref, child){
                    final data=ref.watch(userFirebaseProvider);
                    return adminPhone==''? data.when(data: (user){
                      return Row(
                        children: [
                          SizedBox(
                            width: 1.sp,
                          ),
                          Text(
                            "Hello, ${user.name}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp,
                            ),
                          ),
                        ],
                      );
                    }, error: (error, track){
                      return Center(
                          child: Text(
                              'error + $error'
                          )
                      );
                    },
                      loading: (){
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      },):Container();
                  }),

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
                      icon: Icon(
                        Icons.attach_money_rounded,
                        size: 20.sp,
                        color: Colors.white,
                      ),
                      label: Text(
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
                      icon: Icon(
                        Icons.account_balance_wallet_rounded,
                        size: 20.sp,
                        color: Colors.white,
                      ),
                      label: Text(
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
                      adminPhone==''? Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeServicesBottomNavBar())):Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeService()));
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
                            padding: EdgeInsets.fromLTRB(1.5.w, 1.h, 0.0, 0.0),
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
                                    child: Text(
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
                                  padding:
                                  EdgeInsets.fromLTRB(0.0, 0.0, 2.w, 0.0),
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
                                      child: Text(
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
                              image: const AssetImage("lib/assets/toolbox.png"),
                              width: 20.w,
                              height: 20.h,
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
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
                          padding: EdgeInsets.only(
                              top: 1.5.h, left: 1.w, right: 1.w),
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
                            padding: EdgeInsets.only(
                                left: 1.w, right: 1.w, top: 1.h),
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
                                        borderRadius:
                                        BorderRadius.circular(10.sp),
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
                              image: const AssetImage("lib/assets/carebox.png"),
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
                      print(adminPhone);
                      adminPhone=='' ? Navigator.push(context, MaterialPageRoute(builder: (context)=>const CleaningServicesBottomNavBar())):Navigator.push(context, MaterialPageRoute(builder: (context)=>CleaningService()));
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
                                padding:
                                EdgeInsets.fromLTRB(2.w, 0.0, 1.w, 2.h),
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
                                    image:
                                    const AssetImage("lib/assets/cleaning.png"),
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
                                    image: const AssetImage("lib/assets/mahir.png"),
                                    width: 13.w,
                                    height: 13.w,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(2.w, 0.0, 1.w, 2.h),
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
                                EdgeInsets.only(left: 12.w, right: 0.0),
                                child: Image(
                                  image:
                                  const AssetImage("lib/assets/maintenance.png"),
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