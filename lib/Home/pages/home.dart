import 'package:flutter/material.dart';
import '../../General/bottom_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Welcome Text
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 16.0, bottom: 16.0),
                child: Text(
                  'Welcome back!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Card 1: Your Points
            Card(
              color: Colors.green,
              margin: const EdgeInsets.symmetric(
                  horizontal: 16.0), // Add horizontal margin
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const ListTile(
                      title: Text(
                        'Your Points:',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Text(
                      '500', // Hardcoded points value
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                        height:
                            16), // Add some space between points and buttons
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, '/recycling'); // Navigate to '/recycling'
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust border radius
                        ),
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0), // Add padding left and right
                        minimumSize: const Size(
                            double.infinity, 48), // Text (label) color
                      ),
                      child: const Text(
                        'Get Hunting 🔎',
                        style: TextStyle(
                          fontSize: 15, // Adjust the font size
                          fontWeight: FontWeight.bold, // Make the text bold
                          color: Color.fromARGB(255, 27, 94,
                              32), // Set the text color to dark green
                        ),
                      ),
                    ),
                    const SizedBox(height: 8), // Add spacing between buttons
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, '/rewards'); // Navigate to '/rewards'
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust border radius
                        ),
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0), // Add padding left and right
                        minimumSize: const Size(
                            double.infinity, 48), // Text (label) color
                      ),
                      child: const Text(
                        'Redeem Rewards 🎁',
                        style: TextStyle(
                          fontSize: 15, // Adjust the font size
                          fontWeight: FontWeight.bold, // Make the text bold
                          color: Color.fromARGB(255, 27, 94,
                              32), // Set the text color to dark green
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Competitions Header
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Ongoing Competition:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),

            // Card 2: You Competition

            Card(
          color: Colors.green.shade100,
          margin: const EdgeInsets.symmetric(
              horizontal: 16.0), // Add horizontal margin
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const ListTile(
                  title: Text(
                    'SMU Recyclathon 2023', // Updated event name
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Text(
                  'Your rank: #5', // Updated user's rank
                  style: TextStyle(
                    fontSize: 18, // Adjusted font size for rank
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  'Ends on: 15 Oct 2023', // Updated event end date
                  style: TextStyle(
                    fontSize: 12, // Adjusted font size for date
                    color: Colors.grey, // Set text color to grey
                  ),
                ),
                const SizedBox(
                    height:
                        16), // Add some space before the button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, '/contests'); // Navigate to '/leaderboard' or the appropriate route
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust border radius
                    ),
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0), // Add padding left and right
                    minimumSize: const Size(
                        double.infinity, 48), // Button size
                  ),
                  child: const Text(
                    'View Leaderboard 🏆', // Button text
                    style: TextStyle(
                      fontSize: 15, // Adjust the font size
                      fontWeight: FontWeight.bold, // Make the text bold
                      color: Colors.white,// Set the text color to dark green
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

            // Card 3: More Information
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 16.0, left: 16.0, bottom: 10.0),
                  child: Text(
                    'More Information:',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListTile(
                    leading: Image.asset('assets/earth.png'),
                    title: const Text(
                      'What can I recycle?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Text(
                        'Find out more about the type of items you can recycle at the bins.'),
                    trailing: const Icon(Icons.arrow_forward),
                    // onTap: () {
                    //   Navigator.pushNamed(context, '/');
                    // },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
