import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:login2/ChangePasswordPage.dart';
import 'package:login2/singIn.dart';
import 'AuthentificationService.dart';
import 'IdCard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hide = true;
  TextEditingController pass = TextEditingController();
  TextEditingController us = TextEditingController();
  String message = "";
  bool isLoading = false;
  final AuthenticationService _authenticationService = AuthenticationService();

  Future<void> login(BuildContext context) async {
    final user = us.text;
    final password = pass.text;

    try {
      Usuario usuario = await _authenticationService.authenticateUser(user, password);
      setState(() {
        message = "";
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => IdCard(
            email: usuario.email,
            city: usuario.city,
            user: usuario.user,
            prioridad: usuario.prioridad,
            imagen: usuario.image,
          ),
        ),
      );
    }  catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("The fields are empty or the email / password is incorrect"),
          );
        },
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Imagen.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 40, left: 40),
            child: Text(
              "Welcome \nBack",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 40,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.45),
            width: double.infinity,
            height: 450,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(50),
                topLeft: Radius.circular(30),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Sing in", style: TextStyle(fontSize: 45, fontWeight: FontWeight.w500)),
                  SizedBox(height: 15,),
                  TextField(
                    controller: us,
                    decoration: InputDecoration(
                      hintText: "E-mail",
                    ),
                  ),
                  TextField(
                    controller: pass,
                    obscureText: hide,
                    decoration: InputDecoration(
                      hintText: "Password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hide = !hide;
                          });
                        },
                        icon: hide
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangePasswordScreen(email: ''),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      ),
                      child: Text("Forget password?"),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => login(context),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.deepOrangeAccent,
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 60),
                      ),
                      child: Text("Sing In"),
                    ),
                  ),
                  if (message.isNotEmpty) // Mostrar mensaje solo si hay uno
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        message,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpPage(),
                            ),
                          );
                        },
                        child: Text("Sing Up?"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Spinner de carga
          isLoading
              ? Center(
            child: SpinKitFadingCircle(
              color: Colors.deepOrangeAccent,
              size: 50.0,
            ),
          )
              : Container(),
        ],
      ),
    );
  }
}
