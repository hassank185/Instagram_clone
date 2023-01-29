
import 'package:instagram_clone/features/domain/repository/firebase_repository.dart';

import '../../../entities/posts/post_entity.dart';

class UpdatePostUseCase {
  final FirebaseRepository repository;

  UpdatePostUseCase({required this.repository});

  Future<void> call(PostEntity post) {
    return repository.updatePost(post);
  }
}