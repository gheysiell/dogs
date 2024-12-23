import 'package:dogs/core/enums.dart';
import 'package:dogs/features/dogs/data/dtos/dogs_dto.dart';
import 'package:dogs/features/dogs/domain/entities/dogs_response_entity.dart';

class DogResponseDto {
  List<DogDto> dogsDto;
  ResponseStatus responseStatus;

  DogResponseDto({
    required this.dogsDto,
    required this.responseStatus,
  });

  DogResponse toEntity() {
    return DogResponse(
      dogs: dogsDto.map((dog) => dog.toEntity()).toList(),
      responseStatus: responseStatus,
    );
  }
}
