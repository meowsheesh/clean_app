import 'package:cleanapp/storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:cleanapp/constants.dart';

class InfoPage extends StatelessWidget {
  InfoPage(
      {Key? key,
      this.comment,
      this.location,
      this.sost,
      this.numCon,
      this.isFull,
      this.editInfoBy})
      : super(key: key);

  static String id = 'info_page';

  late String? isFull;

  final String? editInfoBy;
  final String? comment;
  final String? location;
  late final bool? sost;
  final int? numCon;
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('container');

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Color(0xFF32B67A),
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 15,
                            ),
                            child: Text('Номер контейнера: $numCon',
                                style: txtContStyle),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              '$location',
                              style: txtContStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                            ),
                            child: Text(
                              '$comment',
                              style: txtInfoStyle,
                            ),
                          ),
                        ],
                      ),
                      FutureBuilder(
                        future: storage.downloadURL('$numCon.jpg'),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.hasData) {
                            return Container(
                              width: 400,
                              height: 400,
                              child: Image.network(
                                snapshot.data!,
                                fit: BoxFit.cover,
                              ),
                            );
                          }
                          if (snapshot.connectionState ==
                                  ConnectionState.waiting ||
                              !snapshot.hasData) {
                            return CircularProgressIndicator();
                          }
                          return Container();
                        },
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Center(
                            child: ElevatedButton(
                              onPressed: () async {
                                final results =
                                    await FilePicker.platform.pickFiles(
                                  allowMultiple: false,
                                  type: FileType.custom,
                                  allowedExtensions: ['png', 'jpg'],
                                );
                                if (results == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Файл не был выбран.')));
                                  return null;
                                }
                                final path = results.files.single.path!;
                                final fileName = '${numCon}.jpg';
                                print(path);
                                print(fileName);
                                storage
                                    .uploadFile(path, fileName)
                                    .then((value) => print('done'));
                                await _collectionReference
                                    .doc('$numCon')
                                    .update({'sost': false});
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Загрузить фото',
                                style: TextStyle(color: Colors.black),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.greenAccent,
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
          ),
        ],
      ),
    );
  }
}
