import 'dart:convert';
import 'dart:io';
import 'package:proyecto_final/proyecto_final.dart' as proyecto_final;
import 'sujeto.dart';
import 'package:csv/csv.dart';

const numeroOrdenDirecto = [[[2,9],[5,4],[3,9,6],[6,5,2],[5,4,1,2],[9,1,6,8],[8,2,1,9,6],[7,2,3,4,9],[5,7,3,6,4,8],
[3,8,4,1,7,5],[2,1,8,9,4,3,7],[7,8,5,2,1,6,3],[1,8,4,3,7,5,3,6],[2,7,9,6,3,1,4,8],[7,2,6,1,9,4,8,3,5],[4,3,8,9,1,7,5,6,2],
[6,2,5,3,1,8,9,5,4,7],[9,4,3,8,7,5,2,9,6,1]]]; 

const numeroOrdenInverso = [[[9,4],[5,6],[2,1],[1,3],[3,9],[8,5],[2,3,6],[5,4,1],[4,5,8],[2,7,5],[7,4,5,2],[9,3,8,6],
[2,1,7,9,4],[5,6,3,8,7],[1,6,5,7,5,8],[6,3,7,2,9,1],[8,1,5,2,4,3,6],[4,3,7,9,2,8,1],[3,1,7,9,4,6,8,2],[9,8,1,6,3,2,4,7]]]; 

const numeroOrdenCreciente = [[[3 ,1],[8,6],[5,2,4],[4,3,3],[4,1],[3,2],[5,2,7],[5,4,1],[1,8,6],[7,5,8,1],[4,2,9,3],
[1,5,6,2,8],[3,3,6,1,5],[4,9,4,6,9],[8,5,2,5,3,7],[6,1,4,7,9,3],[9,7,9,6,2,6,8],[3,1,7,5,1,8,5],[6,9,6,2,1,3,7,9],
[14854874],[2,5,7,7,4,8,7,5,2],[9,1,8,3,6,3,9,2,6]]]; 

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

  Map resultadoDelTestCreciente = testCreciente(edadInt);
   Sujeto.puntuacionCreciente = resultadoDelTestCreciente['aciertos'];
   Sujeto.puntuacionCrecienteSpan = resultadoDelTestCreciente['span'];
   Sujeto.puntuacionCrecienteIndices = resultadoDelTestCreciente['indices'];
  //salirDelPrograma('s'); /////////////// salidad borrrrarm///////////////////////
  
  Map resultadoDelTest= testDirecto();
  Sujeto.puntuacionDirecta = resultadoDelTest['aciertos'];
  Sujeto.puntuacionDirectSpan = resultadoDelTest['span']; 

   Map resultadoDelTestInverso = testInverso();
   Sujeto.puntuacionInverso = resultadoDelTestInverso['aciertos'];
   Sujeto.puntuacionInversoSpan = resultadoDelTestInverso['span']; 
  List<List<dynamic>> ListaDatos = [['Código','Edad','Dd','SpanDd', 'Di','SpanDi','Dc','SpanDc','Puntuación_Dígitos'],
    [Sujeto.codigo, 
    Sujeto.edad, 
    Sujeto.puntuacionDirecta, 
    Sujeto.puntuacionDirectSpan,
    Sujeto.puntuacionInverso,
    Sujeto.puntuacionInversoSpan,
    Sujeto.puntuacionCreciente,
    Sujeto.puntuacionCrecienteSpan,
    Sujeto.puntuacionCrecienteIndices
    ]];

  String csv = ListToCsvConverter().convert(ListaDatos);

  Directory directory = Directory('C:/Users/usuario/Desktop/test');
  final path = directory.path+'/'+Sujeto.codigo+'.csv';
  File file = await File(path);
  file.writeAsString(csv, encoding: utf8);
}
// fin de funcion Main ***

Map testDirecto(){
  print('----------------------------');
  print('comienza el test directo');
  print('---------------------------');
  int aciertos =0;
  int fallos =0;
  int span =0;

  for(var fila in numeroOrdenDirecto){
    for(var subfila in fila){ 
      print(subfila);
      while(true){
        print('Si ha Acertado coloca [i] de lo contrario [n]');
        String? haAcertado = stdin.readLineSync();
        if(haAcertado != null){
          haAcertado = haAcertado.toLowerCase();
          if(haAcertado == 'i'){
            aciertos++;
            break;
          }
          else if (haAcertado == 'n'){
            fallos++;
            break;
          }
          else{
            print('letra no admitida, escriba nuevamente.');
          }
        }
        else{
          print('ingrese un valor.');
        }
      }
      if(fallos == 2){
        break;
      }
    }
    if(fila[0].length >2){
      span = fila[0].length - 1;
    }
  }
return{'aciertos':aciertos,'span':span};
}

Map testInverso(){
  print('---------------------------');
  print('comienza el test Indirecto');
  print('---------------------------');
  int aciertos =0;
  int fallos =0;
  int span =0;
  int contadorEj =0;

  for(var fila in numeroOrdenInverso){
    for(var subfila in fila){
      if (contadorEj == 0){
        print('ejemplo :$subfila \n');
      }
      else{
        print(subfila);
        while(true){
          print('Si ha Acertado coloca [i] de lo contrario [n]');
          String? haAcertado = stdin.readLineSync();
          if(haAcertado != null){
            haAcertado = haAcertado.toLowerCase();
            if(haAcertado == 'i'){
              aciertos++;
              span = subfila.length;
              break;
            }
            else if (haAcertado == 'n'){
              fallos++;
              break;
            }
            else{
              print('letra no admitida, escriba nuevamente.');
            }
          }
        }
      }
      if(fallos == 2){
        break;
      }
      contadorEj++;
    }
  }
return{'aciertos':aciertos,'span':span};
}

Map testCreciente(edad){
  print('---------------------------');
  print('comienza el test Creciente');

  int aciertos =0;
  int fallos =0;
  int span =0;
  int contadorEj =0;
  bool pasoPrueba = false;

  int indicesAcertados = 0;

  for(var fila in numeroOrdenCreciente){
    for(var subfila in fila){
      if(edad <= 7 && !pasoPrueba){
        print('solicita que cuente hasta 3');
        String? haAcertado;
        while(true){
          print('Si ha Acertado coloca [i] de lo contrario [n]');
          haAcertado = stdin.readLineSync();
          if(haAcertado != null){
            haAcertado = haAcertado.toLowerCase();
            if (haAcertado == 'n'){
              fallos =2; // opcion dada para romper el for
              break;
            }
            else if(haAcertado == 'i'){
              pasoPrueba = true;
              break;
            }
            else{
              print('ingrese valor admitido');
            }
          }
        }
      }
      else if (edad>7 || pasoPrueba){
        if (contadorEj < 2){
          print('ejemplo :$subfila \n');
        }
        else{
          print(subfila);
          while(true){
            print('Si ha Acertado coloca [i] de lo contrario [n]');
            String? haAcertado = stdin.readLineSync();
            if(haAcertado != null){
              haAcertado = haAcertado.toLowerCase();
              if(haAcertado == 'i'){
                aciertos++;
                indicesAcertados += subfila.length;
                span = subfila.length;
                break;
              }
              else if (haAcertado == 'n'){
                fallos++;
                break;
              }
              else{
                print('letra no admitida, escriba nuevamente.');
              }
            }
          }
        }
      }
      if(fallos == 2){
        break;
      }
      contadorEj++;
    }
  }

return{'aciertos':aciertos,'span':span, 'indices':indicesAcertados};
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