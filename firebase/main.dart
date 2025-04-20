import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
 runApp(RestaurantBookingApp());
}


class RestaurantBookingApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     title: 'Table Booking',
     theme: ThemeData(primarySwatch: Colors.teal),
     home: BookingFormPage(),
     debugShowCheckedModeBanner: false,
   );
 }
}


class BookingFormPage extends StatefulWidget {
 @override
 _BookingFormPageState createState() => _BookingFormPageState();
}


class _BookingFormPageState extends State<BookingFormPage> {
 final _formKey = GlobalKey<FormState>();


 final TextEditingController _nameController = TextEditingController();
 final TextEditingController _emailController = TextEditingController();
 final TextEditingController _phoneController = TextEditingController();
 final TextEditingController _guestsController = TextEditingController();


 DateTime? _selectedDate;
 TimeOfDay? _selectedTime;


 Future<void> _submitForm() async {
   if (_formKey.currentState!.validate()) {
     try {
       await FirebaseFirestore.instance.collection('table_bookings').add({
         'name': _nameController.text.trim(),
         'email': _emailController.text.trim(),
         'phone': _phoneController.text.trim(),
         'guests': int.parse(_guestsController.text),
         'booking_date': _selectedDate?.toIso8601String(),
         'booking_time': _selectedTime?.format(context),
         'timestamp': FieldValue.serverTimestamp(),
       });


       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('Booking Successful!')),
       );


       _formKey.currentState!.reset();
       setState(() {
         _selectedDate = null;
         _selectedTime = null;
       });
     } catch (e) {
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('Error: $e')),
       );
     }
   }
 }


 Future<void> _pickDate() async {
   final DateTime? picked = await showDatePicker(
     context: context,
     initialDate: DateTime.now().add(Duration(days: 1)),
     firstDate: DateTime.now(),
     lastDate: DateTime.now().add(Duration(days: 365)),
   );
   if (picked != null) setState(() => _selectedDate = picked);
 }


 Future<void> _pickTime() async {
   final TimeOfDay? picked = await showTimePicker(
     context: context,
     initialTime: TimeOfDay.now(),
   );
   if (picked != null) setState(() => _selectedTime = picked);
 }


 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(title: Text('Restaurant Table Booking')),
     body: Padding(
       padding: const EdgeInsets.all(16.0),
       child: Form(
         key: _formKey,
         child: ListView(
           children: [
             _buildTextField(_nameController, 'Full Name', TextInputType.name),
             _buildTextField(_emailController, 'Email', TextInputType.emailAddress),
             _buildTextField(_phoneController, 'Phone', TextInputType.phone),
             _buildTextField(_guestsController, 'Number of Guests', TextInputType.number),


             SizedBox(height: 16),
             ListTile(
               title: Text(_selectedDate == null
                   ? 'Select Booking Date'
                   : 'Date: ${_selectedDate!.toLocal()}'.split(' ')[0]),
               trailing: Icon(Icons.calendar_today),
               onTap: _pickDate,
             ),
             ListTile(
               title: Text(_selectedTime == null
                   ? 'Select Booking Time'
                   : 'Time: ${_selectedTime!.format(context)}'),
               trailing: Icon(Icons.access_time),
               onTap: _pickTime,
             ),
             SizedBox(height: 20),
             ElevatedButton(
               onPressed: _submitForm,
               child: Text('Submit Booking'),
             ),
           ],
         ),
       ),
     ),
   );
 }


 Widget _buildTextField(TextEditingController controller, String label, TextInputType inputType) {
   return Padding(
     padding: const EdgeInsets.only(bottom: 12.0),
     child: TextFormField(
       controller: controller,
       keyboardType: inputType,
       decoration: InputDecoration(
         labelText: label,
         border: OutlineInputBorder(),
       ),
       validator: (value) => value == null || value.isEmpty ? 'Enter $label' : null,
     ),
   );
 }
}


// 1.create firebase project and then add application id to register which will be in gradle file. Then register the project the will get select android will get the steps, plugins and dependencies which will add in gradle and app gradle files.
//  apply plugin: 'com.google.gms.google-services'
//  Add this at the end in app gradle 

// id "org.jetbrains.kotlin.android" version "2.1.0" apply false

// This for kotlin version error 

// Add google services json file in android/app/ 
// Pubspec.yml: add under dependencies section 
// firebase_core: ^2.10.0
// cloud_firestore: ^4.9.0

