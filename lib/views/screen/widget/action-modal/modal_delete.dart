import 'package:flutter/material.dart';

class ModalDelete extends StatelessWidget {
  final VoidCallback deleteAction;
  const ModalDelete({Key? key, required this.deleteAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        height: MediaQuery.of(context).size.height / 4,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Are you sure to delete this Shift?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            RichText(
              text: new TextSpan(
                style: new TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  new TextSpan(text: 'This action'),
                  new TextSpan(
                      text: "can't be undone",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      )),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 80,
                  child: ElevatedButton(
                    child: Text('Cancel'),
                    style: ElevatedButton.styleFrom(primary: Colors.grey),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: ElevatedButton(
                    child: Text('Delete'),
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: deleteAction,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
