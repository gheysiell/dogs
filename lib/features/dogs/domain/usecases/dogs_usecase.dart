import 'package:dogs/features/dogs/domain/entities/dogs_response_entity.dart';
import 'package:dogs/features/dogs/domain/repositories/dogs_repository.dart';

class DogsUseCase {
  final DogsRepository dogsRepository;

  DogsUseCase({
    required this.dogsRepository,
  });

  Future<DogResponse> getDogs(String search) async {
    return await dogsRepository.getDogs(search);
  }
}
