






import 'package:instagram_clone/features/domain/entities/post/post_entity.dart';
import 'package:instagram_clone/features/domain/repositories/firebase_repository.dart';

class ReadPostUseCase{
  final FirebaseRepository repository;

  ReadPostUseCase({required this.repository});
  Stream<List<PostEntity>> call(PostEntity post) {
    return repository.readPosts(post);
  }
}