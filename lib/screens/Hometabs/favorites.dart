import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  List<Color> colorsList = [
    Colors.red,
    Colors.tealAccent,
    Colors.deepOrange,
    Colors.blueAccent,
    Colors.purpleAccent,
    Colors.yellowAccent,
  ];

  Color _colorsList() {
    return colorsList[random.nextInt(colorsList.length)];
  }

  Random random = Random();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                _authorRow(),
                SizedBox(
                  height: 16,
                ),
                _nwesItemRow(),
              ],
            ),
          ),
        );
      },
      itemCount: 20,
    );
  }

  Widget _authorRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage(
                    'assets/images/ph.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle,
              ),
              width: 50,
              height: 50,
              margin: EdgeInsets.all(16),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Micheal Adams',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      '15 min .',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'Life Style .',
                      style: TextStyle(color: _colorsList()),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
        IconButton(
          icon: Icon(Icons.bookmark_border),
          onPressed: () {},
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget _nwesItemRow() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage(
                'assets/images/ph.jpg',
              ),
              fit: BoxFit.cover,
            ),
            
          ),
          width: 125,
          height: 125,
          margin: EdgeInsets.only(right: 16),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                'Tech Tent : Old Phones And Safe Social',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              Text(
                'we also talk about the future of work as the robots advanced, and defiernt technicals used in',
                style: TextStyle(color: Colors.grey, fontSize: 17, height: 1.3),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
