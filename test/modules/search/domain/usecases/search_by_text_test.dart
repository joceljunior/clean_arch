//procurar sempre manter a mesma estrutura de pastas para testes de unidade
import 'package:clean_arch/modules/search/domain/entities/result_search.dart';
import 'package:clean_arch/modules/search/domain/errors/errors.dart';
import 'package:clean_arch/modules/search/domain/repositories/search_repository.dart';
import 'package:clean_arch/modules/search/domain/usecases/search_by_text.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SearckRepositoryMock extends Mock implements SearchRepository {
} // utilizando o mockito para mockar dados

main() {
  final repository = SearckRepositoryMock();
  final usecase = SearchByTextImpl(repository); // espera um repository

  test('deve retornar uma lista de ResultSearch', () async {
    //caminho feliz
    //efetuando o mock dos dados com o mockito
    when(repository.search(any))
        .thenAnswer((_) async => Right(<ResultSearch>[]));

    final result = await usecase.call('jocel');

    //isA() = verifica o lado que retornou o meu either
    // com o paipe estou ferificando o lado do retorno
    expect(result | null, isA<List<ResultSearch>>()); // caminho feliz
  });

  test('Deve retornar um InvalidTextError caso o campo seja invalido',
      () async {
    when(repository.search(any))
        .thenAnswer((_) async => Right(<ResultSearch>[]));

    //teste do caso de null
    var result = await usecase(null);
    expect(result.fold((l) => l, (r) => r), isA<InvalidTextError>());
    //teste do caso de vazio
    result = await usecase("");
    expect(result.fold((l) => l, (r) => r), isA<InvalidTextError>());
  });
}
