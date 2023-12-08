import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final void Function(String, String, String, String, String) onSubmit;
  final String buttonText;
  final bool isSignup;
  const LoginForm(
      {super.key,
      required this.buttonText,
      required this.onSubmit,
      this.isSignup = false});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  String _fullname = '';
  String _phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            cursorColor: Colors.white,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
            onChanged: (value) => setState(() {
              _email = value.toString();
            }),
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              labelText: 'Email',
              hintStyle: TextStyle(color: Colors.white),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              fillColor: Colors.white.withOpacity(0.5),
              prefixIcon: Padding(
                padding: EdgeInsets.only(top: 15), // add padding to adjust icon
                child: Icon(
                  Icons.mail_outline_rounded,
                  color: Color.fromARGB(255, 24, 134, 81),
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          TextFormField(
            obscureText: true,
            cursorColor: Colors.white,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              } else if (value.length < 8) {
                return 'Password must be at least 8 characters long';
              }
              return null;
            },
            onChanged: (value) => setState(() {
              _password = value.toString();
            }),
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              labelText: 'Password',
              hintStyle: TextStyle(color: Colors.white),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              fillColor: Colors.white.withOpacity(0.5),
              prefixIcon: Padding(
                padding: EdgeInsets.only(top: 8), // add padding to adjust icon
                child: Icon(
                  Icons.lock_outline_rounded,
                  color: Color.fromARGB(255, 24, 134, 81),
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          if (widget.isSignup == true)
            Column(
              children: [
                TextFormField(
                  obscureText: true,
                  cursorColor: Colors.white,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your confirm password';
                    } else if (value.length < 8) {
                      return 'Password must be at least 8 characters long';
                    } else if (value != _password) {
                      return 'Confirm password must be the same with password';
                    }
                    return null;
                  },
                  onChanged: (value) => setState(() {
                    _confirmPassword = value.toString();
                  }),
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    filled: true,
                    labelText: 'Confirm password',
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    fillColor: Colors.white.withOpacity(0.5),
                    prefixIcon: Padding(
                      padding:
                          EdgeInsets.only(top: 8), // add padding to adjust icon
                      child: Icon(
                        Icons.lock_outline_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  cursorColor: Colors.white,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password again';
                    }
                    return null;
                  },
                  onChanged: (value) => setState(() {
                    _fullname = value.toString();
                  }),
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    filled: true,
                    labelText: 'Fullname',
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    fillColor: Colors.white.withOpacity(0.5),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(
                          top: 15), // add padding to adjust icon
                      child: Icon(
                        Icons.drive_file_rename_outline,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  cursorColor: Colors.white,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                  onChanged: (value) => setState(() {
                    _phoneNumber = value.toString();
                  }),
                  keyboardType:
                      TextInputType.number, // Set keyboard type to number
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    filled: true,
                    labelText: 'Phone number',
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    fillColor: Colors.white.withOpacity(0.5),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(
                          top: 15), // add padding to adjust icon
                      child: Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
              ],
            ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                if (widget.isSignup) {
                  widget.onSubmit(_email, _password, _confirmPassword,
                      _fullname, _phoneNumber);
                } else {
                  widget.onSubmit(_email, _password, '', '', '');
                }
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Color.fromARGB(255, 29, 112, 73);
                  }
                  return Color.fromARGB(255, 29, 112, 73);
                }),
              ),
              child: Text(widget.buttonText),
            ),
          )
        ],
      ),
    );
  }
}

bool isValidEmail(String email) {
  // Use RegExp to validate email address format
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(email);
}
