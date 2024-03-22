import 'package:flutter/material.dart';

class ServiceDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.32, // Adjust as needed
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Hitachi.jpg'), 
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.flag),
                        onPressed: () {
                          // Add your flagging logic here
                        },
                      ),
                      // Add any additional actions/icons here
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hitachi Rent', 
                      style: TextStyle(
                        color:  Color.fromARGB(255, 73, 97, 77),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Company: Ali Maju', 
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Location: Lahad Datu', 
                      style: TextStyle(fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Price: RM100', 
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Description:', // Description label
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Are you looking to optimize your palm oil replanting process? Look no further than our Hitachi rental service. With our top-of-the-line Hitachi equipment, you can streamline your replanting operations, ensuring efficiency and maximizing yield. Experienced operator provided as Add-on',
                      // Dummy description
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {
                // Add your request service logic here
              },
              child: Text('Request Service'),
            ),
          ),
        ],
      ),
    );
  }
}
