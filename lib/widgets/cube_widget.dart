import 'package:flutter/material.dart';
import '../screens/info_page.dart';

class CubeWidget extends StatelessWidget {
  const CubeWidget(
      {Key? key,
      required this.isFull,
      required this.numCon,
      required this.comment,
      required this.location,
      this.onPressed})
      : super(key: key);

  final Function? onPressed;
  final String location;
  final String comment;
  final int numCon;
  final bool isFull;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InfoPage(
              comment: comment,
              sost: isFull,
              location: location,
              numCon: numCon,
            ),
          ),
        );
      },
      child: Container(
        child: Column(
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: isFull ? Colors.redAccent : Color(0xFF32B67A),
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  numCon.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
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
