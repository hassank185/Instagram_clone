










import 'package:instagram_clone/features/domain/entities/comment/comment_entity.dart';
import 'package:instagram_clone/features/domain/entities/post/post_entity.dart';
import 'package:instagram_clone/features/domain/repositories/firebase_repository.dart';

class DeleteCommentUseCase{
  final FirebaseRepository repository;

  DeleteCommentUseCase({required this.repository});
  Future<void> call(CommentEntity comment) {
    return repository.deleteComment(comment);
  }
}