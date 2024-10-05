import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/common/app/cache_helper.dart';
import 'package:shop/common/app/providers/user_provider.dart';
import 'package:shop/screens/auth/domain/data/datasources/auth_remote_data_source.dart';
import 'package:shop/screens/auth/domain/data/repos/auth_repos_implementation.dart';
import 'package:shop/screens/auth/domain/repos/AuthRepository.dart';
import 'package:shop/screens/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:shop/screens/auth/domain/usecases/login_usecase.dart';
import 'package:shop/screens/auth/domain/usecases/register_usecase.dart';
import 'package:shop/screens/auth/domain/usecases/reset_password_usecase.dart';
import 'package:shop/screens/auth/domain/usecases/verify_reset_otp_usecase.dart';
import 'package:shop/screens/auth/domain/usecases/verify_token_usecase.dart';
import 'package:http/http.dart' as http;
import 'package:shop/screens/auth/presentation/adapter/auth_adapter.dart';
import 'package:shop/utils/constants.dart';
final sl = GetIt.instance;

Future<void> init() async {
  await _cacheInit();
  await _authInit();
}

Future<void> _authInit() async {
  // Register use cases
  sl
    ..registerLazySingleton(() => ForgotPassword(sl()))
    ..registerLazySingleton(() => Login(sl()))
    ..registerLazySingleton(() => Register(sl()))
    ..registerLazySingleton(() => VerifyResetOtp(sl()))
    ..registerLazySingleton(() => VerifyToken(sl()))
    ..registerLazySingleton(() => ResetPassword(sl()))

  // Register remote data source
    ..registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(
        client: sl(),
        baseUrl: 'http://192.168.1.9:8080'
    ))

  // Register AuthRepository
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImplementation(
      baseUrl,
      sl(), // Injecting AuthRemoteDataSource here
    ))

  // Register UserProvider
    ..registerLazySingleton<UserProvider>(() => UserProvider())

  // Register AuthCubit
    ..registerLazySingleton<AuthCubit>(() => AuthCubit(
      forgotPassword: sl(),
      login: sl(),
      register: sl(),
      verifyResetOtp: sl(),
      verifyToken: sl(),
      currentUserProvider: sl(),
      resetPassword:  sl(),
    ))

  // Register HTTP client
    ..registerLazySingleton(() => http.Client());
}

Future<void> _cacheInit() async {
  final prefs = await SharedPreferences.getInstance();

  sl
    ..registerLazySingleton(() => CacheHelper(prefs))
    ..registerLazySingleton(() => prefs);
}
