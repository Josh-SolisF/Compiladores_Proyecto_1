/* JF1ex exarnole: partial Java language lexer specification*/
import java_cup.runtime.* ;

    /*
    *   This class is a simple example lexer.
    */

    /*
        Lexer base tomado de la página de Cup que requiere sym para utilizarse como Lexer
        Este lexer es utilizado por por el parser generado por BasicLexerCup (parser.java que se genera)
    */

%%
%class LexerCupV
%public
%unicode
%cup
%line
%column

%{
    StringBuffer string = new StringBuffer();

    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }

    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
%}

LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace = {LineTerminator} | [ \t\f]

//comentarios
Comment = {TraditionalComment} | {EndOfLineComment}

TraditionalComment = "\\" [^*] ~"/" | "\\" ""+ "/" //Verificar que se este mapeando correctamente el '\' :c

EndOfLineComment = "#" {InputCharacter}* {LineTerminator}?
//DocumentationComment = "/" {CommentContent} "*"+ "/"
//CommentContent = ([^] | \+ [^ / ])

Identifier = [:jletter:]+[:jletterdigit:]*


digito = [0-9]
digitoNoCero = [1-9]
DecIntergerLiteral = 0 | -?{digitoNoCero}{digito}*




%state STRING

%%


/* Palabras clave */
<YYINITIAL> "abrecuento"        { return symbol(sym.ABRECUENTO); }
<YYINITIAL> "cierracuento"      { return symbol(sym.CIERRACUENTO); }
<YYINITIAL> "rodolfo"           { return symbol(sym.INT); }
<YYINITIAL> "bromista"          { return symbol(sym.FLOAT); }
<YYINITIAL> "trueno"            { return symbol(sym.BOOL); }
<YYINITIAL> "cupido"            { return symbol(sym.CHAR); }
<YYINITIAL> "cometa"            { return symbol(sym.STRING); }
<YYINITIAL> "abreempaque"       { return symbol(sym.ABREEMPAQUE); }
<YYINITIAL> "cierraempaque"     { return symbol(sym.CIERRAEMPAQUE); }
<YYINITIAL> "entrega"           { return symbol(sym.ASIGNA); }
<YYINITIAL> "abreregalo"        { return symbol(sym.ABREREGALO); }
<YYINITIAL> "cierraregalo"      { return symbol(sym.CIERRAREGALO); }
<YYINITIAL> "navidad"           { return symbol(sym.SUMA); }
<YYINITIAL> "intercambio"       { return symbol(sym.RESTA); }
<YYINITIAL> "reyes"             { return symbol(sym.DIVISION); }
<YYINITIAL> "nochebuena"        { return symbol(sym.MULTIPLICACION); }
<YYINITIAL> "magos"             { return symbol(sym.MODULO); }
<YYINITIAL> "adviento"          { return symbol(sym.POTENCIA); }
<YYINITIAL> "quien"             { return symbol(sym.INCREMENTO); }
<YYINITIAL> "grinch"            { return symbol(sym.DECREMENTO); }
<YYINITIAL> "snowball"          { return symbol(sym.MENOR); }
<YYINITIAL> "evergreen"         { return symbol(sym.MENORIGUAL); }
<YYINITIAL> "minstix"           { return symbol(sym.MAYOR); }
<YYINITIAL> "upatree"           { return symbol(sym.MAYORIGUAL); }
<YYINITIAL> "mary"              { return symbol(sym.IGUAL); }
<YYINITIAL> "openslae"          { return symbol(sym.DIFERENTE); }
<YYINITIAL> "melchor"           { return symbol(sym.CONJUNCION); }
<YYINITIAL> "gaspar"            { return symbol(sym.DISYUNCION); }
<YYINITIAL> "baltazar"          { return symbol(sym.NEGACION); }
<YYINITIAL> "finregalo"         { return symbol(sym.FINEXP); }
<YYINITIAL> "elfo"              { return symbol(sym.IF); }
<YYINITIAL> "hada"              { return symbol(sym.ELSE); }
<YYINITIAL> "envuelve"          { return symbol(sym.WHILE); }
<YYINITIAL> "duende"            { return symbol(sym.FOR); }
<YYINITIAL> "varios"            { return symbol(sym.SWITCH); }
<YYINITIAL> "historia"          { return symbol(sym.CASE); }
<YYINITIAL> "ultimo"            { return symbol(sym.DEFAULT); }
<YYINITIAL> "corta"             { return symbol(sym.BREAK); }
<YYINITIAL> "envia"             { return symbol(sym.RETURN); }
<YYINITIAL> "sigue"             { return symbol(sym.DOSPUNTOS); }
<YYINITIAL> "narra"             { return symbol(sym.PRINT); }
<YYINITIAL> "escucha"           { return symbol(sym.READ); }
<YYINITIAL> "_verano_"          { return symbol(sym.MAIN); }

/* Identificadores */
<YYINITIAL>{Identifier}         { return symbol(sym.IDENTIFICADOR); }

/* Literales */
<YYINITIAL>{DecIntegerLiteral}  { return symbol(sym.LITERAL_INT); }

/* Comentarios y espacios en blanco */
<YYINITIAL>{Comment}            { /* Ignorar comentarios */ }
<YYINITIAL>{WhiteSpace}         { /* Ignorar espacios en blanco */ }


/* Error Fallback */
//[^]                     { throw new Error("Illegal character <" + yytext() + ">"); }