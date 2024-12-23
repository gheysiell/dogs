import 'package:dogs/core/enums.dart';
import 'package:dogs/features/dogs/domain/entities/dogs_entity.dart';

class DogResponse {
  List<Dog> dogs;
  ResponseStatus responseStatus;

  DogResponse({
    required this.dogs,
    required this.responseStatus,
  });
}
