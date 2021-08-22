import 'dart:convert';
import 'package:ecommerce_flutter/services/logout_api.dart';
import 'package:ecommerce_flutter/services/register_api.dart';
import 'package:flutter/foundation.dart';
import 'package:ecommerce_flutter/services/login_api.dart';
import 'package:ecommerce_flutter/utils/user_secure_storage.dart';

class UserProvider with ChangeNotifier {
  String _errorMessage = '';
  bool _loading = false;
  bool _error = false;
  bool _isLoggedIn = false;

  //This method is used for authenticate(login) user
  //TODO: add other statusCodes like 400, 500(internal server error)
  Future fetchUser(String email, String password) async {
    setLoading(true);
    // fetches the data from login api then if data has key, it authenticates the user to app
    var success =
        await LoginApi(email: email, password: password).fetchData().then(
      (response) async {
        if (response.statusCode == 200) {
          dynamic data = jsonDecode(response.body);
          if (data['key'] != null) {
            //store token somewhere persistent and secure
            await UserTokenSecureStorage.setToken(data['key']);
            setIsLoggedIn(true);
          } else {
            setMessage('Invalid account information');
            return false;
          }
          return true;
        } else {
          setMessage('Invalid account information');
          return false;
        }
      },
    );

    setLoading(false);
    setError(success);

    return success;
  }

  Future registerUser(String email, String password1, String password2) async {
    setLoading(true);
    setError(false);
    var success = await RegisterApi(
            email: email, password1: password1, password2: password2)
        .fetchData()
        .then((response) async {
      if (response.statusCode == 201) {
        dynamic data = jsonDecode(response.body);
        if (data['key'] != null) {
          //store token somewhere persistent and secure
          await UserTokenSecureStorage.setToken(data['key']);
          setIsLoggedIn(true);

          return true;
        } else {
          // this means user not logged in automatically
          // check django rest framework for registration
          setError(true);
          setMessage('Invalid account information');
          return false;
        }
      } else {
        setError(true);
        setMessage('Invalid account information');
        return false;
      }
    });

    setLoading(false);

    return success;
  }

  Future logout() async {
    if (_isLoggedIn) {
      setLoading(true);
      String? token = await UserTokenSecureStorage.getToken();
      var success =
          await LogoutApi(token: token).fetchData().then((response) async {
        if (response.statusCode == 200) {}
      });

      await UserTokenSecureStorage.deleteToken();
      setIsLoggedIn(false);
      setLoading(false);
      return success;
    } else {
      return false;
    }
  }

  Future checkIsLoggedIn() async {
    var val = await UserTokenSecureStorage.checkLoggedIn();
    setIsLoggedIn(val);
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
