import 'package:flutter/material.dart';
import 'package:sawitcare_app/pages/management/yield/ServiceDetailPage.dart';



class ServicePage extends StatefulWidget {
  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  int _selectedIndex = 0; // Index of the currently selected tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Services'),
      ),
      body: Column(
  children: [
    Container(
      color: Colors.white, // Set background color of the navigation row
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          NavigationBox(
            text: 'Services',
            isSelected: _selectedIndex == 0,
            onPressed: () {
              setState(() {
                _selectedIndex = 0;
              });
            },
          ),
          NavigationBox(
            text: 'Active',
            isSelected: _selectedIndex == 1,
            onPressed: () {
              setState(() {
                _selectedIndex = 1;
              });
            },
          ),
          NavigationBox(
            text: 'Completed',
            isSelected: _selectedIndex == 2,
            onPressed: () {
              setState(() {
                _selectedIndex = 2;
              });
            },
          ),
        ],
      ),
    ),
    Expanded(
      child: Container(
        color: Colors.white, // Set background color of the expanded area
        child: _selectedIndex == 0
            ? ServicesTab()
            : _selectedIndex == 1
                ? ActiveTab()
                : HistoryTab(),
      ),
    ),
  ],
),

    );
  }
}



class ServicesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          SizedBox(height: 30),
          ServiceBox(
            image: AssetImage('assets/Hitachi.jpg'),
            title: 'Hitachi Rent',
            company: 'Ali Maju',
            location: 'Lahad Datu',
            price: 'Rm100',
          ),
          SizedBox(height: 40),
          ServiceBox(
            image: AssetImage('assets/slashing.jpg'),
            title: 'Slashing',
            company: 'Abu Ent',
            location: 'Tawau, Sabah',
            price: 'RM150',
          ),
          SizedBox(height: 40),
          ServiceBox(
            image: AssetImage('assets/angkut.jpg'),
            title: 'Sawit Transport',
            company: 'Jimmy Ent',
            location: 'Silabukan',
            price: 'RM50/tan',
          ),
        ],
      ),
    );
  }
}


class ServiceBox extends StatelessWidget {
  final ImageProvider image;
  final String title;
  final String company;
  final String location;
  final String price;

  const ServiceBox({
    required this.image,
    required this.title,
    required this.company,
    required this.location,
    required this.price,
  });


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to the detail page here
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ServiceDetailPage()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: const Color.fromARGB(255, 207, 207, 207)),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.3, // 1:3 ratio
              height: 150, // adjust height box
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                ),
                image: DecorationImage(
                  image: image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color:Color.fromARGB(255, 50, 73, 54) ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      'Company: $company',
                      style: TextStyle(fontSize: 13),
                    ),
                    Text(
                      'Location: $location',
                      style: TextStyle(fontSize: 13),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Price: $price',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color:Color.fromARGB(255, 50, 73, 54)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//Active Tab
class ActiveTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20.0),
      children: [
        SizedBox(height: 30),
        ActiveBox(
          title: 'Harvest',
          subscriptionDate: '2024-03-25',
          completionDate: '2024-04-10',
          status: 'In Progress',
        ),
        SizedBox(height: 30),
        ActiveBox(
          title: 'Slashing',
          subscriptionDate: '2024-03-20',
          completionDate: '2024-04-05',
          status: 'Confirmed',
        ),
        //can add more
      ],
    );
  }
}


class ActiveBox extends StatelessWidget {
  final String title;
  final String subscriptionDate;
  final String completionDate;
  final String status;

  const ActiveBox({
    required this.title,
    required this.subscriptionDate,
    required this.completionDate,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: const Color.fromARGB(255, 207, 207, 207)),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(35.0), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color:Color.fromARGB(255, 50, 73, 54)),
            ),
            SizedBox(height: 18),
            Text(
              'Subscription Date: $subscriptionDate',
              style: TextStyle(fontSize: 13),
            ),
            
            Text(
              'Expected Completion Date: $completionDate',
              style: TextStyle(fontSize: 13, ),
              
            ),
            SizedBox(height: 20),
           Align(
              alignment: Alignment.centerRight, 
              child: Text(
                status,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _getStatusColor(status),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending Confirmation':
        return Colors.orange;
      case 'Pending Payment':
        return Colors.red;
      case 'Confirmed':
        return Colors.green;
      case 'In Progress':
        return Colors.blue;
      default:
        return Colors.black;
    }
  }
}




//HIstory Tab 
class HistoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 30),
        HistoryBox(
          title: 'Hitachi Rental',
          subscriptionDate: '2024-03-21',
          completionDate: '2024-04-21',
          company: 'Ali Maju',
        ),
        SizedBox(height: 30),
        HistoryBox(
          title: 'Transport',
          subscriptionDate: '2024-03-15',
          completionDate: '2024-04-15',
          company: 'Khamid Enterprise',
          
        ),
      ],
    );
  }
}
class HistoryBox extends StatelessWidget {
  final String title;
  final String company;
  final String subscriptionDate;
  final String completionDate;

  const HistoryBox({
    required this.title,
    required this.company,
    required this.subscriptionDate,
    required this.completionDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 96, 133, 103)),
              ),
              SizedBox(height: 20),
              Text('Subscription Date: $subscriptionDate'),
              Text('Completion Date: $completionDate'),
              Text('Company: $company'),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: ElevatedButton(
              onPressed: () {
               
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>( Color.fromARGB(255, 73, 97, 77)),
              ),
              child: Text(
                'Book Again',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}










class NavigationButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const NavigationButton({
    required this.text,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: isSelected
            ? MaterialStateProperty.all<Color>(Color.fromARGB(255, 25, 79, 53))
            : MaterialStateProperty.all<Color>(Color.fromARGB(255, 199, 199, 199)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.white : Color.fromARGB(255, 25, 79, 53),
        ),
      ),
    );
  }
}


class NavigationBox extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const NavigationBox({
    required this.text,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? Color.fromARGB(255, 50, 73, 54) : Colors.white,
              width: isSelected ? 2.0 : 0.0, // Set width to 0 when not selected
            ),
          ),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? Color.fromARGB(255, 50, 73, 54) : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}


