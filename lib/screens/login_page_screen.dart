import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ajimashudi/providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // cntroller log
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // controller regist
  final _registerUsernameController = TextEditingController();
  final _registerEmailController = TextEditingController();
  final _registerPasswordController = TextEditingController();
  bool _obscurePassword = true;

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _registerUsernameController.dispose();
    _registerEmailController.dispose();
    _registerPasswordController.dispose();
    super.dispose();
  }

  //metod notif
  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(16),
        duration: Duration(seconds: 3),
      ),
    );
  }

  // ======================= NEH FORM LOGIN NYOOOO !!!=====================
  Widget _buildLoginForm() {
    return Column(
      children: [
        SizedBox(height: 28),
        TextField(
          controller: _emailController,
          /* <----------- kepin: ini ku ganti no, kam ngasih username njir bukn email kocak ni */
          /*ya maap ga ngerti sistem nya gimana saya ini bang, masih pemula*/
          decoration: InputDecoration(
            labelText: 'Email',
            prefixIcon: Icon(Icons.email),
            floatingLabelStyle: TextStyle(color: Colors.blue),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue, width: 1.7),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            floatingLabelStyle: TextStyle(color: Colors.blue),
            labelText: 'Password',
            prefixIcon: Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue, width: 1.7),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: Text('Lupa password?', style: TextStyle(color: Colors.blue)),
        ),
        SizedBox(height: 25),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(400, 50),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),

            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,

            elevation: 5,
          ),
          onPressed: _isLoading
              ? null
              : () async {
                  // Validasi input kosong
                  setState(() {
                    _isLoading = true;
                  });

                  try {
                    final login = await loginUser(
                      _emailController.text,
                      _passwordController.text,
                    );

                    if (login['success'] == true) {
                      _showSnackBar('Login Berhasil !');

                      if (['user', 'admin', 'driver'].contains(login['role'])) {
                        // context.go('/${login['role']}');
                        context.go('/mainNavigationScreenOdoy');
                      } else {
                        _showSnackBar(
                          login['error'] ??
                              'login gagal. Email atau password salah',
                          isError: true,
                        );
                      }
                    } else if (login['success'] == false) {
                      _showSnackBar(login['error'] ?? 'Login gagal', isError: true);
                      print(login);
                    }
                  } catch (e) {
                    _showSnackBar('terjadi kesalahan: $e', isError: true);
                  } finally {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                },
          child: _isLoading
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text('Login'),
        ),
        SizedBox(height: 12),

        Text('Atau'),

        SizedBox(height: 12),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(400, 50),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),

            backgroundColor: Colors.white,
            foregroundColor: Colors.black,

            elevation: 5,
          ),
          onPressed: _isLoading
              ? null
              : () async {
                  setState(() {
                    _isLoading = true;
                  });

                  // HANDLE LOGIN GOOGLENYA DI SINI YA KEFIN
                  // KEPIN: NGGEH NO

                  final login = await LoginOauthUser();
                  if (login['success'] == true) {
                    (['user', 'admin', 'driver'].contains(login['role']))
                        // ? context.go('/${login['role']}')
                        ? context.go('/mainNavigationScreenOdoy')
                        : print('Unknown role');
                  } else {
                    print("Login Google gagal: ${login['error']}");
                  }
                },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/0/09/IOS_Google_icon.png',
                height: 24,
              ),
              SizedBox(width: 10),
              Text('Masuk dengan Google'),
            ],
          ),
        ),
      ],
    );
  }

  //================== INIIII FORM REGIST NYOOOO !!!====================
  Widget _buildRegisterForm() {
    return Column(
      children: [
        SizedBox(height: 28),
        TextField(
          controller: _registerUsernameController,
          decoration: InputDecoration(
            labelText: 'Username',
            prefixIcon: Icon(Icons.person),
            floatingLabelStyle: TextStyle(color: Colors.blue),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue, width: 1.7),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),

        SizedBox(height: 20),
        TextField(
          controller: _registerEmailController,
          decoration: InputDecoration(
            labelText: 'Email',
            prefixIcon: Icon(Icons.email),
            floatingLabelStyle: TextStyle(color: Colors.blue),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue, width: 1.7),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),

        SizedBox(height: 20),
        TextField(
          controller: _registerPasswordController,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            floatingLabelStyle: TextStyle(color: Colors.blue),
            labelText: 'Password',
            prefixIcon: Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue, width: 1.7),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),

        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.only(top: 4, left: 12, right: 12, bottom: 4),
          height: 50,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 197, 222, 244),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue),
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            'Setelah mendaftar, Anda akan menerima email verifikasi untuk mengaktifkan akun.',
            style: TextStyle(color: Colors.blue[900], fontSize: 12),
          ),
        ),
        SizedBox(height: 25),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(400, 50),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),

            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,

            elevation: 5,
          ),
          onPressed: _isLoading
              ? null
              : () async {
                  if (_registerUsernameController.text.isEmpty) {
                    _showSnackBar('username tidak boleh kosong', isError: true);
                    return;
                  }

                  if (_registerUsernameController.text.length < 3) {
                    _showSnackBar('username minimal 3 karakter', isError: true);
                    return;
                  }

                  if (_registerEmailController.text.isEmpty) {
                    _showSnackBar('Email tidak boleh kosong', isError: true);
                    return;
                  }

                  if (!_registerEmailController.text.contains('@') ||
                      !_registerEmailController.text.contains('.')) {
                    _showSnackBar('Format email tidak valid', isError: true);
                    return;
                  }

                  if (_registerPasswordController.text.isEmpty) {
                    _showSnackBar('Password tidak boleh kosong', isError: true);
                    return;
                  }

                  if (_registerPasswordController.text.length < 6) {
                    _showSnackBar('Password minimal 6 karakter', isError: true);
                    return;
                  }

                  setState(() {
                    _isLoading = true;
                  });

                  try {
                    final register = await signInUser(
                      username: _registerUsernameController.text,
                      email: _registerEmailController.text,
                      password: _registerPasswordController.text,
                    );

                    if (register['success'] == true) {
                      _showSnackBar(
                        'Register anda telah berhasil, silahkan lanjutkan ke login untuk masuk ke aplikasi !',
                      );

                      _registerUsernameController.clear();
                      _registerEmailController.clear();
                      _registerPasswordController.clear();

                      //kepin: ku tambahin ni biar waktu sudh daftar langusng balik ke login
                      setState(() {
                        isLogin = true;
                      });
                      // (['user', 'admin', 'driver'].contains(register['role']))
                      //     ? context.go('/${register['role']}')
                      //     : print('Unknown role');
                      print(register['success']);
                    } else {
                      _showSnackBar(
                        register['error'] ??
                            'Registrasi gagal. Silahkan Coba Lagi',
                        isError: true,
                      );
                      print(register['error']);
                    }
                  } catch (e) {
                    _showSnackBar('Terjadi Kesalahan: $e', isError: true);
                  } finally {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                },
          child: _isLoading
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.black,
                  ),
                )
              : Text('Daftar'),
        ),
      ],
    );
  }

  bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "LogiBox",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Solusi pengiriman barang terpercaya',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),

              //==================INIIII CARDD NYOOO====================
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 150),
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  width: double.infinity,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),

                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          //ini tab nyo ya kapin
                          //kepin: nggeh no
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isLogin = true;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 6),
                                    decoration: BoxDecoration(
                                      color: isLogin
                                          ? Colors.white
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      'masuk',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: isLogin
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isLogin = false;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 6),
                                    decoration: BoxDecoration(
                                      color: isLogin
                                          ? Colors.transparent
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      'daftar',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: isLogin
                                            ? FontWeight.normal
                                            : FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        isLogin ? _buildLoginForm() : _buildRegisterForm(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
