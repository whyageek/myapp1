# my_app1

A new Flutter project. for mm

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


void _deleteCigarette(String name) {
    showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Confirm Deletion"),
        content: Text("Are you sure you want to delete the cigarette container for '$name'?"),
        actions: [
          TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
            },
            child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  cigaretteCountMap.remove(name);
                });
                Navigator.of(context).pop();
              }, 
              child: Text("Delete")
            )
          ],
        );
      }
    );  
  }
