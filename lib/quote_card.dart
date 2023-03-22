// import classes we use in different packages

import 'package:flutter/material.dart';
import 'quote.dart';

class QuoteCard extends StatelessWidget {
  final Quote quote;
  // on icon press on this card will run the delete function which can set state and update the stateful widget
  // each quote has a delete function to delete itself
  final Function() delete;
  QuoteCard({required this.quote, required this.delete});

  // accept quote in when we instantiate an object

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(10.0, 16.0, 16.0, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              quote.text,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(
              height: 6.0,
            ),
            Text(
              quote.author,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextButton.icon(
              onPressed: delete,
              icon: Icon(
                Icons.delete,
              ),
              label: Text('delete quote'),
            ),
          ],
        ),
      ),
    );
  }
}
