import 'package:flutter/material.dart';

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
          RecycleTip(
            title: '1. Use a bag or box to store all your recyclables',
            description:
                '\n\nThere is no need to sort the recyclables as they will be sorted centrally after collection.',
          ),
          RecycleTip(
              title: '2. Know what can or cannot be recycled',
              description:
                  '''\n\nCheck the blue bin label to confirm that your items are suitable for recycling.
Common materials that can be recycled include glass, paper, plastic and metal.
Single-use packaging such as disposable containers and cups often cannot be recycled as they are contaminated with food.
While food waste and e-waste can be recycled, they cannot be placed inside the blue recycling bins. Please refer to the respective waste stream pages to find out how they can recycled.
Separate reusables (clothes, shoes, stuffed toys) from recyclables. Reusables that are in good condition should be donated. You can give them away through online sites or donate them!
Do not throw trash or bulky items like furniture and renovation waste into blue recycling bins.
'''),
          RecycleTip(
            title:
                '3. Make sure your items are not contaminated with food or liquids',
            description:
                '''\n\nFor example, items such as shampoo/detergent bottles, canned/bottled drinks, cosmetic jars, jam jars need to be clean before they can be recycled.
If containers are wet, greasy or contain food, they will contaminate the rest of the items in the recycling bin. Give these containers a simple rinse before you put them into the blue bin.
''',
          ),
          RecycleTip(
            title: '4. Recycle your items!',
            description:
                '\n\nUnsure whether something can be recyclable or not? Please contact NEA at 1800-CALL NEA (1800-2255 632)!',
          )
        ],
      ),
    );
  }
}

class RecycleTip extends StatelessWidget {
  final String title;
  final String description;

  const RecycleTip({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Container(
        child: RichText(
          text: TextSpan(
            text: title,
            style: TextStyle(
              color: Color.fromRGBO(1, 1, 1, 1),
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: description,
                style: TextStyle(
                  color: Color.fromRGBO(1, 1, 1, 1),
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
