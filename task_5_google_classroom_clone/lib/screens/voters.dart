

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/color_utils.dart';
import 'signin_screen.dart';

class Voters extends StatefulWidget {
  const Voters({super.key});

  @override
  State<Voters> createState() => _VotersState();
}

class _VotersState extends State<Voters> {
  List<String> docIDs = [];

  @override
  void initState() {
    super.initState();
    getDocId();
  }

  Future getDocId() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('candidates').get();
    setState(() {
      docIDs = snapshot.docs.map((doc) => doc.id).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome to Vote Casting", style: TextStyle(color: Colors.white)),
        backgroundColor: hexStringToColor("CB2B93"),
        actions: [
          IconButton(
            onPressed: (){
                  FirebaseAuth.instance.signOut().then((value){
                    print("Signed Out");
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignInScreen()));
                  });
                },
              icon: const Icon(
                Icons.logout_outlined,
              ),
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              hexStringToColor("CB2B93"),
              hexStringToColor("9546C4"),
              hexStringToColor("5E61F4")
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              const Text(
                  "Cast your vote",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: docIDs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          _incrementVotes(docIDs[index]);
                        },
                        child: ListTile(
                          title: GetVoterName(documentId: docIDs[index], context: context),
                          subtitle: GetVotes(documentId: docIDs[index], context: context),
                          tileColor: Colors.grey[200],
                        ),
                      )
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _incrementVotes(String documentId) async {
    DocumentReference documentReference = FirebaseFirestore.instance.collection('candidates').doc(documentId);

    // Show the alert dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text('Casting Vote'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Your vote is being cast...'),
              ],
            ),
          ),

        );
      },
    );

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        int newVotes = (data['votes'] as int) + 1; // Incrementing votes
        transaction.update(documentReference, {'votes': newVotes});
      }
    }).then((_) {
      // Close the alert dialog
      Navigator.of(context).pop();

      // Refresh the UI after updating the votes
      setState(() {
        getDocId(); // Re-fetching docIDs
      });
    });
  }


}


class GetVoterName extends StatelessWidget {
  final String documentId;
  final BuildContext context;

  const GetVoterName({super.key, required this.documentId, required this.context});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Text('Voters: ${data['name']}', style: TextStyle(fontSize: 20.0),);
        }
        return const Text('Loading...');
      }),
      future: FirebaseFirestore.instance.collection('candidates').doc(documentId).get(),
    );
  }
}

class GetVotes extends StatelessWidget {
  final String documentId;
  final BuildContext context;

  const GetVotes({super.key, required this.documentId, required this.context});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Text('Votes: ${data['votes']}', style: TextStyle(fontSize: 17),);
        }
        return const Text('Loading...');
      }),
      future: FirebaseFirestore.instance.collection('candidates').doc(documentId).get(),
    );
  }
}
