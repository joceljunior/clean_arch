// sempre depender de uma abstração e nunca de uma implementação
import 'package:clean_arch/modules/search/domain/entities/result_search.dart';
import 'package:clean_arch/modules/search/domain/errors/errors.dart';
import 'package:clean_arch/modules/search/domain/repositories/search_repository.dart';
import 'package:dartz/dartz.dart';

abstract class SearchByText {
  // either obriga a quem implementa a utilizar tratamento de erro
  // exeception tratada em um arquivo separado
  Future<Either<FailureSearch, List<ResultSearch>>> call(String searchText);
}

// implmentacao no mesmo arquivo, NAO GOSTO - mas a nivel de estudo esta valendo
class SearchByTextImpl implements SearchByText {
  final SearchRepository repository; // injecao de dependencia do meu repository

  SearchByTextImpl(this.repository);
  @override
  Future<Either<FailureSearch, List<ResultSearch>>> call(
      String searchText) async {
    if (searchText == null || searchText.isEmpty) {
      return Left(InvalidTextError());
    }
    return repository
        .search(searchText); // passando responsabilidade para o repository
  }
}
