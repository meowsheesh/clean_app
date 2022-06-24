import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/trash_widget.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);
  static String id = 'todo_page';

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('container');
  late User loggedInUser;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late String comment;
  late String location;
  late bool sost;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void messageStream() async {
    await for (var snapshot in _firestore.collection('container').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Список заполненных'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('container').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final messages = snapshot.data?.docs;
                  List<Widget> messageWidgets = [];
                  for (var message in messages!) {
                    final messageLocation = message['location'];
                    final messageComment = message['comment'];
                    bool isFull = message['sost'];
                    final numCon = message['numCon'];

                    if (isFull == true) {
                      final messageWidget = TrashWidget(
                        isFull: isFull,
                        numCon: numCon,
                        comment: messageComment,
                        location: messageLocation,
                      );
                      messageWidgets.add(messageWidget);
                    }
                  }
                  return Expanded(
                      child: ListView(
                    padding: EdgeInsets.all(5),
                    children: messageWidgets,
                  ));
                } else {
                  return Text('No dATA');
                }
                //,style: TextStyle(color: Colors.black),
              },
            )
          ],
        ),
      ),
    );
  }
}
