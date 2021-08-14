import 'package:flutter/material.dart';

class SearchBar extends SearchDelegate<String?> {
  //TODO: delete after handle api
  final example1 = [
    'example1',
    'example2',
    'example3',
  ];
//TODO: delete after handle api
  final example2 = [
    'example4',
    'example5',
    'example6',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
            showSuggestions(context);
          }
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            query,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 64,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //TODO: Update suggestion
    final suggestions = query.isEmpty
        ? example2
        : example1.where((element) {
            final elementLower = element.toLowerCase();
            final queryLower = query.toLowerCase();

            return elementLower.startsWith(queryLower);
          }).toList();
    return buildSuggestionsSuccess(suggestions);
  }

  Widget buildSuggestionsSuccess(List<String> suggestions) {
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          final queryText = suggestion.substring(0, query.length);
          final remainingText = suggestion.substring(query.length);

          return ListTile(
            onTap: () {
              query = suggestion;

              //1. Show Results
              showResults(context);

              //TODO: 2. Close Search & Return Result
              // close(context, suggestion);

              // TODO: 3. Navigate to Result Page
              //  Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (BuildContext context) => ResultPage(suggestion),
              //   ),
              // );
            },
            leading: Icon(Icons.search),
            title: RichText(
              text: TextSpan(
                  text: queryText,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: remainingText,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        )),
                  ]),
            ),
          );
        });
  }
}
