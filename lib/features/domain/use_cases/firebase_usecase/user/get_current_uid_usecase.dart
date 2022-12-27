

import 'package:instagram_clone/features/domain/repositories/firebase_repository.dart';

class GetCurrentUidUseCase{
  final FirebaseRepository repository;

  GetCurrentUidUseCase({required this.repository});
  Future<String> call() {
    return repository.getCurrentUid();
  }
}