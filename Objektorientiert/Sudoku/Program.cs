using System;

namespace Sudoku_Solver
{
    class Program
    {
        static void Main(string[] args)
        {
            int[,] sudokuEinfach = new int[,] { { 0,4,0,9,0,0,0,5,0 },
                                                { 2,0,0,0,0,0,0,4,0 },
                                                { 1,9,0,0,8,0,7,0,0 },
                                                { 5,0,0,0,0,0,1,0,0 },
                                                { 0,0,7,0,6,0,0,0,3 },
                                                { 0,0,0,0,3,0,8,9,0 },
                                                { 0,8,0,3,4,0,0,6,0 },
                                                { 3,0,0,2,0,8,0,0,0 },
                                                { 0,0,0,0,0,0,0,0,0 } };

            int[,] sudokuMittel = new int[,] { { 0,4,0,9,0,0,0,5,0 },
                                               { 2,0,0,0,0,0,0,4,0 },
                                               { 1,9,0,0,8,0,7,0,0 },
                                               { 5,0,0,0,0,0,1,0,0 },
                                               { 0,0,7,0,6,0,0,0,3 },
                                               { 0,0,0,0,3,0,8,9,0 },
                                               { 0,8,0,3,4,0,0,6,0 },
                                               { 3,0,0,2,0,8,0,0,0 },
                                               { 0,0,0,0,0,0,0,0,0 } };

            int[,] sudokuSchwer = new int[,] { { 0,4,0,9,0,0,0,5,0 },
                                               { 2,0,0,0,0,0,0,4,0 },
                                               { 1,9,0,0,8,0,7,0,0 },
                                               { 5,0,0,0,0,0,1,0,0 },
                                               { 0,0,7,0,6,0,0,0,3 },
                                               { 0,0,0,0,3,0,8,9,0 },
                                               { 0,8,0,3,4,0,0,6,0 },
                                               { 3,0,0,2,0,8,0,0,0 },
                                               { 0,0,0,0,0,0,0,0,0 } };
            Spielfeld spielfeld = new Spielfeld(sudokuEinfach);
            Sudoku sudoku = new Sudoku(spielfeld);
            if (sudoku.LoeseSudoku())
                sudoku.Ausgabe();
            else
                Console.WriteLine("Sudoku nicht lösbar.");
        }
    }
}
