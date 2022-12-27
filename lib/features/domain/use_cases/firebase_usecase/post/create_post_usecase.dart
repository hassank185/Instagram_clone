






import 'package:instagram_clone/features/domain/entities/post/post_entity.dart';
import 'package:instagram_clone/features/domain/repositories/firebase_repository.dart';

class CreatePostUseCase{
  final FirebaseRepository repository;

  CreatePostUseCase({required this.repository});
  Future<void> call(PostEntity post) {
    return repository.createPost(post);
  }
}