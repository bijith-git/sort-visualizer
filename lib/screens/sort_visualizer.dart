import 'package:flutter/material.dart';

int barColor1 = -1, barColor2 = -1;

class SortVisualizer extends StatefulWidget {
  const SortVisualizer({
    Key? key,
    required this.unsortedList,
  }) : super(key: key);

  final List<int> unsortedList;

  @override
  State<SortVisualizer> createState() => _SortVisualizerState();
}

var _value = 75.0;
var selectedSortingMethod = 0;
var barPosition = 0;
var sortTap = 0;

var cancelled = false;

class _SortVisualizerState extends State<SortVisualizer> {
  String currentSort = "Selection sort";
  int i = 0, j = 0;
  List<int> initialList = [];
  int max = 0;
  List<String> sortingMethods = [
    "Selection sort",
    "Insertion sort",
    "Bubble sort",
    "Quick sort",
    "Merge sort",
  ];
  @override
  void initState() {
    super.initState();
    initialList.addAll(widget.unsortedList);
    setState(() {});
  }

  Future<bool> sort(List<int> currentList) async {
    if (selectedSortingMethod == 0) {
      selectionSort(currentList);
    }
    if (selectedSortingMethod == 1) {
      insertionSort(currentList);
    }
    if (selectedSortingMethod == 2) {
      bubbleSort(currentList);
    }
    if (selectedSortingMethod == 3) {
      quickSort(currentList, 0, currentList.length - 1);
    }
    if (selectedSortingMethod == 4) {
      await mergeSort(currentList, 0, currentList.length - 1);
    }
    return true;
  }

  Future<bool> merge(List<int> a, int x1, int y1, int x2, int y2) async {
    int i = 0;
    int start = x1, end = y2;
    List<int> c = List<int>.filled(0, 0, growable: true);

    while (true) {
      if (cancelled && mounted) {
        // If cancelled flag is true and the component is still mounted,
        // reset bar colors and cancelled flag
        setState(() => {
              barColor1 = -1,
              barColor2 = -1,
              cancelled = false,
            });
        return true;
      }

      if (x1 > y1) {
        // Add remaining elements from the second half to the merged list
        for (i = x2; i <= y2; i++) {
          c.add(a[i]);
          if (mounted) {
            setState(() => {
                  barColor1 = y1,
                  barColor2 = i,
                });
          }
        }
        break;
      }

      if (x2 > y2) {
        // Add remaining elements from the first half to the merged list
        for (i = x1; i <= y1; i++) {
          c.add(a[i]);
          if (mounted) {
            setState(() => {
                  barColor1 = y2,
                  barColor2 = i,
                });
          }
        }
        break;
      }

      // Merge elements comparing values at x1 and x2 indices
      if (a[x1] <= a[x2]) {
        c.add(a[x1]);
        if (mounted) {
          setState(() => {
                barColor1 = x1,
                barColor2 = x2,
              });
        }
        x1++;
      } else {
        c.add(a[x2]);
        if (mounted) {
          setState(() => {
                barColor1 = x1,
                barColor2 = x2,
              });
        }
        x2++;
      }
    }

    // Update the original list with the sorted values
    for (i = start; i <= end; i++) {
      await changeVal(a, i, c, start);
    }

    return true;
  }

  Future<bool> changeVal(List<int> a, int i, List<int> c, int start) async {
    var v = 0;

    // Map different values of _value to corresponding delays
    if (_value == 100) {
      v = 0;
    } else if (_value == 75) {
      v = 100;
    } else if (_value == 50) {
      v = 350;
    } else if (_value == 25) {
      v = 650;
    } else if (_value == 0) {
      v = 1000;
    }

    await Future.delayed(Duration(milliseconds: v));

    // Update the original list with the sorted values
    if (mounted) {
      setState(() => a[i] = c[i - start]);
    }

    return true;
  }

