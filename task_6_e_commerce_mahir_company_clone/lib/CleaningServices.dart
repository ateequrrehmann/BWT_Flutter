import 'package:flutter/material.dart';



class CleaningService extends StatefulWidget {
  const CleaningService({super.key});

  @override
  State<CleaningService> createState() => _CleaningServiceState();
}

class _CleaningServiceState extends State<CleaningService> {
  int myIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110.0),
        child: AppBar(
          elevation: 50.0,
          title: const Text(
            "Cleaning Services",
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: [
            const SizedBox(
              height: 5.0,
            ),
            Column(

              children: [
                const SizedBox(
                  height: 7.0,
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
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: const DecorationImage(
                                image: AssetImage("lib/assets/sofa.png"),
                              ),
                            ),

                          ),
                        ),
                        Card(
                          color: Colors.white70,
                          child: Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: const DecorationImage(
                                image: AssetImage("lib/assets/tank.png"),
                              ),
                            ),

                          ),
                        ),
                        Card(
                          color: Colors.white70,
                          child: Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: const DecorationImage(
                                image: AssetImage("lib/assets/mattress.png"),
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
                          padding: EdgeInsets.fromLTRB(23.0, 5.0, 0.0, 0.0),
                          child: Text(
                            "Sofa Cleaning",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(30.0, 5.0, 0.0, 0.0),
                          child: Text(
                            "Plastic Water",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(48.0, 5.0, 0.0, 0.0),

                          child: Text(
                            "Mattress",
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(140.0, 0.0, 0.0, 0.0),

                          child: Text(
                            "Tank Cleaning",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(45.0, 0.0, 0.0, 0.0),

                          child: Text(
                            "Cleaning",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Card(
                          color: Colors.white70,
                          child: Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: const DecorationImage(
                                image: AssetImage("lib/assets/house.png"),
                              ),
                            ),

                          ),
                        ),
                        Card(
                          color: Colors.white70,
                          child: Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: const DecorationImage(
                                image: AssetImage("lib/assets/curtain.png"),
                              ),
                            ),

                          ),
                        ),
                        Card(
                          color: Colors.white70,
                          child: Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: const DecorationImage(
                                image: AssetImage("lib/assets/chair.png"),
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
                          padding: EdgeInsets.fromLTRB(28.0, 5.0, 0.0, 0.0),
                          child: Text(
                            "House Deep",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(58.0, 5.0, 0.0, 0.0),
                          child: Text(
                            "Curtain",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(48.0, 5.0, 0.0, 0.0),
                          child: Text(
                            "Chair Cleaning",
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(40.0, 0.0, 0.0, 0.0),
                          child: Text(
                            "Cleaning",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(65.0, 0.0, 0.0, 0.0),
                          child: Text(
                            "Cleaning",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Card(
                          color: Colors.white70,
                          child: Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: const DecorationImage(
                                image: AssetImage("lib/assets/cementwater.png"),
                              ),
                            ),

                          ),
                        ),
                        Card(
                          color: Colors.white70,
                          child: Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: const DecorationImage(
                                image: AssetImage("lib/assets/carpet.png"),
                              ),
                            ),

                          ),
                        ),
                        Card(
                          color: Colors.white70,
                          child: Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: const DecorationImage(
                                image: AssetImage("lib/assets/commercialdeep.png"),
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
                          padding: EdgeInsets.fromLTRB(20.0, 5.0, 0.0, 0.0),
                          child: Text(
                            "Cement Water",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(25.0, 5.0, 0.0, 5.0),
                          child: Text(
                            "Carpet Cleaning",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(28.0, 5.0, 0.0, 0.0),
                          child: Text(
                            "Commercial",
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(22.0, 0.0, 0.0, 0.0),
                          child: Text(
                            "Tank Cleaning",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(145.0, 0.0, 0.0, 0.0),
                          child: Text(
                            "Deep Cleaning",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Trending Services",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
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
              ],
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

