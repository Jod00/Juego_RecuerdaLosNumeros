import 'dart:io';
import 'package:proyecto_final/proyecto_final.dart' as proyecto_final;
import 'sujeto.dart';
import 'package:csv/csv.dart';

const numeroOrdenDirecto = [[[2,9],[5,4],[3,9,6],[6,5,2],[5,4,1,2],[9,1,6,8],[8,2,1,9,6],[7,2,3,4,9],[5,7,3,6,4,8],
[3,8,4,1,7,5],[2,1,8,9,4,3,7],[7,8,5,2,1,6,3],[1,8,4,3,7,5,3,6],[2,7,9,6,3,1,4,8],[7,2,6,1,9,4,8,3,5],[4,3,8,9,1,7,5,6,2],
[6,2,5,3,1,8,9,5,4,7],[9,4,3,8,7,5,2,9,6,1]]]; 

void main() async {
  
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
  
  var Sujeto = sujeto(codigo!, edadInt); 

  print('comienza el test...');
  Map resultadoDelTest= testDirecto();

  Sujeto.puntuacionDirecta = resultadoDelTest['aciertos'];
  Sujeto.puntuacionDirectSpan = resultadoDelTest['span']; 

  List<List<dynamic>> ListaDatos = [['Codigo','Edad','Dd','SpanDd', 
  Sujeto.codigo, Sujeto.edad, Sujeto.puntuacionDirecta, Sujeto.puntuacionDirectSpan]];

  String csv = ListToCsvConverter().convert(ListaDatos);

  Directory directory = Directory('C:/Users/usuario/Desktop/test');
  final path = directory.path+'/'+Sujeto.codigo+'.csv';
  File file = await File(path);
  file.writeAsString(csv);

}
// fin de funcion Main ***

Map testDirecto(){
  int aciertos= 0;
  int fallos = 0;
  int span =0;

  for(var fila in numeroOrdenDirecto){
    for(var subfila in fila){
      print(subfila);
      print('Si ha Acertado coloca [i] de lo contrario [n]');
      String? haAcertado = stdin.readLineSync();
      if(haAcertado != null){
        haAcertado = haAcertado.toLowerCase();
        if(haAcertado == 'i'){
          aciertos++;
        }
        else{
          fallos++;
        }
      }
    }
    if(fila[0].length >2){
      span = fila[0].length - 1;
    }
    if(fallos == 2){
      break;
    }
  }
return{'aciertos':aciertos,'span':span};
}

void salirDelPrograma(String? entrada){
  if (entrada == 's' || entrada == "S"){
    print('''seguro que deseas salir? presiona [s] de nuevo
    si no deseas salir presiona cualquier otra tecla''');
    String? respuesta = stdin.readLineSync();
    if (respuesta == 's'|| entrada == "S"){
        exit(0);
    }
  }
}

int ComprobarNumero(String? entrada){
  if (int.tryParse(entrada!) == null){
     print('valor introducido no es reconocible');
     exit(0);
  }
  else{
    return int.parse(entrada);
  }
}