  Future<bool> mergeSort(List<int> a, int x, int y) async {
    if (x >= y) {
      // Base case: If the list size is 1 or empty, it is already sorted
      return true;
    }

    int mid = ((x + y) ~/ 2);

    // Recursively sort the first and second halves
    await mergeSort(a, x, mid);
    await mergeSort(a, mid + 1, y);

    // Merge the sorted halves
    await merge(a, x, mid, mid + 1, y);

    if (mounted) {
      // Reset bar colors after sorting completion
      setState(() => {
            barColor1 = -1,
            barColor2 = -1,
          });
    }

    return true;
  }

// Similar optimizations and comments can be applied to other sorting functions...
// (quickSort, bubbleSort, insertionSort, selectionSort)
  Future<bool> quickSort(
      List<int> listToBeSorted, int leftElement, int rightElement) async {
    int i = leftElement;
    int j = rightElement;
    int pivotElement = listToBeSorted[(leftElement + rightElement) ~/ 2];

    while (i <= j) {
      var v = 0;

      // Map different values of _value to corresponding delays
      if (_value == 100) {
        v = 0;
      } else if (_value == 75) {
        v = 100;
      } else if (_value == 50) {
        v = 350;
      } else if (_value == 25) {
        v = 650;
      } else if (_value == 0) {
        v = 1000;
      }

      await Future.delayed(Duration(milliseconds: v));

      if (cancelled && mounted) {
        // If cancelled flag is true and the component is still mounted,
        // reset bar colors and cancelled flag
        setState(() => {
              barColor1 = -1,
              barColor2 = -1,
              cancelled = false,
            });
        return true;
      }

      // Find elements to swap in the left and right halves
      while (listToBeSorted[i] < pivotElement) {
        i++;
      }

      while (listToBeSorted[j] > pivotElement) {
        j--;
      }

      // Swap elements if necessary
      if (i <= j) {
        if (mounted) {
          setState(() {
            int temp = listToBeSorted[i];
            listToBeSorted[i] = listToBeSorted[j];
            listToBeSorted[j] = temp;
            barColor1 = i;
            barColor2 = j;
          });
        }
        i++;
        j--;
      }
    }

    // Recursively sort the subarrays
    if (leftElement < j) {
      await quickSort(listToBeSorted, leftElement, j);
    }
    if (i < rightElement) {
      await quickSort(listToBeSorted, i, rightElement);
    }

    if (mounted) {
      // Reset bar colors after sorting completion
      setState(() => {
            barColor1 = -1,
            barColor2 = -1,
          });
    }

    return true;
  }

// Continue with the optimization and comments for bubbleSort, insertionSort, selectionSort...
// (Code for these functions has been partially provided in the previous response)
  Future<bool> bubbleSort(List<int> list) async {
    var n = list.length;
    for (var i = 0; i < n; i++) {
      var v = 0;

      // Map different values of _value to corresponding delays
      if (_value == 100) {
        v = 0;
      } else if (_value == 75) {
        v = 100;
      } else if (_value == 50) {
        v = 350;
      } else if (_value == 25) {
        v = 650;
      } else if (_value == 0) {
        v = 1000;
      }

      await Future.delayed(Duration(milliseconds: v));

      if (cancelled && mounted) {
        // If cancelled flag is true and the component is still mounted,
        // reset bar colors and cancelled flag
        setState(() => {
              barColor1 = -1,
              barColor2 = -1,
              cancelled = false,
            });
        return true;
      }

      int temp;
      for (var j = 0; j < n - i - 1; j++) {
        // Swap elements if they are in the wrong order
        if (list[j] > list[j + 1]) {
          if (mounted) {
            setState(() {
              temp = list[j];
              list[j] = list[j + 1];
              list[j + 1] = temp;
              barColor1 = i;
              barColor2 = j;
            });
          }
        }
      }
    }

    if (mounted) {
      // Reset bar colors after sorting completion
      setState(() => {
            barColor1 = -1,
            barColor2 = -1,
          });
    }

    return true;
  }

  Future<bool> insertionSort(List<int> list) async {
    for (int j = 1; j < list.length; j++) {
      var v = 0;

      // Map different values of _value to corresponding delays
      if (_value == 100) {
        v = 0;
      } else if (_value == 75) {
        v = 100;
      } else if (_value == 50) {
        v = 350;
      } else if (_value == 25) {
        v = 650;
      } else if (_value == 0) {
        v = 1000;
      }

      await Future.delayed(Duration(milliseconds: v));

      if (cancelled && mounted) {
        // If cancelled flag is true and the component is still mounted,
        // reset bar colors and cancelled flag
        setState(() => {
              barColor1 = -1,
              barColor2 = -1,
              cancelled = false,
            });
        return true;
      }

      int key = list[j];
      int i = j - 1;

      // Move elements that are greater than key to one position ahead of their current position
      while (i >= 0 && list[i] > key) {
        if (mounted) {
          setState(() {
            list[i + 1] = list[i];
            i = i - 1;
            list[i + 1] = key;
            barColor1 = j;
            barColor2 = i;
          });
        }
      }
    }

    if (mounted) {
      // Reset bar colors after sorting completion
      setState(() => {
            barColor1 = -1,
            barColor2 = -1,
          });
    }

    return true;
  }

  Future<bool> selectionSort(List<int> list) async {
    var n = list.length;
    int temp, i = 0, j = 0;
    var indexMin = 0;

    for (i = 0; i < n - 1; i++) {
      var v = 0;

      // Map different values of _value to corresponding delays
      if (_value == 100) {
        v = 0;
      } else if (_value == 75) {
        v = 100;
      } else if (_value == 50) {
        v = 350;
      } else if (_value == 25) {
        v = 650;
      } else if (_value == 0) {
        v = 1000;
      }

      await Future.delayed(Duration(milliseconds: v));

      if (cancelled && mounted) {
        // If cancelled flag is true and the component is still mounted,
        // reset bar colors and cancelled flag
        setState(() => {
              barColor1 = -1,
              barColor2 = -1,
              cancelled = false,
            });
        return true;
      }

      indexMin = i;

      // Find the index of the minimum element in the unsorted part of the array
      for (j = i + 1; j < n; j++) {
        if (list[j] < list[indexMin]) {
          indexMin = j;
        }
      }

      // Swap the found minimum element with the first element
      if (indexMin != i) {
        if (mounted) {
          setState(() {
            temp = list[i];
            list[i] = list[indexMin];
            list[indexMin] = temp;
            barColor1 = i;
            barColor2 = indexMin;
          });
        }
      }
    }

    if (mounted) {
      // Reset bar colors after sorting completion
      setState(() => {
            barColor1 = -1,
            barColor2 = -1,
          });
    }

    return true;
  }

