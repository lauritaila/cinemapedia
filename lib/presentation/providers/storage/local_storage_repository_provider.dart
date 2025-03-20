

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/domain/repositories/local_storage_repository_impl.dart';
import 'package:cinemapedia/domain/datasources/isar_datasource.dart';

final localStorageRepositoryProvider = Provider((ref) => LocalStorageRepositoryImpl(IsarDatasource()));