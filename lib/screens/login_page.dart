import 'package:eatmore/screens/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ValueNotifier<bool>? _islogin;
  @override
  void initState() {
    super.initState();
    _islogin = ValueNotifier<bool>(true);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.loose,
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 30.0,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: size.width * 0.4,
                child: Image.asset(
                  'assets/logo.png',
                  color: Colors.red,
                ),
              ),
            ),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: _islogin!,
            builder: (context, _login, _) {
              return Container(
                constraints: BoxConstraints(maxHeight: 800, maxWidth: 500),
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
                height: size.height * 0.6,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.05),
                        spreadRadius: 1.0,
                        blurRadius: 5.0,
                      )
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 32.0,
                      child: Row(
                        children: [
                          _buildloginType(
                            'Login',
                            _login,
                            () {
                              _islogin!.value = true;
                            },
                          ),
                          _buildloginType(
                            'Sign up',
                            !_login,
                            () {
                              _islogin!.value = false;
                            },
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        _buildTextFormField('Enter email or username'),
                        SizedBox(height: 16.0),
                        _buildTextFormField('Password'),
                        SizedBox(height: 16.0),
                        if (!_login) ...[
                          _buildTextFormField('Confirm password'),
                          SizedBox(height: 16.0),
                        ],
                        if (_login)
                          Container(
                            width: double.infinity,
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Forgot Password?',
                              style:
                                  TextStyle(fontSize: 14.0, color: Colors.grey),
                            ),
                          ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => HomePage(),
                          ),
                          (route) => false,
                        );
                      },
                      child: Container(
                        height: 48.0,
                        alignment: Alignment.center,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Text(
                          _login ? 'Log In' : 'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'OR',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildSocialIcon('facebook'),
                        _buildSocialIcon('twitter'),
                        _buildSocialIcon('google'),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              width: size.width * 0.6,
              child: Image.asset('assets/loginimage.png'),
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildloginType(String title, bool isActive, onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              color: isActive ? Color(0xffff0036) : Colors.white,
              borderRadius: BorderRadius.circular(15.0)),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: isActive ? Colors.white : Color(0xffff0036),
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _buildSocialIcon(String asset) {
    return SizedBox(
      height: 48,
      width: 48,
      child: Image.asset('assets/$asset.png'),
    );
  }

  TextFormField _buildTextFormField(String title) {
    return TextFormField(
      decoration: InputDecoration(
        isCollapsed: true,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 3.0),
        hintText: title,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 14.0),
      ),
    );
  }
}
