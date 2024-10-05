import 'package:bloc/bloc.dart';
import 'package:shop/common/app/providers/user_provider.dart';
import 'package:shop/screens/user_info/app/adapter/auth_user_state.dart';
import 'package:shop/utils/constants.dart';

import '../../domain/usecases/get_user.dart';
import '../../domain/usecases/get_user_payment_profile.dart';
import '../../domain/usecases/update_user.dart';

class AuthUserCubit extends Cubit<AuthUserState> {
  AuthUserCubit({
    required GetUser getUser,
    required GetUserPaymentProfile getUserPaymentProfile,
    required UpdateUser updateUser,
    required UserProvider userProvider,
  })  : _userProvider = userProvider,
        _getUser = getUser,
        _getUserPaymentProfile = getUserPaymentProfile,
        _updateUser = updateUser,
        super(const AuthUserInitial());

  final GetUser _getUser;
  final GetUserPaymentProfile _getUserPaymentProfile;
  final UpdateUser _updateUser;
  final UserProvider _userProvider;

  // Fetch user by ID
  Future<void> getUser(String userId) async {
    emit(const GetUserLoading()); // Emit loading state

    final result = await _getUser(userId);

    result.fold(
          (failure) => emit(AuthUserError(failure)), // Emit error state
          (user) {
        _userProvider.setUser(user);
        emit(GetUserSuccess(user)); // Emit success state
      },
    );
  }

  // Fetch user's payment profile
  Future<void> getUserPaymentProfile(String userId) async {
    emit(const GetPaymentProfileLoading()); // Emit loading state

    final result = await _getUserPaymentProfile(userId);

    result.fold(
          (failure) => emit(AuthUserError(failure)), // Emit error state
          (paymentProfile) {
        emit(GetPaymentProfileSuccess(paymentProfile)); // Emit success state
      },
    );
  }

  // Update user details
  Future<void> updateUser(String userId,DataMap updatedData) async {
    emit(const UpdateUserLoading()); // Emit loading state

    final result = await _updateUser(UpdateUserParams(userId: userId, updatedData: updatedData));

    result.fold(
          (failure) => emit(AuthUserError(failure)), // Emit error state
          (updatedUser) {
        _userProvider.setUser(updatedUser);
        emit(UpdateUserSuccess(updatedUser)); // Emit success state
      },
    );
  }
}
