import 'package:flutter/material.dart';

void main() => runApp(const DefaultTextStyleApp());

class DefaultTextStyleApp extends StatelessWidget {
  const DefaultTextStyleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.purple,
      ),
      home: const DefaultTextStyleExample(),
    );
  }
}

class DefaultTextStyleExample extends StatelessWidget {
  const DefaultTextStyleExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('How to Recycle?'),
          backgroundColor: Color.fromARGB(255, 156, 206, 182)),
      // Inherit MaterialApp text theme and override font size and font weight.

      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: Image.asset('assets/images/Recycleables.png'),
          ),
          
          Padding(
            padding: EdgeInsets.all(15),
            child: Container(
              child: RichText(text: TextSpan(
                text: '1. Use a bag or box to store all your recyclables',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: '\n\nThere is no need to sort the recyclables as they will be sorted centrally after collection.',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ],    
              ),
            ),
          ),
          
          Padding(
            padding: EdgeInsets.all(15),
            child: Container(
              child: RichText(text: TextSpan(
                text: '2. Know what can or cannot be recycled',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: '''\n\nCheck the blue bin label to confirm that your items are suitable for recycling.
Common materials that can be recycled include glass, paper, plastic and metal.
Single-use packaging such as disposable containers and cups often cannot be recycled as they are contaminated with food.
While food waste and e-waste can be recycled, they cannot be placed inside the blue recycling bins. Please refer to the respective waste stream pages to find out how they can recycled.
Separate reusables (clothes, shoes, stuffed toys) from recyclables. Reusables that are in good condition should be donated. You can give them away through online sites or donate them!
Do not throw trash or bulky items like furniture and renovation waste into blue recycling bins.
''',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ],    
              ),
            ),
          ),
          
          Padding(
            padding: EdgeInsets.all(15),
            child: Container(
              child: RichText(text: TextSpan(
                text: '3. Make sure your items are not contaminated with food or liquids',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: '''\n\nFor example, items such as shampoo/detergent bottles, canned/bottled drinks, cosmetic jars, jam jars need to be clean before they can be recycled.
If containers are wet, greasy or contain food, they will contaminate the rest of the items in the recycling bin. Give these containers a simple rinse before you put them into the blue bin.
''',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ],    
              ),
            ),
          ),
          
          Padding(
            padding: EdgeInsets.all(15),
            child: Container(
              child: RichText(text: TextSpan(
                text: '4. Recycle your items!',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: '\n\nUnsure whether something can be recyclable or not? Please contact NEA at 1800-CALL NEA (1800-2255 632)!',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
