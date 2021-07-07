import 'package:clean_arch/app_widget.dart';
import 'package:clean_arch/modules/search/data/repositories/search_repository_impl.dart';
import 'package:clean_arch/modules/search/domain/usecases/search_by_text.dart';
import 'package:clean_arch/modules/search/external/datasources/github_datasource.dart';
import 'package:dio/dio.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SearchByTextImpl(i())),
        Bind((i) => SearchRepositoryImpl(i())),
        Bind((i) => GitHubDatasource(i())),
        Bind((i) => Dio()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  @override
  List<ModularRouter> get routers => throw UnimplementedError();
}
