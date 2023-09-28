import 'package:flutter/material.dart';
import '../../General/bottom_bar.dart';

void main() {
  runApp(const Popup());
}

class Popup extends StatelessWidget {
  const Popup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pop Up'),
      ),
      body: const Center(
        child: Text('Pop Up'),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Add Item'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Item Name',
                      ),
                      onChanged: (value) {
                        // Do something with the user's input
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Quantity',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        // Do something with the user's input
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Do something when the green button is pressed
                          },
                          style:
                              ElevatedButton.styleFrom(primary: Colors.green),
                          child: const Text('Add'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Do something when the red button is pressed
                          },
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          child: const Text('Cancel'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: const Text('Add Item'),
      ),
    );
  }
}
