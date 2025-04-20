// Main.dart

import 'package:flutter/material.dart';
import 'login_page.dart';
import 'registration_page.dart';


void main() {
 runApp(const ClinicalERPApp());
}


class ClinicalERPApp extends StatelessWidget {
 const ClinicalERPApp({super.key});


 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     title: 'Clinical ERP',
     theme: ThemeData(
       primarySwatch: Colors.indigo,
     ),
     debugShowCheckedModeBanner: false,
     initialRoute: '/login',
     routes: {
       '/login': (context) => const LoginPage(),
       '/register': (context) => const RegistrationPage(),
     },
   );
 }
}



// Login_page.dart

import 'package:flutter/material.dart';
import 'user_store.dart';


class LoginPage extends StatefulWidget {
 const LoginPage({super.key});


 @override
 State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
 final _formKey = GlobalKey<FormState>();
 final _emailController = TextEditingController();
 final _passwordController = TextEditingController();


 void _login() {
   if (_formKey.currentState!.validate()) {
     if (_emailController.text == UserStore.userEmail &&
         _passwordController.text == UserStore.userPassword) {
       ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('Logged in successfully!')),
       );
     } else {
       ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('Invalid credentials!')),
       );
     }
   }
 }


 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(title: const Text('Login')),
     body: Padding(
       padding: const EdgeInsets.all(20),
       child: Form(
         key: _formKey,
         child: ListView(
           children: [
             const Text(
               'Welcome Back!',
               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
             ),
             const SizedBox(height: 20),
             TextFormField(
               controller: _emailController,
               decoration: const InputDecoration(labelText: 'Email'),
               validator: (value) =>
               value!.isEmpty ? 'Enter your email' : null,
             ),
             const SizedBox(height: 10),
             TextFormField(
               controller: _passwordController,
               obscureText: true,
               decoration: const InputDecoration(labelText: 'Password'),
               validator: (value) =>
               value!.isEmpty ? 'Enter your password' : null,
             ),
             const SizedBox(height: 20),
             ElevatedButton(
               onPressed: _login,
               child: const Text('Login'),
             ),
             TextButton(
               onPressed: () {
                 Navigator.pushReplacementNamed(context, '/register');
               },
               child: const Text("Don't have an account? Register"),
             ),
           ],
         ),
       ),
     ),
   );
 }
}

// Registration_page.dart

import 'package:flutter/material.dart';
import 'user_store.dart';


class RegistrationPage extends StatefulWidget {
 const RegistrationPage({super.key});


 @override
 State<RegistrationPage> createState() => _RegistrationPageState();
}


class _RegistrationPageState extends State<RegistrationPage> {
 final _formKey = GlobalKey<FormState>();
 final _nameController = TextEditingController();
 final _emailController = TextEditingController();
 final _passwordController = TextEditingController();
 final _confirmController = TextEditingController();


 void _register() {
   if (_formKey.currentState!.validate()) {
     // Store user
     UserStore.userEmail = _emailController.text;
     UserStore.userPassword = _passwordController.text;


     ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(content: Text('Registered successfully!')),
     );


     Navigator.pushReplacementNamed(context, '/login');
   }
 }


 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(title: const Text('Register')),
     body: Padding(
       padding: const EdgeInsets.all(20),
       child: Form(
         key: _formKey,
         child: ListView(
           children: [
             const Text(
               'Create an Account',
               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
             ),
             const SizedBox(height: 20),
             TextFormField(
               controller: _nameController,
               decoration: const InputDecoration(labelText: 'Full Name'),
               validator: (value) =>
               value!.isEmpty ? 'Please enter your name' : null,
             ),
             const SizedBox(height: 10),
             TextFormField(
               controller: _emailController,
               decoration: const InputDecoration(labelText: 'Email'),
               validator: (value) {
                 if (value!.isEmpty) return 'Please enter email';
                 if (!value.contains('@')) return 'Enter valid email';
                 return null;
               },
             ),
             const SizedBox(height: 10),
             TextFormField(
               controller: _passwordController,
               decoration: const InputDecoration(labelText: 'Password'),
               obscureText: true,
               validator: (value) =>
               value!.length < 6 ? 'Minimum 6 characters' : null,
             ),
             const SizedBox(height: 10),
             TextFormField(
               controller: _confirmController,
               decoration:
               const InputDecoration(labelText: 'Confirm Password'),
               obscureText: true,
               validator: (value) =>
               value != _passwordController.text ? 'Passwords do not match' : null,
             ),
             const SizedBox(height: 20),
             ElevatedButton(
               onPressed: _register,
               child: const Text('Register'),
             ),
             TextButton(
               onPressed: () {
                 Navigator.pushReplacementNamed(context, '/login');
               },
               child: const Text('Already have an account? Login'),
             ),
           ],
         ),
       ),
     ),
   );
 }
}

// User_store.dart
class UserStore {
 static String? userEmail;
 static String? userPassword;
}

