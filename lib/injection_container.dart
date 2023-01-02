
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:instagram_clone/features/data/remote/data_sources/remote_data_source.dart';
import 'package:instagram_clone/features/data/remote/data_sources/remote_data_source_impl.dart';
import 'package:instagram_clone/features/data/repositories/firebase_repository_impl.dart';
import 'package:instagram_clone/features/domain/repositories/firebase_repository.dart';
import 'package:instagram_clone/features/domain/use_cases/firebase_usecase/cloud_storage_usecase/upload_image_to_cloud_storage_usecase.dart';
import 'package:instagram_clone/features/domain/use_cases/firebase_usecase/post/create_post_usecase.dart';
import 'package:instagram_clone/features/domain/use_cases/firebase_usecase/post/delete_post_usecase.dart';
import 'package:instagram_clone/features/domain/use_cases/firebase_usecase/post/like_post_usecase.dart';
import 'package:instagram_clone/features/domain/use_cases/firebase_usecase/post/read_post_usecase.dart';
import 'package:instagram_clone/features/domain/use_cases/firebase_usecase/post/read_single_post_usecase.dart';
import 'package:instagram_clone/features/domain/use_cases/firebase_usecase/post/update_post_usecase.dart';
import 'package:instagram_clone/features/domain/use_cases/firebase_usecase/user/create_user_usecase.dart';
import 'package:instagram_clone/features/domain/use_cases/firebase_usecase/user/get_current_uid_usecase.dart';
import 'package:instagram_clone/features/domain/use_cases/firebase_usecase/user/get_single_user_usecase.dart';
import 'package:instagram_clone/features/domain/use_cases/firebase_usecase/user/get_user_usecase.dart';
import 'package:instagram_clone/features/domain/use_cases/firebase_usecase/user/is_sign_in_usecase.dart';
import 'package:instagram_clone/features/domain/use_cases/firebase_usecase/user/sign_in_usecase.dart';
import 'package:instagram_clone/features/domain/use_cases/firebase_usecase/user/sign_out_usecase.dart';
import 'package:instagram_clone/features/domain/use_cases/firebase_usecase/user/sign_up_usecase.dart';
import 'package:instagram_clone/features/domain/use_cases/firebase_usecase/user/update_user_usecase.dart';
import 'package:instagram_clone/features/presentation/manager/auth/auth_cubit.dart';
import 'package:instagram_clone/features/presentation/manager/credentail/credential_cubit.dart';
import 'package:instagram_clone/features/presentation/manager/post/post_cubit.dart';
import 'package:instagram_clone/features/presentation/manager/user/get_single_user/get_single_user_cubit.dart';
import 'package:instagram_clone/features/presentation/manager/user/user_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubits
  sl.registerFactory(
    () => AuthCubit(
      signOutUseCase: sl.call(),
      isSignInUseCase: sl.call(), getCurrentUidUseCase: sl.call(),
    ),
  );

  sl.registerFactory(
    () => CredentialCubit(
      signUpUseCase: sl.call(),
      signInUserUseCase: sl.call(),
    ),
  );

  sl.registerFactory(
    () => UserCubit(
      updateUserUseCase: sl.call(),
      getUsersUseCase: sl.call(),
    ),
  );

  sl.registerFactory(
    () => GetSingleUserCubit(getSingleUserUseCase: sl.call()),
  );

  //Post Cubit
  sl.registerFactory(
    () => PostCubit(
        createPostUseCase: sl.call(),
        deletePostUseCase: sl.call(),
        readPostUseCase: sl.call(),
        likePostUseCase: sl.call(),
        updatePostUseCase: sl.call()),
  );

  // Use Cases
  // User
  sl.registerLazySingleton(() => SignOutUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => IsSignInUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetCurrentUidUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => SignUpUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => SignInUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => UpdateUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetUsersUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => CreateUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetSingleUserUseCase(repository: sl.call()));
  //Cloud Storage
  sl.registerLazySingleton(() => UploadImageToCloudStorage(repository: sl.call()));

  //Post
  sl.registerLazySingleton(() => CreatePostUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => ReadPostUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => UpdatePostUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => LikePostUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => DeletePostUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => ReadSinglePostUseCase(repository: sl.call()));


  // Repository

  sl.registerLazySingleton<FirebaseRepository>(() => FirebaseRepositoryImpl(remoteDataSource: sl.call()));

  // Remote Data Source
  sl.registerLazySingleton<FirebaseRemoteDataSource>(
      () => FirebaseRemoteDataSourceImpl(firebaseFireStore: sl.call(), firebaseAuth: sl.call(), firebaseStorage: sl.call()));

  //1 Externals

  final firebaseFireStore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseStorage = FirebaseStorage.instance;
  sl.registerLazySingleton(() => firebaseStorage);
  sl.registerLazySingleton(() => firebaseFireStore);
  sl.registerLazySingleton(() => firebaseAuth);
}
