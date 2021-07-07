import 'dart:convert';

import 'package:clean_arch/app_module.dart';
import 'package:clean_arch/modules/search/domain/entities/result_search.dart';
import 'package:clean_arch/modules/search/domain/usecases/search_by_text.dart';
import 'package:clean_arch/modules/search/utils/github_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock(); // mock do dio
  //iniciar o module
  initModule(AppModule(), changeBinds: [
    Bind<Dio>((i) =>
        dio), // bind para nao buscar dados externos e tipando o bind para garantir o tipo e o mock
  ]);
  test('Deve recuperar o usecase sem erro', () {
    final usecase = Modular.get<SearchByText>();

    expect(usecase, isA<SearchByTextImpl>());
  });

  //teste completo / teste de integração, garantindo que todas as camadas estao conversando
  test('Deve trazer uma ista de ResultSearch', () async {
    // ignore: missing_required_param
    when(dio.get(any)).thenAnswer((_) async => Response(
        data: jsonDecode(githubResponse),
        statusCode: 200)); // mock do objeto retornado

    final usecase = Modular.get<SearchByText>();
    final result = await usecase.call('Jocel');

    expect(result | null, isA<List<ResultSearch>>());
  });
}
