import 'package:shelf/shelf.dart';

import 'apis/blog_api.dart';
import 'apis/login_api.dart';
import 'infra/custom_server.dart';
import 'infra/middleware_interception.dart';
import 'services/noticia_service.dart';
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
        BlogApi(NoticiaService()).handler,
      )
      .handler;

  var pipeline = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterception().middleware)
      .addHandler(cascadeHandler);

  await CustomServer().initialize(
    handler: pipeline,
    address: await CustomEnv.get<String>(key: 'server_address'),
    port: await CustomEnv.get<int>(key: 'server_port'),
  );
}

// continuar aqui
//https://www.youtube.com/watch?v=STFJLSIYN18&list=PLRpTFz5_57csByx34C_98wPn3PAxnUDFr&index=15