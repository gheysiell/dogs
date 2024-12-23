import 'package:dogs/core/constants.dart';
import 'package:dogs/features/dogs/domain/entities/dogs_entity.dart';

class DogDto {
  int id;
  String name, imageUrl, bredFor, lifeSpan, temperament, origin;
  String weight, height;

  DogDto({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.bredFor,
    required this.lifeSpan,
    required this.temperament,
    required this.origin,
    required this.weight,
    required this.height,
  });

  factory DogDto.fromMap(Map<String, dynamic> map) {
    return DogDto(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      imageUrl: '${Constants.apiUrlCdn}images/${map['reference_image_id']}.jpg',
      bredFor: map['bred_for'] ?? '',
      lifeSpan: map['life_span'] ?? '',
      temperament: map['tempe rament'] ?? '',
      origin: map['origin'] ?? '',
      weight: map['weight']['metric'] ?? '0',
      height: map['height']['metric'] ?? '0',
    );
  }

  Dog toEntity() {
    return Dog(
      id: id,
      name: name,
      imageUrl: imageUrl,
      bredFor: bredFor,
      lifeSpan: lifeSpan,
      temperament: temperament,
      origin: origin,
      weight: weight,
      height: height,
    );
  }
}
