import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildLogo(),
          SizedBox(height: 5.0),
          _buildTextSection(),
          SizedBox(height: 20.0),
          _buildContactSection(),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    // Replace 'YOUR_IMAGE_URL' with the actual URL of your logo
    String imageUrl =
        'https://branditechture.agency/brand-logos/wp-content/uploads/2022/09/UMT-Universiti-Malaysia-Terengganu-1024x755.png';

    return Center(
      child: Image.network(
        imageUrl,
        width: 150.0,
        height: 150.0,
      ),
    );
  }

  Widget _buildTextSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Welcome to Project Monitoring App!',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          'We are a team dedicated to helping you organize your project management efficiently. '
          'Our app, ProjectPal allows you to create, edit, and manage your project schedule seamlessly.',
          style: TextStyle(fontSize: 16.0),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Us',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.0),
        ListTile(
          leading: Icon(Icons.email),
          title: Text('s63190@ocean.umt.edu.my'),
          onTap: () {
            // Handle email tapping
          },
        ),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text('+601154157725'),
          onTap: () {
            // Handle phone number tapping
          },
        ),
      ],
    );
  }
}
