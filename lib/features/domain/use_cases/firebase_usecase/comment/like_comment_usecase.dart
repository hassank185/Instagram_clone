








import 'package:instagram_clone/features/domain/entities/comment/comment_entity.dart';
import 'package:instagram_clone/features/domain/entities/post/post_entity.dart';
import 'package:instagram_clone/features/domain/repositories/firebase_repository.dart';

class LikeCommentUseCase{
  final FirebaseRepository repository;

  LikeCommentUseCase({required this.repository});
  Future<void> call(CommentEntity comment) {
    return repository.likeComment(comment);
  }
}