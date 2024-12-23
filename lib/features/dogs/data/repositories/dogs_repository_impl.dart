import 'package:dogs/core/enums.dart';
import 'package:dogs/features/dogs/data/datasources/remote/dogs_datasource_remote_http.dart';
import 'package:dogs/features/dogs/data/dtos/dogs_response_dto.dart';
import 'package:dogs/features/dogs/domain/entities/dogs_response_entity.dart';
import 'package:dogs/features/dogs/domain/repositories/dogs_repository.dart';
import 'package:dogs/utils/functions.dart';

class DogsRepositoryImpl implements DogsRepository {
  DogsDataSourceRemoteHttp dogsDataSourceRemoteHttp;

  DogsRepositoryImpl({
    required this.dogsDataSourceRemoteHttp,
  });

  @override
  Future<DogResponse> getDogs(String search) async {
    if (!await Functions.checkConn()) {
      return DogResponse(
        dogs: [],
        responseStatus: ResponseStatus.noConnection,
      );
    }

    DogResponseDto dogResponseDto = await dogsDataSourceRemoteHttp.getDogs(search);
    return dogResponseDto.toEntity();
  }
}
