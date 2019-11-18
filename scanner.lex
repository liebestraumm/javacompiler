%namespace GPLexTutorial

%{
int lines = 1;
%}
 
/* Reference: https://docs.oracle.com/javase/specs/jls/se9/html/jls-3.html */



/*--------------------------------- Regular expression definitions ---------------------------------*/

/* 1. Common Atomic Expression */
Digit								[0-9]
Letter								[a-zA-Z]
LetterOrDigit						{Digit}|{Letter}
HexDigit							[0-9a-fA-F]
OctalDigit							[0-7]
BinaryDigit							0|1
NonZeroDigit						[1-9]
InputCharacter						[^\r\n]
SingleCharacter		                [^\'\\\n]
SingleStringCharacter               [^\"\\\n]
Underscores                         \_+
IntegerTypeSuffix					l|L
FloatTypeSuffix						f|F|d|D
ExponentIndicator					e|E
DigitOrUnderscore					{Digit}|{Underscores}
DigitsAndUnderscores				{DigitOrUnderscore}+
Digits								{Digit}|{Digit}{DigitsAndUnderscores}?{Digit}
Sign								\+|\-
SignedInteger						{Sign}?{Digits}

/* 2. Unicode Escapes */
UnicodeEscape						\\(u+){HexDigit}{4}   

/* 3. Line Terminators */
LineTerminator						(\r\n)|\r|\n

/* 4. White Spaces */
WhiteSpace							[ \t\f\r]|

/* 5. Identifiers */  
JavaLetter							{Letter}|\$|\_               
JavaLetterOrDigit					{JavaLetter}|{Digit}
IdentifierChars						{JavaLetter}{JavaLetterOrDigit}*  

/* 6. DecimalIntegerLiteral */
DecimalNumeral						0|{NonZeroDigit}{Digits}?|{NonZeroDigit}{Underscores}{Digits}
DecimalIntegerLiteral				{DecimalNumeral}{IntegerTypeSuffix}?

/* 7. HexIntegerLiteral */
HexDigitOrUnderscore				{HexDigit}|\_
HexDigitsAndUnderscores				{HexDigitOrUnderscore}+
HexDigits							{HexDigit}|{HexDigit}{HexDigitsAndUnderscores}?{HexDigit}
HexNumeral							0x{HexDigits}|0X{HexDigits}
HexIntegerLiteral					{HexNumeral}{IntegerTypeSuffix}?

/* 8. OctalIntegerLiteral */
OctalDigitOrUnderscore				{OctalDigit}|\_
OctalDigitsAndUnderscores			{OctalDigitOrUnderscore}+
OctalDigits							{OctalDigit}|{OctalDigit}{OctalDigitsAndUnderscores}?{OctalDigit}
OctalNumeral						0{OctalDigits}|0{Underscores}{OctalDigits}
OctalIntegerLiteral					{OctalNumeral}{IntegerTypeSuffix}?

/* 9. BinaryIntegerLiteral */
BinaryDigitOrUnderscore				{BinaryDigit}|\_
BinaryDigitsAndUnderscores			{BinaryDigitOrUnderscore}+
BinaryDigits						{BinaryDigit}|{BinaryDigit}{BinaryDigitsAndUnderscores}?{BinaryDigit}
BinaryNumeral						0b{BinaryDigits}|0B{BinaryDigits}
BinaryIntegerLiteral				{BinaryNumeral}{IntegerTypeSuffix}?

/* 10. Integer Literal */
IntergerLiteral                     {DecimalIntegerLiteral}|{HexIntegerLiteral}|{OctalIntegerLiteral}|{BinaryIntegerLiteral}

/* 11. DecimalFloatingPointLiteral */
ExponentPart						{ExponentIndicator}{SignedInteger}
DFPLiteral_1						{Digits}\.{Digits}?{ExponentPart}?{FloatTypeSuffix}?
DFPLiteral_2						\.{Digits}{ExponentPart}?{FloatTypeSuffix}?
DFPLiteral_3						{Digits}{ExponentPart}{FloatTypeSuffix}?
DFPLiteral_4						{Digits}{ExponentPart}?{FloatTypeSuffix}
DecimalFloatingPointLiteral			{DFPLiteral_1}|{DFPLiteral_2}|{DFPLiteral_3}|{DFPLiteral_4}

/* 12. HexadecimalFloatingPointLiteral */
BinaryExponentIndicator				p|P
BinaryExponent						{BinaryExponentIndicator}{SignedInteger}
HexSignificand						({HexNumeral}\.?)|(0x{HexDigits}?\.{HexDigits})|(0X{HexDigits}?\.{HexDigits})
HexadecimalFloatingPointLiteral		{HexSignificand}{BinaryExponent}{FloatTypeSuffix}?

/* 13. FloatingPointLiteral */
FloatingPointLiteral				{DecimalFloatingPointLiteral}|{HexadecimalFloatingPointLiteral}

/* 14. Escape Sequences */
OctalEscape							\\([0-3]{OctalDigit}{2}|{OctalDigit}{1,2})
EscapeSequence						(\\n|\\r|\\t|\\b|\\f|\\\'|\\\"|\\\\|{OctalEscape})

/* 15. String Literal */
StringLiteral						\"({SingleStringCharacter}|{EscapeSequence}|{UnicodeEscape})*\"

/* 16. Character Literal */
CharacterLiteral					\'({SingleCharacter}|{EscapeSequence}|{UnicodeEscape})\'

/* Start conditions */
%x multiple_lines_comment
%x single_line_comment

/*------------------------------------------------------------------------------------------------------------*/


/*--------------------------------- Java Lexical Tokens and InputElements ------------------------------------*/

%%

/* 1. Keywords */
abstract							{ return (int)Tokens.ABSTRACT; }            
assert								{ return (int)Tokens.ASSERT; }           
boolean								{ return (int)Tokens.BOOLEAN; }       
break								{ return (int)Tokens.BREAK; }       
byte								{ return (int)Tokens.BYTE; }      
case								{ return (int)Tokens.CASE; }     
catch								{ return (int)Tokens.CATCH; }     
char								{ return (int)Tokens.CHAR; }     
class								{ return (int)Tokens.CLASS; }    
const								{ return (int)Tokens.CONST; }   
continue							{ return (int)Tokens.CONTINUE; } 
default								{ return (int)Tokens.DEFAULT; }   
do									{ return (int)Tokens.DO; }        
double								{ return (int)Tokens.DOUBLE; }   
else								{ return (int)Tokens.ELSE; }    
enum								{ return (int)Tokens.ENUM; }   
extends								{ return (int)Tokens.EXTENDS; }   
final								{ return (int)Tokens.FINAL; }   
finally								{ return (int)Tokens.FINALLY; }  
float								{ return (int)Tokens.FLOAT; }   
for									{ return (int)Tokens.FOR; }      
if									{ return (int)Tokens.IF; }       
goto								{ return (int)Tokens.GOTO; }      
implements							{ return (int)Tokens.IMPLEMENTS; }  
import								{ return (int)Tokens.IMPORT; }  
instanceof							{ return (int)Tokens.INSTANCEOF; }  
int									{ return (int)Tokens.INT; }
interface							{ return (int)Tokens.INTERFACE; }
long								{ return (int)Tokens.LONG; }
native								{ return (int)Tokens.NATIVE; }
new									{ return (int)Tokens.NEW; }
package								{ return (int)Tokens.PACKAGE; }
private								{ return (int)Tokens.PRIVATE; }
protected							{ return (int)Tokens.PROTECTED; }
public								{ return (int)Tokens.PUBLIC; }
return								{ return (int)Tokens.RETURN; }
short								{ return (int)Tokens.SHORT; }
static								{ return (int)Tokens.STATIC; }
strictfp							{ return (int)Tokens.STRICTFP; }
super								{ return (int)Tokens.SUPER; }
switch								{ return (int)Tokens.SWITCH; }
synchronized						{ return (int)Tokens.SYNCHRONIZED; }
this								{ return (int)Tokens.THIS; }
throw								{ return (int)Tokens.THROW; }
throws								{ return (int)Tokens.THROWS; }
transient							{ return (int)Tokens.TRANSIENT; }
try									{ return (int)Tokens.TRY; }
void								{ return (int)Tokens.VOID; }
volatile							{ return (int)Tokens.VOLATILE; }
while								{ return (int)Tokens.WHILE; }
_									{ return '_';}


/* 2.Operators */
"->"								{ return (int)Tokens.LAMBDA; }
"=="								{ return (int)Tokens.EQUALS; }
">="								{ return (int)Tokens.GEQ; }
"<="								{ return (int)Tokens.LEQ; }
"!="								{ return (int)Tokens.NOT_EQUALS; }
"&&"								{ return (int)Tokens.LOGICAL_AND; }
"||"								{ return (int)Tokens.OR; }
"++"								{ return (int)Tokens.INCREMENT; }
"--"								{ return (int)Tokens.DECREMENT; }
"<<"								{ return (int)Tokens.LEFT_SHIFT; }
">>"								{ return (int)Tokens.RIGHT_SHIFT; }
">>>"								{ return (int)Tokens.ZERO_FILL_RIGHT_SHIFT; }
"+="								{ return (int)Tokens.ADD_RIGHT_OP; }
"-="								{ return (int)Tokens.SUB_RIGHT_OP; }
"*="								{ return (int)Tokens.MULTI_RIGHT_OP; }
"/="								{ return (int)Tokens.DIV_RIGHT_OP; }
"&="								{ return (int)Tokens.AND_ASSIGNMENT; }
"|="								{ return (int)Tokens.OR_ASSIGNMENT; }
"^="								{ return (int)Tokens.EXCLUSIVE_ASSIGNMENT; }
"%="								{ return (int)Tokens.MODULUS_ASSIGNMENT; }
"<<="								{ return (int)Tokens.LSHIFT_ASSIGNMENT; }
">>="								{ return (int)Tokens.RSHIFT_ASSIGNMENT; }
">>>="								{ return (int)Tokens.ZRSHIFT_ASSIGNMENT; }
"="									{ return '='; }
">"									{ return '>'; }
"<"									{ return '<'; }
"!"									{ return '!'; }
"~"									{ return '~'; }
"?"									{ return '?'; }
":"									{ return ':'; }
"+"									{ return '+'; }
"-"									{ return '-';}
"*"									{ return '*'; }
"/"									{ return '/'; }
"&"									{ return '&'; }
"|"									{ return '|'; }
"^"									{ return '^'; }
"%"									{ return '%'; }


/* 3.Separator */
"("									{ return '('; }
")"									{ return ')'; }
"{"									{ return '{'; }
"}"									{ return '}'; }
"["									{ return '['; }
"]"									{ return ']'; }
";"									{ return ';'; }
","									{ return ','; }
"."									{ return '.'; }
"@"									{ return '@'; }
"..."								{ return (int)Tokens.SEPARATOR_ONE; }
"::"								{ return (int)Tokens.SEPARATOR_TWO; }


/* 4. Comment */

/* Multiple Lines Comments */
"/*"     BEGIN(multiple_lines_comment);
<multiple_lines_comment> [^*\n]*														/* Eat anything that's not a '*' */
<multiple_lines_comment> "*"+[^*/\n]*													/* Eat up '*'s not followed by '/'s */
<multiple_lines_comment> \n         ++lines;											/* Increment line */
<multiple_lines_comment> "*"+"/"    BEGIN(INITIAL);


/* Single Line Comments */
"//"     BEGIN(single_line_comment);
<single_line_comment>\n				{ ++lines; BEGIN(INITIAL); }						/* Increment line */  


/* 5. Literals */

/* 5.1 Integer literal */
{IntergerLiteral}					{ yylval.num = int.Parse(yytext); return (int)Tokens.INTEGER_LITERAL; }

/* 5.2 Float literal */
{FloatingPointLiteral}				{ yylval.floatVal = float.Parse(yytext); return (int)Tokens.FLOAT_LITERAL; }

/* 5.3 Boolean literal */
true								{ return (int)Tokens.TRUE;}
false								{ return (int)Tokens.FALSE;}

/* 5.4 Null literal */
null								{ return (int)Tokens.NULL;}    

/* 5.5 Character literal */
{CharacterLiteral}					{ yylval.name = yytext; return (int)Tokens.CHARACTER;}  

/* 5.6 String literal */
{StringLiteral}						{ yylval.name = yytext; return (int)Tokens.STRING_LITERAL;}  


/* 6. Identifier */
/* Note: identifier does not accept single _ as valid identifier */

{IdentifierChars}					{ yylval.name = yytext; return (int)Tokens.IDENT; }


/* 7. White spaces */
[\n]								{ lines++;    }
{WhiteSpace}						/* Ignore other whitespace */


. {
 throw new Exception(
 String.Format(
 "unexpected character '{0}'", yytext));
 }

%%

public override void yyerror( string format, params object[] args )
{
    System.Console.Error.WriteLine("Error: line {0}, {1}", lines,
        String.Format(format, args));
}
