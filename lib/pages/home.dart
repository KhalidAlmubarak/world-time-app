import 'package:flutter/material.dart';
import 'package:world_time/pages/services/world_time.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    print(data);

    String bgTmage = data['isDayTime']
        ? 'https://images.photowall.com/products/44323/sunny-day.jpg?h=699&q=85'
        : 'https://mediad.publicbroadcasting.net/p/shared/npr/styles/x_large/nprshared/201911/778699354.jpg';
    Color backGround = data['isDayTime'] ? Colors.blue : Colors.indigo;

    return Scaffold(
      backgroundColor: backGround,
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(bgTmage),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
          child: Column(
            children: [
              FlatButton.icon(
                onPressed: () async {
                  dynamic result = await Navigator.pushNamed<WorldTime>(
                      context, '/location');
                  setState(() {
                    data = {
                      'time': result['time'],
                      'location': result['location'],
                      'flag': result['flag'],
                      'isDayTime': result['isDayTime']
                    };
                  });
                },
                icon: Icon(
                  Icons.edit_location,
                  color: Colors.grey[300],
                ),
                label: Text(
                  'Edit Location',
                  style: TextStyle(color: Colors.grey[300]),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data['location'],
                    style: TextStyle(
                        fontSize: 28, letterSpacing: 2, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                data['time'],
                style: TextStyle(
                  fontSize: 60,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
