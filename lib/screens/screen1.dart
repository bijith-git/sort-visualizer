import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sort_visualizer/screens/sort_visualizer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<int> generateRandomList(int length) {
    Random random = Random();
    List<int> randomList =
        List.generate(length, (index) => random.nextInt(100));
    return randomList;
  }

  bool enableButton = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController elementController = TextEditingController();
  @override
  void dispose() {
    elementController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(borderRadius: BorderRadius.circular(10));
    print(generateRandomList(50));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 3,
        title: Text(
          "Sorting visualizer",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: formKey,
        onChanged: () => setState(() {
          enableButton = formKey.currentState!.validate();
        }),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "This is a simple flutter project to under \nand visualize different sorting algorithms",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Text(
                "Number of elements to sort",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 70,
                child: TextFormField(
                  controller: elementController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter a value";
                    }
                    if (int.parse(value) > 1000) {
                      return "Elements should be less than 1000";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      constraints:
                          const BoxConstraints(maxWidth: 300, maxHeight: 50),
                      border: border,
                      hintText: "Enter you number",
                      enabledBorder: border,
                      focusedBorder: border),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: enableButton
                      ? () {
                          List<int> list = generateRandomList(
                              int.parse(elementController.text));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SortVisualizer(unsortedList: list),
                            ),
                          );
                        }
                      : null,
                  child: Text("Sort",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold))),
            ],
          ),
        ),
      ),
    );
  }
}
