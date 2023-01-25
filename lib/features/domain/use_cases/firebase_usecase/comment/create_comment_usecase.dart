








import 'package:instagram_clone/features/domain/entities/comment/comment_entity.dart';
import 'package:instagram_clone/features/domain/entities/post/post_entity.dart';
import 'package:instagram_clone/features/domain/repositories/firebase_repository.dart';

class CreateCommentUseCase{
  final FirebaseRepository repository;

  CreateCommentUseCase({required this.repository});
  Future<void> call(CommentEntity comment) {
    return repository.createComment(comment);
  }
}