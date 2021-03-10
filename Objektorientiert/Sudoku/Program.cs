using System;

namespace Sudoku_Solver
{
    class Program
    {
        static void Main(string[] args)
        {
            int[,] Werte = new int[,] { { 0,4,0,9,0,0,0,5,0 },
                                        { 2,0,0,0,0,0,0,4,0 },
                                        { 1,9,0,0,8,0,7,0,0 },
                                        { 5,0,0,0,0,0,1,0,0 },
                                        { 0,0,7,0,6,0,0,0,3 },
                                        { 0,0,0,0,3,0,8,9,0 },
                                        { 0,8,0,3,4,0,0,6,0 },
                                        { 3,0,0,2,0,8,0,0,0 },
                                        { 0,0,0,0,0,0,0,0,0 } };
            //Console.WriteLine(Werte.GetLength(0).ToString());
            Sudoku blub = new Sudoku(Werte);
            blub.Loesen();

            int rowLength = blub.Werte.GetLength(0);
            int colLength = blub.Werte.GetLength(1);

            for (int i = 0; i < rowLength; i++)
            {
                for (int j = 0; j < colLength; j++)
                {
                    Console.Write(string.Format("{0} ", blub.Werte[i, j]));
                }
                Console.Write(Environment.NewLine + Environment.NewLine);
            }
            Console.ReadLine();
        }
    }
}
