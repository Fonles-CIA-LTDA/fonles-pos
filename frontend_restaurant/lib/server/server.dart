import 'package:frontend/config/exports.dart';
import 'package:process_run/shell.dart';
import 'package:process_runner/process_runner.dart';

class Server {
  var shell = Shell();
  ProcessRunner processRunner = ProcessRunner();

  getBackendStatus() async {
    try {
      var stopServer = await shell.run('''
    # Status server
    pm2 list | grep ${config.serverName}''');
      return stopServer.outText.contains("${config.serverName}");
    } catch (e) {
      print(e);
      return false;
    }
  }

  getBackendPath() async {
    ProcessRunnerResult result = await processRunner.runProcess(['pwd']);
    var temporalPathList = result.stdout.toString().split("/");
    temporalPathList.removeLast();
    String path = temporalPathList.join("/");
    return "$path/${config.serverName}";
  }

  startServer() async {
    var status = await getBackendStatus();
    if (!status) {
      try {
        var path = await getBackendPath();
        var startServer = await shell.run('''
    # Start server
    pm2 start --name ${config.serverName} --cwd $path "npm run develop" ''');
      } catch (e) {
        print(e);
      }
    }
  }

  stopServer() async {
    try {
      var stopServer = await shell.run('''
    # Stop server
    pm2 delete ${config.serverName}''');
    } catch (e) {
      print(e);
    }
  }
}
