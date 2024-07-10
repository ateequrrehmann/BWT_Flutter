import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/HomeServices.dart';
import 'CleaningServices.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: '/',
  routes: {
    '/':(context)=>const Home(),
    '/HomeServices':(context)=>const HomeService(),
    '/CleaningServices':(context)=>const CleaningService(),
  },
));



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
        title: const Text(
          "Mahir Company",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      "Welcome to Mahir Company",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      "Hello, Farkhanda",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 5.0,
                ),
                SizedBox(
                  width: 193,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.attach_money_rounded,
                      size: 20.0,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "0 Coins",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 12.0),
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                SizedBox(
                  width: 158,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.account_balance_wallet_rounded,
                      size: 20.0,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "100 Wallet",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 12.0),
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
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
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Home Services",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 35.0,
                                child: TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.blue[400],
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      )),
                                  child: const Text(
                                    "RESIDENTIAL",
                                    style: TextStyle(
                                      fontSize: 10.0,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    0.0, 0.0, 10.0, 0.0),
                                child: SizedBox(
                                  height: 35.0,
                                  child: TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.blue[400],
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        )),
                                    child: const Text(
                                      "COMMERCIAL",
                                      style: TextStyle(
                                        fontSize: 10.0,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        const Center(
                          child: Image(
                            image: AssetImage("lib/assets/toolbox.png"),
                            width: 100.0,
                            height: 100.0,
                          ),
                        ),
                        const SizedBox(
                          height: 2.0,
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
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Personal Care and",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
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
                                    fontSize: 15.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 45.0),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 35.0,
                              width: 110.0,
                              child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.pink[200],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: const Text(
                                  "FEMALES ONLY",
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 2.0,
                      ),
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 29.0, right: 29.0),
                          child: Image(
                            image: AssetImage("lib/assets/carebox.png"),
                            width: 100.0,
                            height: 100.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 2.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
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
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Cleaning Service",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  5.0, 0.0, 2.0, 15.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 35.0,
                                    child: TextButton(
                                      onPressed: () {},
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.blue[200],
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      child: const Text(
                                        "RESIDENTIAL",
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  SizedBox(
                                    height: 35.0,
                                    child: TextButton(
                                      onPressed: () {},
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.blue[200],
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      child: const Text(
                                        "COMMERCIAL",
                                        style: TextStyle(
                                          fontSize: 12.0,
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
                        const Column(
                          children: [
                            Center(
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: 45.0, right: 0.0),
                                child: Image(
                                  image: AssetImage("lib/assets/cleaning.png"),
                                  width: 100.0,
                                  height: 100.0,
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
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Card(
                  color: Colors.white70,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  "Maintained by ",
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Image(
                                  image: AssetImage("lib/assets/mahir.png"),
                                  width: 50.0,
                                  height: 50.0,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(2.0, 0.0, 2.0, 15.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 35.0,
                                  child: TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.blue[400],
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    child: const Text(
                                      "RESIDENTIAL",
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                SizedBox(
                                  height: 35.0,
                                  child: TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.blue[400],
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    child: const Text(
                                      "COMMERCIAL",
                                      style: TextStyle(
                                        fontSize: 12.0,
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
                      const Column(
                        children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(left: 28.0, right: 0.0),
                              child: Image(
                                image: AssetImage("lib/assets/maintenance.png"),
                                width: 100.0,
                                height: 100.0,
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
            const SizedBox(
              height: 10.0,
            ),
            Card(
              color: Colors.white70,
              child: Container(
                width: 390.0,
                height: 125.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
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
    );
  }
}
