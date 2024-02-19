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

  Future<bool> sort(List<int> intList) async {
    print("Sorting");
    if (selectedSortingMethod == 0) {
      selectionSort(intList);
    }
    if (selectedSortingMethod == 1) {
      insertionSort(intList);
    }
    if (selectedSortingMethod == 2) {
      bubbleSort(intList);
    }
    if (selectedSortingMethod == 3) {
      quickSort(intList, 0, intList.length - 1);
    }
    if (selectedSortingMethod == 4) {
      await mergeSort(intList, 0, intList.length - 1);
    }
    return true;
  }

  Future<bool> merge(var a, var x1, var y1, var x2, var y2) async {
    int i = 0, j = 0;
    int start = x1, end = y2;
    List<int> c = List<int>.filled(0, 0, growable: true);
    List<int> indexCont = List<int>.filled(0, 0, growable: true);
    while (true) {
      if (cancelled && mounted) {
        setState(() => {
              barColor1 = -1,
              barColor2 = -1,
              cancelled = false,
            });
        return true;
      }
      if (x1 > y1) {
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
    for (i = start; i <= end; i++) {
      await changeVal(a, i, c, start);
    }
    return true;
  }

  Future<bool> changeVal(var a, var i, var c, var start) async {
    var v = 0;
    if (_value == 100) {
      v = 0;
    }
    if (_value == 75) {
      v = 100;
    }
    if (_value == 50) {
      v = 350;
    }
    if (_value == 25) {
      v = 650;
    }
    if (_value == 0) {
      v = 1000;
    }
    await Future.delayed(Duration(milliseconds: v));
    if (mounted) {
      setState(
        () => a[i] = c[i - start],
      );
    }
    return true;
  }

  Future<bool> mergeSort(var a, var x, var y) async {
    if (x >= y) {
      return true;
    }
    int mid = ((x + y) / 2).toInt();
    await mergeSort(a, x, mid);
    await mergeSort(a, mid + 1, y);
    await merge(a, x, mid, mid + 1, y);
    if (mounted) {
      setState(() => {
            barColor1 = -1,
            barColor2 = -1,
          });
    }
    return true;
  }

  Future<bool> quickSort(
      listtobesort, int leftelement, int rightelement) async {
    int i = leftelement;
    int j = rightelement;
    int pivotelement = listtobesort[(leftelement + rightelement) ~/ 2];

    while (i <= j) {
      var v = 0;
      if (_value == 100) {
        v = 0;
      }
      if (_value == 75) {
        v = 100;
      }
      if (_value == 50) {
        v = 350;
      }
      if (_value == 25) {
        v = 650;
      }
      if (_value == 0) {
        v = 1000;
      }
      await Future.delayed(Duration(milliseconds: v));
      if (cancelled && mounted) {
        setState(() => {
              barColor1 = -1,
              barColor2 = -1,
              cancelled = false,
            });
        return true;
      }
      while (listtobesort[i] < pivotelement) {
        i++;
      }

      while (listtobesort[j] > pivotelement) {
        j--;
      }
      int objtemp;
      if (i <= j) {
        if (mounted) {
          setState(() => {
                objtemp = listtobesort[i],
                listtobesort[i] = listtobesort[j],
                listtobesort[j] = objtemp,
                barColor1 = i,
                barColor2 = j,
              });
        }
        i++;
        j--;
      }
    }

    if (leftelement < j) {
      quickSort(listtobesort, leftelement, j);
    }
    if (i < rightelement) {
      quickSort(listtobesort, i, rightelement);
    }
    if (mounted) {
      setState(() => {
            barColor1 = -1,
            barColor2 = -1,
          });
    }
    return true;
  }

  Future<bool> bubbleSort(var L) async {
    var n = L.length;
    for (var i = 0; i < n; i++) {
      var v = 0;
      if (_value == 100) {
        v = 0;
      }
      if (_value == 75) {
        v = 100;
      }
      if (_value == 50) {
        v = 350;
      }
      if (_value == 25) {
        v = 650;
      }
      if (_value == 0) {
        v = 1000;
      }
      await Future.delayed(Duration(milliseconds: v));
      if (cancelled && mounted) {
        setState(() => {
              barColor1 = -1,
              barColor2 = -1,
              cancelled = false,
            });
        return true;
      }
      var temp;
      for (var j = 0; j < n - i - 1; j++) {
        if (L[j] > L[j + 1]) {
          if (mounted) {
            setState(() => {
                  temp = L[j],
                  L[j] = L[j + 1],
                  L[j + 1] = temp,
                  barColor1 = i,
                  barColor2 = j,
                });
          }
        }
      }
    }
    if (mounted) {
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
      if (_value == 100) {
        v = 0;
      }
      if (_value == 75) {
        v = 100;
      }
      if (_value == 50) {
        v = 350;
      }
      if (_value == 25) {
        v = 650;
      }
      if (_value == 0) {
        v = 1000;
      }
      await Future.delayed(Duration(milliseconds: v));
      if (cancelled && mounted) {
        setState(() => {
              barColor1 = -1,
              barColor2 = -1,
              cancelled = false,
            });
        return true;
      }
      int key = list[j];

      int i = j - 1;

      while (i >= 0 && list[i] > key) {
        if (mounted) {
          setState(() => {
                list[i + 1] = list[i],
                i = i - 1,
                list[i + 1] = key,
                barColor1 = j,
                barColor2 = i,
              });
        }
      }
    }
    if (mounted) {
      setState(() => {
            barColor1 = -1,
            barColor2 = -1,
          });
    }
    return true;
  }

  Future<bool> selectionSort(var L) async {
    var n = L.length;
    var temp, lock = 0, i = 0, j = 0;
    var index_min = 0;
    for (i = 0; i < n - 1; i++) {
      var v = 0;
      if (_value == 100) {
        v = 0;
      }
      if (_value == 75) {
        v = 100;
      }
      if (_value == 50) {
        v = 350;
      }
      if (_value == 25) {
        v = 650;
      }
      if (_value == 0) {
        v = 1000;
      }
      // var v = -1 *
      //     1 *
      //     (_value - 50.0)
      //         .toInt(); // '_value' goes from 100 to 0 so made it go from 0 to 100 by making its value decreased by 100 and negating the result {40 is  multiplied so that v can varies from 0 to 4000 for milliseconds in multiple of 40 milliseconds}
      await Future.delayed(Duration(milliseconds: v));
      if (cancelled && mounted) {
        setState(() => {
              barColor1 = -1,
              barColor2 = -1,
              cancelled = false,
            });
        return true;
      }
      index_min = i;
      for (j = i + 1; j < n; j++) {
        if (L[j] < L[index_min]) {
          index_min = j;
        }
      }
      if (index_min != i) {
        if (mounted) {
          // While sorting process is going on, back button is clicked then it stops sorting else gives error
          setState(() => {
                temp = L[i],
                L[i] = L[index_min],
                L[index_min] = temp,
                barColor1 = i,
                barColor2 = index_min,
              });
        }
      }
    }
    if (mounted) {
      setState(() => {
            barColor1 = -1,
            barColor2 = -1,
          });
    }
    // print("hi");
    // });
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
      child: Column(
        children: [
          Container(
            color:
                i == barColor1 || i == barColor2 ? Colors.yellow : Colors.red,
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
        ],
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
                ElevatedButton(
                    onPressed: () {
                      if (sortTap == 0) {
                        cancelled = false;

                        sort(widget.unsortedList);
                      }
                      sortTap++;
                    },
                    child: Text("Sort",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold))),
                ElevatedButton(
                    onPressed: () {
                      barColor1 = -1;
                      barColor2 = -1;
                      for (int i = 0; i < widget.unsortedList.length; i++) {
                        widget.unsortedList[i] = initialList[i];
                      }
                      setState(() {});
                    },
                    child: Text("Reset",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold)))
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              const Text("Current sorting method : "),
              Expanded(
                child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<String>(
                  value: currentSort,
                  onChanged: (value) {
                    setState(() {
                      currentSort = value!;
                      selectedSortingMethod = getIndex(value);
                      widget.unsortedList.clear();
                      widget.unsortedList.addAll(initialList);
                      sort(widget.unsortedList);
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