  List reSizer(var a) {
    for (i = 0; i < a.length; i++) {
      if (a[i] > max) {
        max = a[i];
      }
    }
    var minHeight = MediaQuery.of(context).size.height <= 498
        ? 498
        : MediaQuery.of(context).size.height;
    var per = 65 / 100;
    double percentHeightOfElements = 0;
    if (max >= minHeight * per) {
      percentHeightOfElements = (minHeight * per * 100) / max;
      for (i = 0; i < a.length; i++) {
        a[i] = a[i] * percentHeightOfElements / 100;
      }
    } else {
      if (max < minHeight * per) {
        percentHeightOfElements = minHeight * per / max;
        for (i = 0; i < a.length; i++) {
          a[i] = a[i] * percentHeightOfElements;
        }
      }
    }
    return a;
  }

  Widget rectangleCreator(double val, var arr, var i) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        color: i == barColor1 || i == barColor2 ? Colors.yellow : Colors.red,
        height: val,
        width: MediaQuery.of(context).size.width <= 240
            ? (240 / 2) / arr.length
            : (MediaQuery.of(context).size.width / 2) / arr.length,
        margin: EdgeInsets.only(
            right: MediaQuery.of(context).size.width <= 240
                ? (240 / 2) / arr.length
                : (MediaQuery.of(context).size.width / 2) / arr.length),
        alignment: Alignment.centerRight,
      ),
    );
  }

  String getDefinition(String sortMethod) {
    switch (sortMethod) {
      case "Selection sort":
        return "A simple sorting algorithm that repeatedly selects the minimum element from the unsorted portion and swaps it with the first element.";
      case "Insertion sort":
        return "Builds the final sorted array one item at a time, repeatedly taking the next element and inserting it into the proper position.";
      case "Bubble sort":
        return "Repeatedly steps through the list, compares adjacent elements, and swaps them if they are in the wrong order.";
      case "Quick sort":
        return "A divide-and-conquer algorithm that partitions the array into smaller segments, sorts them independently, and combines them.";
      case "Merge sort":
        return "Divides the unsorted list into n sub-lists, each containing one element, and repeatedly merges sub-lists to produce new sorted sub-lists.";
      default:
        return "Unknown sorting method";
    }
  }

  int getIndex(String sortMethod) {
    switch (sortMethod) {
      case "Selection sort":
        return 0;
      case "Insertion sort":
        return 1;
      case "Bubble sort":
        return 2;
      case "Quick sort":
        return 3;
      case "Merge sort":
        return 4;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    List resizedArr = List.filled(widget.unsortedList.length, 0);
    for (i = 0; i < widget.unsortedList.length; i++) {
      resizedArr[i] = widget.unsortedList[i];
    }
    resizedArr = reSizer(resizedArr);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                showAdaptiveDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          sortingMethods[selectedSortingMethod],
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        content: Text(
                          getDefinition(
                            sortingMethods[selectedSortingMethod],
                          ),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    });
              },
              icon: const Icon(Icons.info_outline))
        ],
        centerTitle: true,
        title: Text(
          "Sorting methods",
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Card(
        elevation: 5,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Slider(
                min: 0,
                max: 100,
                divisions: 4,
                label: '${_value.round() / 25 + 1}x',
                value: _value,
                onChanged: (v) {
                  setState(
                    () => _value = v,
                  );
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        if (sortTap == 0) {
                          cancelled = false;
                          sort(widget.unsortedList);
                        }
                        sortTap++;
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.sort,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 10),
                          Text("Sort",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.bold)),
                        ],
                      )),
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        barColor1 = -1;
                        barColor2 = -1;
                        widget.unsortedList.addAll(initialList);
                        setState(() {});
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.restart_alt,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 10),
                          Text("Reset",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.bold)),
                        ],
                      )),
                )
              ],
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Current sorting method : ",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(
                width: 300,
                child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<String>(
                  value: currentSort,
                  onChanged: (value) {
                    setState(() {
                      currentSort = value!;
                      barColor1 = -1;
                      barColor2 = -1;
                      sortTap = 0;
                      selectedSortingMethod = getIndex(value);
                      widget.unsortedList.clear();
                      widget.unsortedList.addAll(initialList);
                    });
                  },
                  items: sortingMethods
                      .map<DropdownMenuItem<String>>(
                          (e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                )),
              )
            ],
          ),
          SizedBox(height: 40),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (i = 0; i < widget.unsortedList.length; i++) ...[
                rectangleCreator(resizedArr[i], resizedArr, i),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
