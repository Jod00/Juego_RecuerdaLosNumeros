class sujeto{
   String _codigo;
   int _edad;

  get codigo => this._codigo;

 set codigo( value) => this._codigo = value;

  get edad => this._edad;

 set edad( value) => this._edad = value;
 
   int? puntuacionDirecta;
   int? puntuacionDirectSpan;

   int? puntuacionInverso;
   int? puntuacionInversoSpan;
   
   int? puntuacionCreciente;
   int? puntuacionCrecienteSpan;
   int? puntuacionCrecienteIndices;
   
   sujeto(this._codigo, this._edad);
}