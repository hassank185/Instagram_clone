




import 'package:instagram_clone/features/domain/entities/user/user_entity.dart';
import 'package:instagram_clone/features/domain/repositories/firebase_repository.dart';

class SignInUseCase{
  final FirebaseRepository repository;

  SignInUseCase({required this.repository});
  Future<void> call(UserEntity user) {
    return repository.signInUser(user);
  }
}
