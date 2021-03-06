import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/noticia_model.dart';
import '../services/generic_service.dart';

class BlogApi {
  // injeçao
  final GenericService<NoticiaModel> _service;
  BlogApi(this._service);

  Handler get handler {
    Router router = Router();

    //LISTAGEM
    router.get(
      '/blog/noticias',
      (Request req) {
        List<NoticiaModel> noticias = _service.findAll();

        List<Map> noticiasMap = noticias.map((e) => e.toJson()).toList();

        return Response.ok(jsonEncode(noticiasMap));
      },
    );

    // NOVA NOTÍCIA
    router.post(
      '/blog/noticias',
      (Request req) async {
        var body = await req.readAsString();

        _service.save(NoticiaModel.fromJson(jsonDecode(body)));
        return Response(201);
      },
    );

    // /blog/noticias?id=1
    // ATUALIZAÇÃO
    router.put(
      '/blog/noticias',
      (Request req) {
        String? id = req.url.queryParameters['id'];
        // _service.save('');
        return Response.ok('Choveu hoje');
      },
    );

    // /blog/noticias?id=1
    // EXCLUSÃO
    router.delete(
      '/blog/noticias',
      (Request req) {
        String? id = req.url.queryParameters['id'];
        // _service.delete(1);
        return Response.ok('Choveu hoje');
      },
    );
    return router;
  }
}
