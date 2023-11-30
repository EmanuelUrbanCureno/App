import 'package:flutter/material.dart';
import 'package:login2/main.dart';
import 'AuthentificationService.dart';
import 'IdCard.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool hide = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final AuthenticationService _authenticationService = AuthenticationService();
  final FocusNode confirmPasswordFocus = FocusNode();


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
              "Create Your \nAccount",
              style: TextStyle(
                  color: Colors.white, fontSize: 40, fontWeight: FontWeight.w600),
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
                topLeft: Radius.circular(50),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 45, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: userController,
                    decoration: InputDecoration(
                      hintText: "Name",
                    ),
                  ),
                  TextField(
                    controller: cityController,
                    decoration: InputDecoration(
                      hintText: "City",
                    ),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "E-mail",
                    ),
                  ),
                  TextField(
                    controller: passwordController,
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
                  SizedBox(height: 15),
                  TextField(
                    controller: confirmPasswordController,
                    obscureText: hide,
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
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
                  Center(
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.deepOrangeAccent,
                        padding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 60),
                      ),
                      onPressed: () async {
                        String email = emailController.text;
                        String city = cityController.text;
                        String user = userController.text;
                        String password = passwordController.text;
                        String confirmPassword = confirmPasswordController.text;

                        if (email.isNotEmpty &&
                            city.isNotEmpty &&
                            user.isNotEmpty &&
                            password.isNotEmpty &&
                            confirmPassword.isNotEmpty) {
                          if (password == confirmPassword) {
                            try {
                              await _authenticationService.registerUser(
                                email: email,
                                city: city,
                                user: user,
                                prioridad: "1",
                                image: 'default.jpg',
                                password: password,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Registro exitoso'),
                                  duration: Duration(seconds: 2),
                                ),
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => IdCard(
                                    email: email,
                                    city: city,
                                    user: user,
                                    prioridad: 1,
                                    imagen: 'default',
                                  ),
                                ),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Error al registrar: $e'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Las contraseñas no coinciden'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Todos los campos son obligatorios'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }

                        confirmPasswordFocus.unfocus();
                      },
                      child: Text("Sign Up"),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: Text("Sign In?"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
