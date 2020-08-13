import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'home_page.dart';

class ShowData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(
        title: Text('Employee Data'),
      ),

      //
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => HomePage(),
            ),
          );
        },
      ),

      // getdata

      body: StreamBuilder(
        stream: Firestore.instance
            .collection('employees')
            .orderBy('name')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                isThreeLine: true,
                leading: CircleAvatar(
                  child: Text(snapshot.data.documents[index]['name'][0]),
                ),
                title: Text(snapshot.data.documents[index]['name']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(snapshot.data.documents[index]['post']),
                    Text('\u20b9 ${snapshot.data.documents[index]['salary']}'),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    Firestore.instance
                        .collection('employees')
                        .document(snapshot.data.documents[index].documentID)
                        .delete();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
