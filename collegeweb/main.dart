import 'package:flutter/material.dart';


void main() => runApp(SfitWebsiteApp());


class SfitWebsiteApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     title: 'St. Francis Institute of Technology',
     debugShowCheckedModeBanner: false,
     theme: ThemeData(
       primarySwatch: Colors.indigo,
       fontFamily: 'Roboto',
     ),
     home: SfitHomePage(),
   );
 }
}


class SfitHomePage extends StatelessWidget {
 final List<Tab> myTabs = [
   Tab(text: 'About Us'),
   Tab(text: 'Academics'),
   Tab(text: 'Library'),
   Tab(text: 'Placements'),
   Tab(text: 'Admissions'),
 ];


 final Map<String, String> tabContent = {
   'About Us': 'SFIT is one of Mumbai’s top engineering colleges offering quality education and holistic development.',
   'Academics': 'Explore our undergraduate and postgraduate programs in Engineering.',
   'Library': 'Our well-stocked digital and physical library is open to all students and staff.',
   'Placements': 'Top companies recruit from SFIT every year. Check out our placement stats!',
   'Admissions': 'Join SFIT by applying through the official admissions process.',
 };


 @override
 Widget build(BuildContext context) {
   return DefaultTabController(
     length: myTabs.length,
     child: Scaffold(
       appBar: AppBar(
         title: Row(
           children: [
             Image.asset(
               'assets/sfit_logo.png',
               height: 40,
             ),
             SizedBox(width: 10),
             Flexible(
               child: Text(
                 'St. Francis Institute of Technology, Borivali',
                 style: TextStyle(fontSize: 18),
               ),
             ),
           ],
         ),
         bottom: TabBar(
           isScrollable: true,
           tabs: myTabs,
           indicatorColor: Colors.white,
         ),
       ),
       body: Column(
         children: [
           // Announcement Section
           Container(
             width: double.infinity,
             color: Colors.orange[100],
             padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
             child: Text(
               '📢 Admissions Open for 2025 Batch! Apply Now via the Admissions tab.',
               style: TextStyle(fontSize: 16, color: Colors.deepOrange),
               textAlign: TextAlign.center,
             ),
           ),
           Expanded(
             child: TabBarView(
               children: myTabs.map((Tab tab) {
                 final content = tabContent[tab.text!] ?? '';
                 return Padding(
                   padding: const EdgeInsets.all(16.0),
                   child: Section(title: tab.text!, content: content),
                 );
               }).toList(),
             ),
           ),
         ],
       ),
     ),
   );
 }
}


class Section extends StatelessWidget {
 final String title;
 final String content;


 const Section({required this.title, required this.content});


 @override
 Widget build(BuildContext context) {
   return ListView(
     children: [
       Text(
         title,
         style:
         TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.indigo),
       ),
       SizedBox(height: 10),
       Text(
         content,
         style: TextStyle(fontSize: 16),
       ),
     ],
   );
 }
}
