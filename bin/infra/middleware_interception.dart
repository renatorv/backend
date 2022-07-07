import 'package:shelf/shelf.dart';

///
/// INTERCEPTA A REQUISIÇÃO OU O RESPONSE E FAZ ALGUMA CONFIGURAÇÃO
///

class MiddlewareInterception {
  Middleware get middleware => createMiddleware(
        responseHandler: (Response res) {
          return res.change(
            headers: {'content-type': 'application/json', 'xpto': '123'},
          );
        },
      );
}
