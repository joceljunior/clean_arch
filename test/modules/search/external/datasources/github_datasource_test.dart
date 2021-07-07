import 'dart:convert';

import 'package:clean_arch/modules/search/domain/errors/errors.dart';
import 'package:clean_arch/modules/search/external/datasources/github_datasource.dart';
import 'package:clean_arch/modules/search/utils/github_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock(); // instancia mockada de dio
  final datasource = GitHubDatasource(dio);
  test('Deve retornar uma lista de resultSearchMOdel', () {
    // ignore: missing_required_param
    when(dio.get(any)).thenAnswer((_) async => Response(
        data: jsonDecode(githubResponse),
        statusCode: 200)); // mock do objeto retornado

    final future = datasource.getSearch(
        'searchText'); // se o retorno for uma future, pode ser passada direta para p expect
    expect(future, completes); // se a future for completa, passa no teste
  });

  test('Deve retornar um erro se o codigo nao for 200', () {
    when(dio.get(any))
        // ignore: missing_required_param
        .thenAnswer((_) async => Response(data: null, statusCode: 401));

    final future = datasource.getSearch(
        'searchText'); // se o retorno for uma future, pode ser passada direta para p expect
    expect(future, throwsA(isA<DatasourceError>())); //
  });
}
