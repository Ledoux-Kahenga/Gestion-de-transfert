     class Admin {
       final String id;
       final String username;
       final String password;

       Admin({required this.id, required this.username, required this.password});

       // Convertir l'objet Admin en Map
       Map<String, dynamic> toMap() {
         return {
           'id': id,
           'username': username,
           'password': password,
         };
       }

       // Convertir Map en objet Admin
       factory Admin.fromMap(Map<String, dynamic> map) {
         return Admin(
           id: map['id'],
           username: map['username'],
           password: map['password'],
         );
       }
     }
     