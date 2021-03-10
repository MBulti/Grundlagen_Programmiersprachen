
using System;

namespace Sudoku
{
    class Program
    {
//Checks
//Es darf jeweils ein Wert in einer Zeile vorkommen
        //Welche Zeile soll geprüft werden? Welcher Wert soll geprüft werden? Spielfeld soll mit übergeben werden
        static bool chkZeile(int zeile, int wert, int [,] arr)
        {
            //Komplette Zeile durchlaufen
            for (int i=0; i < 9;i++)
            {
                //Prüfung, ob Zeile = Wert 
                if (arr[i, zeile] == wert) return false;
            }
            return true;
        }

        //Gleiches für die Spalten
        static bool chkSpalte(int zeile, int wert, int[,] arr)
        {
            //Komplette Spalte durchlaufen
            for (int i=0; i < 9;i++)
            {
                //Prüfung, ob Zeile = Wert 
                if (arr[i, zeile] == wert) return false;
            }
            return true;
        }

        //Für 9er-Block
        static bool chkBlock (int zeile, int spalte, int wert, int[,] arr)
        {
            //1 2 3
            //1 2 3
            //1 2 3 
            //Prüfung: Wo ist die obere Spalte? Von dort aus Prüfung nach rechts und nach unten --> Modulu
            for (int i=0; i < 9; i++)
            {
                for (int j=0; j< 9; j++)
                {
                    if (arr[spalte-(spalte %3) + i, zeile-(zeile%3)+j] == wert) return false;
                }
            }
            return true;

        }
        //Zusammenfassung der Checks
        static bool chkMove(int zeile, int spalte, int wert, int[,] arr)
        {
            //Wenn nicht true, dann false
            if(!chkZeile(zeile, wert, arr)) return false;
            if(!chkSpalte(spalte, wert, arr)) return false;
            if(!chkBlock(zeile, spalte, wert, arr)) return false;
            return true;
        }

//Algorithmus
        //Rekursiver Backtracking Algorithmus -> Werte ausprobieren, wenn nicht gültig, dann wieder dahin zurück als noch Werte offen waren
        static int[,] BSudoku(int wert, int px, int py, int [,] field)
        {
            //Kopie vom Spielbrett anlegen
            int[,] workerfield = new int[9,9];
            for (int i=0; i < 9; i++)
            {
                for (int j=0; j < 9; j++)
                {
                    workerfield[j,i] = field[j,i];

                }
            }
            //Wert, den wir mit übergeben haben an die neuen px, py Variablen übergeben und eintragen
            workerfield[px, py] = wert;
            //Algorithmus sucht erstes freies Feld und trägt Wert dort ein
            for (int x=0; x < 9; x++)
            {
                for (int y=0; y < 9; y++)
                {
                    //Prüfen, ob schon was im Feld drin steht
                    if(workerfield[x,y]==0)
                    {
                        //Schleife, die probiert die Werte von 1-9 einzutragen
                        for (int val = 1; val <=9; val++)
                        {
                            //Regeln abfragen
                            if(chkMove(y,x,val,workerfield)) 
                            {
                                //Wenn möglich, dann Funktion aufrufen (rekursiv) und übergeben der Wert für x,y und aktuelles Spielfeld
                                BSudoku(val ,x,y,workerfield);
                            }
                        }
                        //Wenn kein Wert mehr gefunden wird
                        return null;
                    }
                }
            }
            //Nur zum gucken
            for (int i=0; i<9; i++)
            {
                for(int j=0; j<9; j++)
                {
                    Console.Write(workerfield[j,i]);
                }
                Console.WriteLine();
            }
            Console.WriteLine("-----");
            return workerfield;
        }
        static void Main(string[] args)
        {
            int[,] field = new int[9,9];
            BSudoku(0,0,0, field);
        }
    }
}