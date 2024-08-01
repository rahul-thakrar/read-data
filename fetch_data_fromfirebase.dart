import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FetchDataFromfirebase extends StatefulWidget {
  const FetchDataFromfirebase({super.key});

  @override
  State<FetchDataFromfirebase> createState() => _FetchDataFromfirebaseState();
}

class _FetchDataFromfirebaseState extends State<FetchDataFromfirebase> {
  final CollectionReference fetchData= FirebaseFirestore.instance.collection("Fetch Data");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text("Fetch Data"),
      ),
      body: StreamBuilder(stream: fetchData.snapshots(), builder: (context,AsyncSnapshot<QuerySnapshot> streamSnapshot){
        if(streamSnapshot.hasData){
          return ListView.builder(
            itemCount: streamSnapshot.data!.docs.length,
            itemBuilder: (context,index){
              final DocumentSnapshot documentSnapshot=streamSnapshot.data!.docs[index];
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10,right: 12,left: 12,bottom:5),
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(  
                          documentSnapshot['name'],
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),
                        ),
                        subtitle: Text(
                          documentSnapshot['definition'],
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}