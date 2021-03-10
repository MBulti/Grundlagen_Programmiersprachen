using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sudoku_Solver
{
    class Sudoku
    {
        private int[,] Werte = new int[9, 9];

        public Sudoku(int[,] Werte)
        {
            this.Werte = Werte;
        }

        public bool Loesen()
        {
            for (int Zeile = 0; Zeile < Werte.GetLength(0); Zeile++)
            {
                for (int Spalte = 0; Spalte < Werte.GetLength(1); Spalte++)
                {
                    if (Werte[Spalte,Zeile] == 0)
                    {
                        for (int i = 1; i <= 9; i++)
                        {
                            if(IstGueltig(Spalte, Zeile, i))
                            {
                                Werte[Spalte, Zeile] = i;
                                if (Loesen())
                                    return true;
                                else
                                    Werte[Spalte, Zeile] = 0;
                            }
                        }
                        return false;
                    }
                }
            }
            return true;
        }

        public void Ausgabe()
        {
            for (int i = 0; i < Werte.GetLength(0); i++)
            {
                for (int j = 0; j < Werte.GetLength(1); j++)
                {
                    Console.Write(string.Format("{0} ", Werte[i, j]));
                }
                Console.Write("\n");
            }
            Console.ReadLine();
        } 

        private bool IstGueltig(int Zeile, int Spalte, int Wert)
        {
            for (int i = 0; i < 9; i++)
            {
                //check row  
                if (Werte[i, Spalte] != 0 && Werte[i, Spalte] == Wert)
                    return false;
                //check column  
                if (Werte[Zeile, i] != 0 && Werte[Zeile, i] == Wert)
                    return false;
                //check 3*3 block  
                int AktuellerIndex = Werte[3 * (Zeile / 3) + i / 3, 3 * (Spalte / 3) + i % 3];
                if (AktuellerIndex != 0 && AktuellerIndex == Wert)
                    return false;
            }
            return true;
        }
    }
}
