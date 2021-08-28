import 'package:ecommerce_flutter/models/cart/address.dart';
import 'package:ecommerce_flutter/services/order_api.dart';
import 'package:flutter/cupertino.dart';

class AddressProvider with ChangeNotifier {
  List<Address> addressList = [];
  bool isLoading = true;
  OrderApi _orderApi = OrderApi();

  Future fetchAddressList() async {
    setIsLoading(true);
    var addressList = await _orderApi.getAddresses();
    setAddressList(addressList);
    setIsLoading(false);
  }

  Future addAddressToOrder(int addressId) async {
    setIsLoading(true);
    await _orderApi.addAddressToOrder(addressId);
    setIsLoading(false);
  }

  Future<Address?> createAddress(Address address) async {
    return await _orderApi.postAddresses(address);
  }

  void addAddress(Address address) {
    this.addressList.add(address);
    notifyListeners();
  }

  void setAddressList(List<Address> addressList) {
    this.addressList = addressList;
    notifyListeners();
  }

  void setIsLoading(bool value) {
    this.isLoading = value;
    notifyListeners();
  }
}
