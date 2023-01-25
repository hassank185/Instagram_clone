











import 'package:instagram_clone/features/domain/entities/comment/comment_entity.dart';
import 'package:instagram_clone/features/domain/entities/post/post_entity.dart';
import 'package:instagram_clone/features/domain/repositories/firebase_repository.dart';

class ReadCommentUseCase{
  final FirebaseRepository repository;

  ReadCommentUseCase({required this.repository});
  Stream<List<CommentEntity>> call(String postId) {
    return repository.readComment(postId);
  }
}