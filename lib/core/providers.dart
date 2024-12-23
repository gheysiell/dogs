import 'package:dogs/features/dogs/data/datasources/remote/dogs_datasource_remote_http.dart';
import 'package:dogs/features/dogs/data/repositories/dogs_repository_impl.dart';
import 'package:dogs/features/dogs/domain/usecases/dogs_usecase.dart';
import 'package:dogs/features/dogs/presentation/viewmodels/dogs_viewmodel.dart';
import 'package:dogs/features/dogs_details/presentation/viewmodels/dogs_details_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  Provider(
    create: (context) => DogsDataSourceRemoteHttpImpl(),
  ),
  Provider(
    create: (context) => DogsUseCase(
      dogsRepository: DogsRepositoryImpl(
        dogsDataSourceRemoteHttp: DogsDataSourceRemoteHttpImpl(),
      ),
    ),
  ),
  ChangeNotifierProvider(
    create: (context) => DogsViewModel(
      dogsUseCase: context.read<DogsUseCase>(),
    ),
  ),
  ChangeNotifierProvider(
    create: (context) => DogsDetailsViewModel(),
  ),
];
