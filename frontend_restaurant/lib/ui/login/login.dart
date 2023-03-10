import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:frontend/config/exports.dart';
import 'package:frontend/helpers/screen_actions.dart';
import 'package:frontend/ui/login/controllers.dart';
import 'package:frontend/ui/widgets/powered_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginControllers _controllers = LoginControllers();
  bool loading = true;
  bool obscureC = true;
  @override
  void didChangeDependencies() {
    Future.delayed(Duration(seconds: 4), () {
      setState(() {
        loading = false;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: getScreenActions(Column(
      children: [
        Expanded(
          child: _content(),
        ),
        getPoweredWidget()
      ],
    )));
  }

  Column _content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _logo(),
        getLoadingWidget(
            child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            _modelTextField(
                text: "@Email",
                obscure: false,
                email: true,
                controller: _controllers.controllerMail),
            SizedBox(
              height: 20,
            ),
            _modelTextField(
                text: "Contraseña",
                obscure: obscureC,
                email: false,
                controller: _controllers.controllerPassword),
            SizedBox(
              height: 20,
            ),
            Text(text.labelLogin),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.colorGreen,
                  minimumSize: Size(150, 40),
                ),
                onPressed: () async {
                  await _controllers.login(success: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/layout', (route) => false);
                  }, error: () {
                    AwesomeDialog(
                      width: 500,
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.rightSlide,
                      title: 'Credenciales Incorrectas',
                      desc: 'Vuelve a intentarlo',
                      btnCancel: Container(),
                      btnOkText: "Aceptar",
                      btnOkColor: colors.colorGreen,
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {},
                    ).show();
                  });
                },
                child: Text(
                  "INGRESAR",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ))
          ],
        ))
      ],
    );
  }

  Column _logo() {
    return Column(
      children: [
        Image.asset(
          config.logoFonles,
          width: 200,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          text.fonlesPOS,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  getLoadingWidget({required child}) {
    if (loading == true) {
      return Container(
          width: 40,
          height: 40,
          child: CircularProgressIndicator(
            color: colors.colorGreen,
          ));
    } else {
      return child;
    }
  }

  _modelTextField({text, obscure, email, controller}) {
    return Container(
      width: 450,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Color.fromARGB(255, 245, 244, 244),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: TextStyle(),
        decoration: InputDecoration(
            hintText: text,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1, color: Color.fromRGBO(237, 241, 245, 1.0)),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1, color: Color.fromRGBO(237, 241, 245, 1.0)),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusColor: Colors.black,
            iconColor: Colors.black,
            suffixIcon: email == false
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        obscureC = !obscureC;
                      });
                    },
                    child: Icon(
                      obscure ? Icons.remove_red_eye_outlined : Icons.password,
                      color: Colors.black,
                    ))
                : null),
      ),
    );
  }
}
