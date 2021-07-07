import 'package:clean_arch/modules/search/domain/entities/result_search.dart';
import 'package:clean_arch/modules/search/domain/errors/errors.dart';
import 'package:dartz/dartz.dart';

//apenas é a interfaceação da camada de external
abstract class SearchRepository {
  Future<Either<FailureSearch, List<ResultSearch>>> search(String searchText);
}
