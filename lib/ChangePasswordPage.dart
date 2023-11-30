import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'AuthentificationService.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String email;

  ChangePasswordScreen({required this.email});

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController oldPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
  TextEditingController confirmNewPass = TextEditingController();
  TextEditingController email = TextEditingController();
  final AuthenticationService _authenticationService = AuthenticationService();

  bool hideOldPass = true;
  bool hideNewPass = true;
  bool hideConfirmNewPass = true;
  bool isLoading = false;

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
              "Change \nPassword",
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 40,
                  fontWeight: FontWeight.w600),
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
                  Text(
                    "Insert Password",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  TextField(
                    controller: email,
                    decoration: InputDecoration(
                      hintText: "E-mail",
                    ),
                  ),
                  TextField(
                    controller: oldPass,
                    obscureText: hideOldPass,
                    decoration: InputDecoration(
                      hintText: "Old Password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hideOldPass = !hideOldPass;
                          });
                        },
                        icon: hideOldPass
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                      ),
                    ),
                  ),
                  TextField(
                    controller: newPass,
                    obscureText: hideNewPass,
                    decoration: InputDecoration(
                      hintText: "New Password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hideNewPass = !hideNewPass;
                          });
                        },
                        icon: hideNewPass
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                      ),
                    ),
                  ),
                  TextField(
                    controller: confirmNewPass,
                    obscureText: hideConfirmNewPass,
                    decoration: InputDecoration(
                      hintText: "Confirm New Password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hideConfirmNewPass = !hideConfirmNewPass;
                          });
                        },
                        icon: hideConfirmNewPass
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true; // Activar el spinner de carga
                        });
                        try {
                          // Obtén los valores de los controladores
                          String userEmail = email.text;
                          String oldPassword = oldPass.text;
                          String newPassword = newPass.text;
                          String confirmNewPassword = confirmNewPass.text;

                          // Verifica si las contraseñas coinciden
                          if (newPassword != confirmNewPassword) {
                            throw Exception("Las contraseñas no coinciden");
                          }

                          Usuario user = await _authenticationService.authenticateUser(userEmail, oldPassword);

                          // Cambia la contraseña en la base de datos
                          await _authenticationService.changePassword(userEmail, newPassword);

                          // Muestra un AlertDialog cuando el cambio es correcto
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Éxito'),
                                content: Text('¡La contraseña se cambió correctamente!'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      setState(() {
                                        isLoading = false; // Desactivar el spinner de carga
                                      });
                                    },
                                    child: Text('Aceptar'),
                                  ),
                                ],
                              );
                            },
                          );
                        } catch (e) {
                          // Manejo de errores
                          print('Error durante el cambio de contraseña: $e');

                          // Muestra un AlertDialog con el mensaje de error
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Error'),
                                content: Text('Hubo un error durante el cambio de contraseña: $e'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      setState(() {
                                        isLoading = false; // Desactivar el spinner de carga en caso de error
                                      });
                                    },
                                    child: Text('Aceptar'),
                                  ),
                                ],
                              );
                            },
                          );
                        }



                        // Agrega aquí la lógica para cambiar la contraseña

                        // Simulación de una tarea asincrónica (puedes reemplazar esto con tu lógica real)

                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.deepOrangeAccent,
                        padding: EdgeInsets.symmetric(
                            vertical: 5, horizontal: 60),
                      ),
                      child: Text("Change Password"),
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
            ),
          ),
        ],
      ),
    );
  }
}
