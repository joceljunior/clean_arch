import 'package:clean_arch/modules/search/data/datasource/search_datasource.dart';
import 'package:clean_arch/modules/search/domain/errors/errors.dart';
import 'package:clean_arch/modules/search/domain/entities/result_search.dart';
import 'package:clean_arch/modules/search/domain/repositories/search_repository.dart';
import 'package:dartz/dartz.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchDatasource datasource;
  SearchRepositoryImpl(this.datasource);
  @override
  Future<Either<FailureSearch, List<ResultSearch>>> search(
      String searchText) async {
    try {
      final result = await datasource.getSearch(searchText);
      return Right(result);
    } on DatasourceError catch (e) {
      // garante que e = DatasourceError
      return Left(e);
    } catch (e) {
      return Left(DatasourceError());
    }
  }
}
