import 'package:eos_chatting/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import '../config/palette.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginSignUpScreen extends StatefulWidget {
  const LoginSignUpScreen({Key? key}) : super(key: key);

  @override
  State<LoginSignUpScreen> createState() => _LoginSignUpScreenState();
}

class _LoginSignUpScreenState extends State<LoginSignUpScreen> {
  bool isSignupScreen = false;
  static double _height = 280;
  static double _top = 390;

  final _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget _userNameWidget() {
    return TextFormField(
      controller: _userNameController,
      keyboardType: TextInputType.name,
      validator: (String? value) {
        if (value!.isEmpty) {
          return '사용자명을 입력해주세요.';
        }
        return null;
      },
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.person),
        iconColor: Palette.iconColor,
        labelText: 'User name',
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Palette.textColor1),
          borderRadius: BorderRadius.all(Radius.circular(35)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Palette.textColor1),
          borderRadius: BorderRadius.all(Radius.circular(35)),
        ),
      ),
    );
  }

  Widget _userIdWidget() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (String? value) {
        if (value!.isEmpty) {
          return '이메일을 입력해주세요.';
        }
        return null;
      },
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.email),
        iconColor: Palette.iconColor,
        labelText: 'email',
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Palette.textColor1),
          borderRadius: BorderRadius.all(Radius.circular(35)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Palette.textColor1),
          borderRadius: BorderRadius.all(Radius.circular(35)),
        ),
      ),
    );
  }

  Widget _passwordWidget() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      keyboardType: TextInputType.text,
      validator: (String? value) {
        if (value!.isEmpty) {
          return '비밀번호를 입력해주세요.';
        }
        return null;
      },
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.lock),
        iconColor: Palette.iconColor,
        labelText: 'password',
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Palette.textColor1),
          borderRadius: BorderRadius.all(Radius.circular(35)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Palette.textColor1),
          borderRadius: BorderRadius.all(Radius.circular(35)),
        ),
      ),
    );
  }

  _login() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).requestFocus(FocusNode());
      //https://docs.flutter.dev/ui/advanced/focus

      try {
        await _auth.signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);

        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const ChatScreen()),
            (route) => false,
          );
        }
      } on FirebaseAuthException catch (e) {
        String message = '';

        if (e.code == 'user-not-found') {
          message = '사용자가 존재하지 않습니다.';
        } else if (e.code == 'wrong-password') {
          message = '비밀번호를 확인하세요.';
        } else if (e.code == 'invalid-email') {
          message = '이메일을 확인하세요.';
        } else {
          message = e.code;
        }

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
          backgroundColor: Colors.deepOrange,
        ));
      }
    }
  }

  _signup() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).requestFocus(FocusNode());

      try {
        await _auth
            .createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        )
            .then((value) {
          if (value.user!.email != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('회원가입 완료'),
                backgroundColor: Colors.blue,
              ),
            );

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const ChatScreen()),
              (route) => false,
            );
          }
          return value;
        });
      } on FirebaseAuthException catch (e) {
        String message = '';

        if (e.code == 'weak-password') {
          message = '취약한 비밀번호입니다.';
        } else if (e.code == 'email-already-in-use') {
          message = '이미 사용중인 이메일입니다.';
        } else {
          message = e.code;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.deepOrange,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.fill),
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 90, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: 'Welcome ',
                            style: const TextStyle(
                                letterSpacing: 1.0,
                                fontSize: 25,
                                color: Colors.white),
                            children: [
                          TextSpan(
                            text: isSignupScreen ? 'to EOS chat!' : 'back',
                            style: const TextStyle(
                                letterSpacing: 1.0,
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ])),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      isSignupScreen
                          ? 'Signup to continue'
                          : 'Signin to continue',
                      style: const TextStyle(
                          letterSpacing: 1.0, color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            top: 170,
            duration: const Duration(milliseconds: 400),
            child: AnimatedContainer(
              height: _height,
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 40,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 5,
                    )
                  ]),
              duration: const Duration(seconds: 1),
              curve: Curves.easeIn,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSignupScreen = false;
                            _height = 280;
                            _top = 390;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              'LOGIN',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isSignupScreen
                                    ? Palette.textColor1
                                    : Palette.activeColor,
                              ),
                            ),
                            if (!isSignupScreen)
                              Container(
                                margin: const EdgeInsets.only(top: 3),
                                height: 2,
                                width: 55,
                                color: Colors.green,
                              )
                          ],
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = true;
                              _height = 310;
                              _top = 430;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                'SIGNUP',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSignupScreen
                                        ? Palette.activeColor
                                        : Palette.textColor1),
                              ),
                              if (isSignupScreen)
                                Container(
                                  margin: const EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Colors.green,
                                )
                            ],
                          ))
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          if (isSignupScreen) _userNameWidget(),
                          const SizedBox(height: 8),
                          _userIdWidget(),
                          const SizedBox(
                            height: 8,
                          ),
                          _passwordWidget(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            top: _top,
            right: 0,
            left: 0,
            duration: const Duration(seconds: 1),
            curve: Curves.easeIn,
            child: Center(
                child: Container(
                    padding: const EdgeInsets.all(15),
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: Container(
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [Colors.lightGreen, Colors.green],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(0, 1))
                            ]),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        )))),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height - 125,
            right: 0,
            left: 0,
            child: Column(
              children: [
                Text(
                  isSignupScreen ? 'or Signup with' : 'or Signin with',
                ),
                // SIGNUP 누르면 'or Signup with'
                // SizedBox height 10으로 사이 공간 주기
                const SizedBox(
                  height: 10,
                ),
                TextButton.icon(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    minimumSize: const Size(155, 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    backgroundColor: Palette.googleColor,
                  ),
                  icon: const Icon(Icons.add),
                  label: const Text('Google'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
