import 'package:dogs/features/dogs/domain/entities/dogs_response_entity.dart';

abstract class DogsRepository {
  Future<DogResponse> getDogs(String search);
}
