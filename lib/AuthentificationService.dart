import 'package:http/http.dart' as http;
import 'dart:convert';

class Usuario {
  final String user;
  final String password;
  final String email;
  final String city;
  final int prioridad;
  final String image;

  Usuario({
    required this.user,
    required this.password,
    required this.email,
    required this.city,
    required this.prioridad,
    required this.image,
  });
}

class AuthenticationService {
  static const String baseUrl = 'http://192.168.100.247:8081';

  Future<Usuario> authenticateUser(String user, String password) async {
    final response = await http.get(Uri.parse('$baseUrl/usuario'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      for (var userData in data) {
        if (userData['email'] == user && userData['contra'] == password) {
          return Usuario(
            user: userData['nombre'],
            password: userData['contra'],
            email: userData['email'],
            city: userData['ciudad'],
            prioridad: userData['prioridad'],
            image: userData['imagen'],
          );
        }
      }

      throw Exception("Credenciales incorrectas");
    } else {
      throw Exception("Error al conectarse a la API");
    }
  }


  Future<void> registerUser({
    required String email,
    required String city,
    required String user,
    required String prioridad,
    required String image,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/usuario'),
        body: jsonEncode({
          'email': email,
          'ciudad': city,
          'nombre': user,
          'prioridad': prioridad,
          'imagen': image,
          'contra': password,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Registro exitoso
        print('Usuario registrado con éxito');
      } else {
        // Manejo de errores en caso de que la solicitud falle
        print('Error en la solicitud de registro. Código de estado: ${response.statusCode}');
        print('Respuesta del servidor: ${response.body}');
        throw Exception("Error al registrar");
      }
    } catch (e) {
      print('Error en la solicitud de registro: $e');
      throw Exception("Error al registrar usuario");
    }
  } //TEST
  Future<void> changePassword(String email, String newPassword) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/usuario/cambiar-contrasena'),
        body: jsonEncode({
          'email': email,
          'nuevaContrasena': newPassword,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Cambio de contraseña exitoso
        print('Contraseña cambiada con éxito');
      } else {
        // Manejo de errores en caso de que la solicitud falle
        print('Error en la solicitud de cambio de contraseña. Código de estado: ${response.statusCode}');
        print('Respuesta del servidor: ${response.body}');
        throw Exception("Error al cambiar la contraseña");
      }
    } catch (e) {
      print('Error en la solicitud de cambio de contraseña: $e');
      throw Exception("Error al cambiar la contraseña");
    }
  }

}