import 'package:flutter/material.dart';

import 'grid_setup_screen.dart';

class GridDisplayScreen extends StatefulWidget {
  final List<List<String>> grid;

  const GridDisplayScreen(this.grid, {super.key});

  @override
  State<GridDisplayScreen> createState() => _GridDisplayScreenState();
}

class _GridDisplayScreenState extends State<GridDisplayScreen> {
  TextEditingController searchController = TextEditingController();
  List<List<bool>> highlighted =
      []; // list of char that needs to be highlighted

  // function to search whether the search exists or not
  void searchWord(String word) {
    highlighted.clear();
    for (int i = 0; i < widget.grid.length; i++) {
      List<bool> row = [];
      for (int j = 0; j < widget.grid[i].length; j++) {
        row.add(false);
      }
      highlighted.add(row);
    }

    // Search for the word in the grid (left to right, top to bottom, diagonal)
    for (int i = 0; i < widget.grid.length; i++) {
      for (int j = 0; j < widget.grid[i].length; j++) {
        // Search East
        if (j + word.length <= widget.grid[i].length) {
          bool found = true;
          for (int k = 0; k < word.length; k++) {
            if (widget.grid[i][j + k] != word[k]) {
              found = false;
              break;
            }
          }
          if (found) {
            for (int k = 0; k < word.length; k++) {
              highlighted[i][j + k] = true;
            }
          }
        }

        // Search South
        if (i + word.length <= widget.grid.length) {
          bool found = true;
          for (int k = 0; k < word.length; k++) {
            if (widget.grid[i + k][j] != word[k]) {
              found = false;
              break;
            }
          }
          if (found) {
            for (int k = 0; k < word.length; k++) {
              highlighted[i + k][j] = true;
            }
          }
        }

        // Search Southeast
        if (j + word.length <= widget.grid[i].length &&
            i + word.length <= widget.grid.length) {
          bool found = true;
          for (int k = 0; k < word.length; k++) {
            if (widget.grid[i + k][j + k] != word[k]) {
              found = false;
              break;
            }
          }
          if (found) {
            for (int k = 0; k < word.length; k++) {
              highlighted[i + k][j + k] = true;
            }
          }
        }
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grid Display'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => const GridSetupScreen(),
            )),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search for a word',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    searchWord(searchController.text);
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.grid[0].length,
                ),
                itemCount: widget.grid.length * widget.grid[0].length,
                itemBuilder: (context, index) {
                  int row = index ~/ widget.grid[0].length;
                  int col = index % widget.grid[0].length;
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: highlighted.isNotEmpty
                          ? highlighted[row][col]
                              ? Colors.yellow
                              : Colors.white
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        widget.grid[row][col],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
