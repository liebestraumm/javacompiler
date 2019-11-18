using System;
using GPLexTutorial.AST;
using System.Collections.Generic;
using System.IO;
using System.Linq.Expressions;
using static GPLexTutorial.AST.Modifier;

namespace GPLexTutorial
{
    class GlobalCounter
    {
        public static int LastLabel = 0;
    }

    class Program
    {        
        public static void Main(string[] args)
        {
            Scanner scanner = new Scanner(
                new FileStream("Tests/test2.j", FileMode.Open));
            try
            {
                Parser parser = new Parser(scanner);
                parser.Parse();
                SemanticAnalysis(Parser.root);
                Parser.root.Dump(0);
                GenerateCodeHandler("code_generator_test.txt");
                Console.ReadKey();
            }
            catch (NameResolutionException nameResolutionException)
            {

            }
            catch (TypeException typeException)
            {

            }

            // Test scanner
            //ScannerTest.TestScanner(scanner);

            //   Manual AST
            //var root = new CompilationUnit(
            //    new PackageDeclaration(),
            //    new List<ImportDeclaration>(),
            //    new List<TypeDeclaration> {
            //        new ClassDeclaration(
            //            new List<Modifier> {PUBLIC},
            //            "HelloWorld",
            //            new List<Declaration>{
            //                new MethodDeclaration(
            //                    new List<Modifier> {PUBLIC, STATIC},
            //                    new MethodHeader(
            //                        new VoidType(),
            //                        new MethodDeclarator(
            //                            "main",
            //                            new List<Parameter>{
            //                                new Parameter(
            //                                    new List<Modifier>(),
            //                                    new ArrayType(new NamedType("String")),
            //                                    "args")}
            //                            )
            //                        ),                                    
            //                    new CompoundStatement(new List<Statement>{
            //                        new LocalVariableDeclarationStatement(
            //                            new List<Modifier>(),
            //                            new IntType(),
            //                            "x"),
            //                        new ExpressionStatement(
            //                            new AssignmentExpression(
            //                                new IdentifierExpression("x"),
            //                                '=',
            //                                new IntegerLiteralExpression(42)))}))})});
            //root.Dump(0);
        }

        public static void SemanticAnalysis(Node root)
        {
            root.ResolveNames(null);
            root.TypeCheck();
        }

        public static void GenerateCodeHandler(string filename)
        {
            StreamWriter st = new StreamWriter(filename);
            Parser.root.Emit(st, ".assembly Test {{}}\n\n");                    
            Parser.root.GenerateCode(st);
            st.Close();
        }
    }
}
