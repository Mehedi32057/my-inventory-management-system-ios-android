

class Employee {
  final String name;
  final String image;
  final String position;
  final String email;

  Employee({required this.name, required this.image, required this.position, required this.email});
}

List<Employee> employees = [
  Employee(
    name: 'Mehedi',
    image: 'mehedi.jpg',
    position: 'Software Engineer',
    email: 'mehedi@example.com',
  ),
  Employee(
    name: 'Shanu',
    image: 'shanu.jpg',
    position: 'Flutter Developer',
    email: 'rakib@example.com',
  ),
  Employee(
    name: 'Sunny',
    image: 'sunny.jpg',
    position: 'Backend Developer',
    email: 'sunny@example.com',
  ),
];