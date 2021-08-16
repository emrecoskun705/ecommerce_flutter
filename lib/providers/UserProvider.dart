import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:ecommerce_flutter/services/login_api.dart';
import 'package:ecommerce_flutter/utils/user_secure_storage.dart';

class UserProvider with ChangeNotifier {
  String _errorMessage = '';
  bool _loading = false;
  bool _error = false;
  bool _isLoggedIn = false;

  //This method is used for authenticate(login) user
  //TODO: add other statusCodes like 400
  Future fetchUser(String email, String password) async {
    setLoading(true);
    // fetches the data from login api then if data has key, it authenticates the user to app
    var success =
        await LoginApi(email: email, password: password).fetchData().then(
      (response) async {
        setLoading(false);
        if (response.statusCode == 200) {
          dynamic data = jsonDecode(response.body);
          if (data['key'] != null) {
            setError(false);
            //store token somewhere persistent and secure
            await UserTokenSecureStorage.setToken(data['key']);
            setIsLoggedIn(true);
          } else {
            setError(true);
            setMessage('Invalid account information');
            return false;
          }
          return true;
        } else {
          setError(true);
          setMessage('Invalid account information');
          return false;
        }
      },
    );

    return success;
  }

  Future logout() async {
    if (_isLoggedIn) {
      setLoading(true);
      await UserTokenSecureStorage.deleteToken();
      setIsLoggedIn(false);
      setLoading(false);
    }
  }

  // setter and getter part for fields

  bool get isLoggedIn => _isLoggedIn;

  void setIsLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  void setError(bool value) {
    _error = value;
    notifyListeners();
  }

  bool get isError => _error;

  void setLoading(value) {
    _loading = value;
    notifyListeners();
  }

  void setMessage(value) {
    _errorMessage = value;
    notifyListeners();
  }

  String getMessage() {
    return _errorMessage;
  }

  bool get isLoading => _loading;
}
