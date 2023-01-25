
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/features/domain/entities/comment/comment_entity.dart';
import 'package:instagram_clone/features/domain/use_cases/firebase_usecase/comment/create_comment_usecase.dart';
import 'package:instagram_clone/features/domain/use_cases/firebase_usecase/comment/delete_comment_usecase.dart';
import 'package:instagram_clone/features/domain/use_cases/firebase_usecase/comment/like_comment_usecase.dart';
import 'package:instagram_clone/features/domain/use_cases/firebase_usecase/comment/read_comment_usecase.dart';
import 'package:instagram_clone/features/domain/use_cases/firebase_usecase/comment/update_comment_usecase.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  final CreateCommentUseCase createCommentUseCase;
  final DeleteCommentUseCase deleteCommentUseCase;
  final LikeCommentUseCase likeCommentUseCase;
  final ReadCommentUseCase readCommentUseCase;
  final UpdateCommentUseCase updateCommentUseCase;

  CommentCubit({
    required this.createCommentUseCase,
    required this.deleteCommentUseCase,
    required this.likeCommentUseCase,
    required this.readCommentUseCase,
    required this.updateCommentUseCase,
  }) : super(CommentInitial());


  Future<void> getComments({required String postId}) async {
    emit(CommentLoading());
    try {
      final streamResponse = readCommentUseCase.call(postId);
      streamResponse.listen((comments) {
        emit(CommentLoaded(comment: comments));
      });
    } on SocketException catch(_) {
      emit(CommentFailure());
    } catch (_) {
      emit(CommentFailure());
    }
  }

  Future<void> likePost({required CommentEntity comment}) async {
    try {
      await likeCommentUseCase.call(comment);
    } on SocketException catch(_) {
      emit(CommentFailure());
    } catch (_) {
      emit(CommentFailure());
    }
  }

  Future<void> deletePost({required CommentEntity comment}) async {
    try {
      await deleteCommentUseCase.call(comment);
    } on SocketException catch(_) {
      emit(CommentFailure());
    } catch (_) {
      emit(CommentFailure());
    }
  }

  Future<void> createPost({required CommentEntity comment}) async {
    try {
      await createCommentUseCase.call(comment);
    } on SocketException catch(_) {
      emit(CommentFailure());
    } catch (_) {
      emit(CommentFailure());
    }
  }

  Future<void> updatePost({required CommentEntity comment}) async {
    try {
      await updateCommentUseCase.call(comment);
    } on SocketException catch(_) {
      emit(CommentFailure());
    } catch (_) {
      emit(CommentFailure());
    }
  }
}