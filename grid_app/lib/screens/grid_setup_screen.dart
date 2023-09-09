import 'package:flutter/material.dart';

import 'grid_display_screen.dart';

class GridSetupScreen extends StatefulWidget {
  const GridSetupScreen({super.key});

  @override
  State<GridSetupScreen> createState() => _GridSetupScreenState();
}

class _GridSetupScreenState extends State<GridSetupScreen> {
  int m = 0; // no of rows
  int n = 0; // no of columns
  List<List<String>> grid = []; // rows * columns grid

  TextEditingController textController =
      TextEditingController(); // text controller for the characters

  // function to create grid
  void createGrid() {
    grid.clear();
    String text = textController.text.replaceAll(' ', ''); // Remove spaces
    int totalCells = m * n; // total grid cells
    List<String> charArr = text
        .split(''); // fetching each char from string by splitting it into array

    // if entered text length and total cells length are not same, show following snack bar message
    if (text.length != totalCells) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please provide $totalCells characters.'),
      ));
      return;
    }

    // initializing the grid with the values
    for (int i = 0; i < m; i++) {
      List<String> row = [];
      for (int j = 0; j < n; j++) {
        // adding char in rows
        row.add(charArr[i * n + j]);
      }
      // added that entire row in grid
      grid.add(row);
    }

    // navigating to the grid screen where the grid is displayed
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GridDisplayScreen(grid),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grid Setup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Enter the number of rows (m) and columns (n):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 50,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'm',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        m = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child:
                      Text('x', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  width: 50,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'n',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        n = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Enter alphabets (m * n):',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter ${m * n} alphabets',
              ),
              controller: textController,
              maxLength: m * n > 0 ? m * n : 1,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                createGrid();
              },
              child: const Text('Create Grid'),
            ),
          ],
        ),
      ),
    );
  }
}
