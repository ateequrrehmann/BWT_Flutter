import 'package:flutter/material.dart';

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
      body: Column(
        children: [
          const SizedBox(
            height: 5.0,
          ),
          Container(
            width: 400.0,
            height: 120.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              image: const DecorationImage(
                image: AssetImage("lib/assets/screen2TopImage1.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(

              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Trending Services",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        const SizedBox(
                          width: 120.0,
                        ),
                        TextButton(
                            onPressed: () {},
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
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
                Row(
                  children: [
                    Card(
                      child: Container(
                        width: 300.0,
                        height: 110.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: const DecorationImage(
                            image: AssetImage("lib/assets/acrepair.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: Container(
                        width: 55.0,
                        height: 110.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: const DecorationImage(
                            image: AssetImage("lib/assets/carservice.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          "All Services",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
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
                            width: 90.0,
                            height: 90.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: const DecorationImage(
                                image: AssetImage("lib/assets/ac.png"),
                              ),
                            ),

                          ),
                        ),
                        Card(
                          color: Colors.white70,
                          child: Container(
                            width: 90.0,
                            height: 90.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: const DecorationImage(
                                image: AssetImage("lib/assets/carpenter.png"),
                              ),
                            ),

                          ),
                        ),
                        Card(
                          color: Colors.white70,
                          child: Container(
                            width: 90.0,
                            height: 90.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: const DecorationImage(
                                image: AssetImage("lib/assets/electrician.png"),
                              ),
                            ),

                          ),
                        ),
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(28.0, 5.0, 0.0, 5.0),
                          child: Text(
                            "AC Services",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(53.0, 5.0, 0.0, 5.0),
                          child: Text(
                            "Carpenter",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(53.0, 5.0, 0.0, 5.0),

                          child: Text(
                            "Electrician",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Card(
                          color: Colors.white70,
                          child: Container(
                            width: 90.0,
                            height: 90.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: const DecorationImage(
                                image: AssetImage("lib/assets/geyser.png"),
                              ),
                            ),

                          ),
                        ),
                        Card(
                          color: Colors.white70,
                          child: Container(
                            width: 90.0,
                            height: 90.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: const DecorationImage(
                                image: AssetImage("lib/assets/handyman.png"),
                              ),
                            ),

                          ),
                        ),
                        Card(
                          color: Colors.white70,
                          child: Container(
                            width: 90.0,
                            height: 90.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: const DecorationImage(
                                image: AssetImage("lib/assets/homeappliances.png"),
                              ),
                            ),

                          ),
                        ),
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(45.0, 5.0, 0.0, 5.0),
                          child: Text(
                            "Geyser",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(60.0, 5.0, 0.0, 5.0),
                          child: Text(
                            "Handyman",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(65.0, 5.0, 0.0, 0.0),
                            child: Text(
                              "Home",
                            ),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(265.0, 0.0, 0.0, 0.0),
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
