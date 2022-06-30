import 'package:shelf/shelf.dart';

import 'api/blog_api.dart';
import 'api/login_api.dart';
import 'infra/custom_server.dart';
import 'utils/custom_env.dart';

void main() async {
  // Fazer o if para verificar se a aplicação está em debug ou produção.
  CustomEnv.fromFile('.env');

  // Criação de vários Handler => utilizar cascata

  // Middleway

  var cascadeHandler = Cascade()
      .add(
        LoginApi().handler,
      )
      .add(
        BlogApi().handler,
      )
      .handler;

  var pipeline =
      Pipeline().addMiddleware(logRequests()).addHandler(cascadeHandler);

  await CustomServer().initialize(
    handler: pipeline,
    address: await CustomEnv.get<String>(key: 'server_address'),
    port: await CustomEnv.get<int>(key: 'server_port'),
  );
}

// continuar aqui
// https://www.youtube.com/watch?v=UDQhKinTGj8&list=PLRpTFz5_57csByx34C_98wPn3PAxnUDFr&index=10