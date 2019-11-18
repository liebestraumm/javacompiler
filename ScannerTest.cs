
using System;

namespace GPLexTutorial
{
    public class ScannerTest
    {
        public static void TestScanner(Scanner scanner)
        {
            Tokens token;
            do
            {
                token = (Tokens)scanner.yylex();
                switch (token)
                {
                    // Number Literals
                    case Tokens.INTEGER_LITERAL:
                        Console.WriteLine("INTEGER LITERAL ({0})", scanner.yylval.num);
                        break;
                    case Tokens.FLOAT_LITERAL:
                    {
                        Console.WriteLine("FLOAT LITERAL ({0})", scanner.yylval.floatVal);
                        break;
                    }
                    // Char Literals
                    case Tokens.CHARACTER:
                    {
                        Console.WriteLine("CHARACTER ({0})", scanner.yylval.name);
                        break;
                    }
                    // String Literals
                    case Tokens.STRING_LITERAL:
                        Console.WriteLine("STRING LITERAL ({0})", scanner.yylval.name);
                        break;
                    // Idens
                    case Tokens.IDENT:
                        Console.WriteLine("IDENT ({0})", scanner.yylval.name);
                        break;
                    // Keywords
                    case Tokens.IF:
                        Console.WriteLine("IF");
                        break;
                    case Tokens.PUBLIC:
                        Console.WriteLine("PUBLIC");
                        break;
                    case Tokens.STATIC:
                        Console.WriteLine("STATIC");
                        break;
                    case Tokens.VOID:
                        Console.WriteLine("VOID");
                        break;
                    case Tokens.CLASS:
                        Console.WriteLine("CLASS");
                        break;
                    case Tokens.ELSE:
                        Console.WriteLine("ELSE");
                        break;
                    case Tokens.INT:
                        Console.WriteLine("INT");
                        break;
                    case Tokens.BOOLEAN:
                        Console.WriteLine("BOOL");
                        break;
                    case Tokens.EOF:
                        Console.WriteLine("EOF");
                        break;
                    // Boolean literals
                    case Tokens.TRUE:
                        Console.WriteLine("TRUE");
                        break;
                    // Null literals
                    case Tokens.NULL:
                        Console.WriteLine("NULL");
                        break;
                    // Seperators
                    case Tokens.SEPARATOR_ONE:
                        Console.WriteLine("SEPARATOR 1 (...)");
                        break;
                    default:
                        Console.WriteLine("'{0}'", (char)token);
                        break;
                }
            }
            while (token != Tokens.EOF);
        }
    }
}
