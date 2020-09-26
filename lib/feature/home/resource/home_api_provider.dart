import 'dart:async';

import 'package:MyShoppingList/common/http/api_provider.dart';
import 'package:MyShoppingList/feature/authentication/resource/user_repository.dart';
import 'package:MyShoppingList/feature/cart/model/cart.dart';
import 'package:MyShoppingList/feature/home/model1/product.dart';
import 'package:meta/meta.dart';

class HomeApiProvider {
  HomeApiProvider(
      {@required this.baseUrl,
      @required this.apiProvider,
      @required this.userRepository})
      : assert(apiProvider != null),
        assert(userRepository != null);

  final ApiProvider apiProvider;
  final UserRepository userRepository;
  final String baseUrl;

  Future<dynamic> fetchProducts(String query) async {
    var token = await this.userRepository.fetchToken();
    return apiProvider.get('$baseUrl/products?name_contains=$query', token: token);
  }

  Future<dynamic> fetchCategory() async {
    var token = await this.userRepository.fetchToken();
    return apiProvider.get('$baseUrl/category', token: token);
  }

  Future<dynamic> addToCart(Product product) async{
    var token = await this.userRepository.fetchToken();
    return apiProvider.post('$baseUrl/carts', {"product":product.id},token: token);
  }

  Future<dynamic> fetchCartItem() async{
    var token = await this.userRepository.fetchToken();
    return apiProvider.get('$baseUrl/carts',token: token);
  }

  Future<dynamic> deleteCartItem(Cart item) async {
    var token = await this.userRepository.fetchToken();
    return apiProvider.delete('$baseUrl/carts/${item.id}',token: token);
  }

  Future<dynamic> fetchOrderItem() async{
    var token = await this.userRepository.fetchToken();
    return apiProvider.get('$baseUrl/orders',token: token);
  }
}
