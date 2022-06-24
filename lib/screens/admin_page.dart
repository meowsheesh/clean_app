import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/cube_widget.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  static String id = 'admin_page';

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    final messageWidget = CubeWidget(
                      isFull: isFull,
                      numCon: numCon,
                      comment: messageComment,
                      location: messageLocation,
                    );
                    messageWidgets.add(messageWidget);
                  }
                  return Expanded(
                      child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(top: 15),
                    crossAxisCount: 4,
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
      appBar: AppBar(
        title: Text('Панель администратора'),
      ),
    );
  }
}
