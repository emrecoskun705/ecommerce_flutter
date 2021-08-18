import 'package:ecommerce_flutter/screens/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class AuthenticationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            child: Icon(
              Icons.shopping_cart,
              size: 150.0,
              color: Color(0xFF023047),
            ),
            color: Color(0xFF219EBC),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            color: Color(0xFF219EBC),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundedButton(
                    colour: Color(0xFF219EBC),
                    title: 'Log In with e-mail',
                    onPressed: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return FractionallySizedBox(
                                heightFactor: 1, child: LoginScreen());
                          });
                    },
                  ),
                  RoundedButton(
                    colour: Color(0xFF8ECAE6),
                    title: 'Register',
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return FractionallySizedBox(
                              heightFactor: 1, child: RegisterScreen());
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
