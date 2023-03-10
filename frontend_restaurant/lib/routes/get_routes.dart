import 'package:frontend/ui/layout/layout.dart';
import 'package:frontend/ui/login/login.dart';

getRoutes() {
  return {"/login": (context) => LoginPage(), "/layout": (context) => Layout()};
}
