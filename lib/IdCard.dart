import 'package:flutter/material.dart';


class IdCard extends StatefulWidget {
  final String email;
  final String city;
  final String user;
  final int prioridad;
  final String imagen;

  IdCard({
    required this.email,
    required this.city,
    required this.user,
    required this.prioridad,
    required this.imagen,
  });

  @override
  _CustomIdCardState createState() => _CustomIdCardState();
}

class _CustomIdCardState extends State<IdCard> {
  int level = 0;



  @override
  Widget build(BuildContext context) {

    String user = "";


    return Scaffold(
      backgroundColor: Colors.orangeAccent, //
      appBar: AppBar(
        title: Text('Custom ID Card'),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent, //
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            level += 1;
          });
        },
        backgroundColor: Colors.deepOrangeAccent,
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
             Center(
              child: CircleAvatar(
                radius: 60.0,
                backgroundImage: AssetImage('assets/${widget.imagen}'),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'NOMBRE',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              widget.user,
              style: TextStyle(
                color: Colors.orange[100], // Cambiado a color azul claro
                fontWeight: FontWeight.bold,
                fontSize: 28.0,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'CORREO',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              widget.email,
              style: TextStyle(
                color: Colors.orange[100], // Cambiado a color azul claro
                fontWeight: FontWeight.bold,
                fontSize: 28.0,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              'CIUDAD NATAL',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              widget.city,
              style: TextStyle(
                color: Colors.orange[100],
                fontWeight: FontWeight.bold,
                fontSize: 28.0,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              'PRIORIDAD',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              widget.prioridad.toString(),
              style: TextStyle(
                color: Colors.orange[100],
                fontWeight: FontWeight.bold,
                fontSize: 28.0,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 30.0),
            Row(
              children: <Widget>[
                Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                SizedBox(width: 10.0),
                Text(
                 user,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
