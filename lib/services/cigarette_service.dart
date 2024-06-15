import 'package:my_app1/models/cigaratte.dart';

class CigaretteService {
  // Example list of cigarettes
  static List<Cigarette> cigarettes = [
    Cigarette(name: "Malboro", price: 20.0),
    Cigarette(name: "Esse Light", price: 10.0),
    // Add more cigarettes as needed
  ];

  // Function to fetch cigarettes
  static List<Cigarette> getCigarettes() {
    return cigarettes;
  }
}
