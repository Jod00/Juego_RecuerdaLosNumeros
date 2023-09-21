import 'dart:io';

import 'package:proyecto_final/proyecto_final.dart' as proyecto_final;

import 'sujeto.dart';

const numeroOrdenDirecto = [[[2,9],[5,4],[3,9,6],[6,5,2],[5,4,1,2],[9,1,6,8],[8,2,1,9,6],[7,2,3,4,9],[5,7,3,6,4,8],
[3,8,4,1,7,5],[2,1,8,9,4,3,7],[7,8,5,2,1,6,3],[1,8,4,3,7,5,3,6],[2,7,9,6,3,1,4,8],[7,2,6,1,9,4,8,3,5],[4,3,8,9,1,7,5,6,2],
[6,2,5,3,1,8,9,5,4,7],[9,4,3,8,7,5,2,9,6,1]]]; 

void main() {
  
  print('''
  **Test Digitos de WISC V **
  ----------------------------
  Podras salir del test en cualquier momento presionando la letra s y despues enter

  comienza el test:

  ''');

  print('introduce tu codigo :');
  String? codigo = stdin.readLineSync();
  salirDelPrograma(codigo);

  print('introduce tu edad :');
  String? edad = stdin.readLineSync();
  salirDelPrograma(edad);
  int edadInt= ComprobarNumero(edad);

  sujeto(codigo!, edadInt);

  print('comienza el test...');

  
}

void salirDelPrograma(String? entrada){
  if (entrada == 's' || entrada == "S"){
    print('''seguro que deseas salir? presiona s de nuevo
    si no deseas salir presiona cualquier otra tecla''');
    String? respuesta = stdin.readLineSync();
    if (respuesta == 's'|| entrada == "S"){
        exit(0);
    }
  }
}

int ComprobarNumero(String? entrada){
  if (int.tryParse(entrada!) != null){
     print('valor introducido no es reconocible');
     exit(0);
  }
  else{
    return int.parse(entrada);
  }
}