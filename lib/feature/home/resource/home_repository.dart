import 'package:MyShoppingList/common/constant/env.dart';
import 'package:MyShoppingList/common/http/api_provider.dart';
import 'package:MyShoppingList/common/http/response.dart';
import 'package:MyShoppingList/common/util/internet_check.dart';
import 'package:MyShoppingList/feature/authentication/resource/user_repository.dart';
import 'package:MyShoppingList/feature/cart/model/cart.dart';
import 'package:MyShoppingList/feature/home/model1/category.dart';
import 'package:MyShoppingList/feature/home/model1/product.dart';
import 'package:MyShoppingList/feature/order/model/order.dart';
import 'package:meta/meta.dart';

import 'home_api_provider.dart';

class HomeRepository {
  ApiProvider apiProvider;
  HomeApiProvider homeApiProvider;
  InternetCheck internetCheck;
  UserRepository userRepository;
  Env env;

  HomeRepository(
      {@required this.env,
      @required this.apiProvider,
      @required this.internetCheck,
      @required this.userRepository}) {
    homeApiProvider = HomeApiProvider(
        baseUrl: env.baseUrl,
        apiProvider: apiProvider,
        userRepository: userRepository);
  }

  Future<DataResponse<List<Product>>> fetchProducts(String query) async {
    final response = await homeApiProvider.fetchProducts(query);

    if (response == null) {
      return DataResponse.connectivityError();
    }

    if (!response.contains('error')) {
      final List<Product> _products = (response as List)?.map((dynamic e) {
        return e == null ? null : Product.fromJson(e as Map<String, dynamic>);
      })?.toList();
      return DataResponse.success(_products);
    } else {
      return DataResponse.error("Error");
    }
  }

  Future<DataResponse<List<Category>>> fetchCategory() async {
    final response = await homeApiProvider.fetchProducts('');

    if (response == null) {
      return DataResponse.connectivityError();
    }

    if (!response.contains('error')) {
      final List<Category> _category = (response as List)?.map((dynamic e) {
        return e == null ? null : Category.fromJson(e as Map<String, dynamic>);
      })?.toList();
      return DataResponse.success(_category);
    } else {
      return DataResponse.error("Error");
    }
  }

  Future<DataResponse<Cart>>addToCart(Product product) async{
    final response = await homeApiProvider.addToCart(product);

    if (response == null) {
      return DataResponse.connectivityError();
    }

    if (response['error'] == null ) {
      return DataResponse.success(Cart.fromJson(response));
    } else {
      return DataResponse.error("Error");
    }
  }

  Future<DataResponse<List<Cart>>>fetchCartItem() async {
    final response = await homeApiProvider.fetchCartItem();
    print(response);
    if (response == null) {
      return DataResponse.connectivityError();
    }

    if (!response.contains('error')) {
      final List<Cart> cart = (response as List)?.map((dynamic e) {
        return e == null ? null : Cart.fromJson(e as Map<String, dynamic>);
      })?.toList();
      return DataResponse.success(cart);
    } else {
      return DataResponse.error("Error");
    }
  }

  Future<DataResponse<Cart>>deleteCartItem(Cart item) async {
    final response = await homeApiProvider.deleteCartItem(item);
    print(response);
    if (response == null) {
      return DataResponse.connectivityError();
    }

    // if (!response['error']) {
      final cart = Cart.fromJson(response as Map<String, dynamic>);
      return DataResponse.success(cart);
    // } else {
    //   return DataResponse.error("Error");
    // }
  }

  Future<DataResponse<List<Order>>>fetchOrders() async{
    final response = await homeApiProvider.fetchOrderItem();
    print(response);
    if (response == null) {
      return DataResponse.connectivityError();
    }

    if (!response.contains('error')) {
      final List<Order> orders = (response as List)?.map((dynamic e) {
        return e == null ? null : Order.fromJson(e as Map<String, dynamic>);
      })?.toList();
      return DataResponse.success(orders);
    } else {
      return DataResponse.error("Error");
    }
  }
}
