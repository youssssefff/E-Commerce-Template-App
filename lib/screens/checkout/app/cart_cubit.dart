import 'package:bloc/bloc.dart';
import 'package:shop/common/models/cart.dart';
import 'package:shop/common/models/cart_product.dart';
import 'package:shop/screens/checkout/domain/usecases/add_to_cart.dart';
import 'package:shop/screens/checkout/domain/usecases/get_cart.dart';
import 'package:shop/screens/checkout/domain/usecases/get_user_cart_count.dart';
import 'package:shop/screens/checkout/domain/usecases/modify_product_quantity.dart';
import 'package:shop/screens/checkout/domain/usecases/remove_from_cart.dart';
import 'package:shop/utils/constants.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({
    required GetCart getCart,
    required GetUserCartCount getCartCount,
    required AddToCart addToCart,
    required RemoveFromCart removeFromCart,
    required ModifyProductQuantity modifyProductQuantity,
  })  : _getCart = getCart,
        _getCartCount = getCartCount,
        _addToCart = addToCart,
        _removeFromCart = removeFromCart,
        _modifyProductQuantity = modifyProductQuantity,
        super(const CartInitial());

  final GetCart _getCart;
  final GetUserCartCount _getCartCount;
  final AddToCart _addToCart;
  final RemoveFromCart _removeFromCart;
  final ModifyProductQuantity _modifyProductQuantity;

  // Fetch the cart for a user
  Future<void> getCart(String userId) async {
    emit(const CartLoading());
    final result = await _getCart(userId);
    result.fold(
          (failure) => emit(CartError(failure)),
          (cart) => emit(CartSuccess(cart)),
    );
  }

  // Fetch the number of items in the cart
  Future<void> getUserCartCount(String userId) async {
    emit(const CartCountLoading());
    final result = await _getCartCount(userId);
    result.fold(
          (failure) => emit(CartError(failure)),
          (count) => emit(CartCountSuccess(count as int)),
    );
  }

  // Add a product to the cart
  Future<void> addToCart(String userId, CartProduct product) async {
    emit(const CartUpdating());
    final result = await _addToCart(userId, product);
    result.fold(
          (failure) => emit(CartError(failure)),
          (cart) => emit(CartSuccess(cart)),
    );
  }

  // Remove a product from the cart
  Future<void> removeFromCart(String userId, String productId) async {
    emit(const CartUpdating());
    final result = await _removeFromCart(userId ,productId);
    result.fold(
          (failure) => emit(CartError(failure)),
          (cart) => emit(CartSuccess(cart)),
    );
  }

  // Modify the quantity of a product in the cart
  Future<void> modifyProductQuantity(String userId, String productId, int newQuantity) async {
    emit(const CartUpdating());
    final result = await _modifyProductQuantity( userId,  productId, newQuantity);
    result.fold(
          (failure) => emit(CartError(failure)),
          (cart) => emit(CartSuccess(cart)),
    );
  }
}
