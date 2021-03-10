using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sudoku_Solver
{
    public class Sudoku
    {
        #region Properties
        private const int maxLaenge = 9;
        private int[,] spielFeld = new int[maxLaenge, maxLaenge];
        #endregion

        #region Public
        public Sudoku(int[,] Werte)
        {
            this.spielFeld = Werte;
        }
        public bool LoeseSudoku()
        {
            for (int Zeile = 0; Zeile < spielFeld.GetLength(0); Zeile++)
            {
                for (int Spalte = 0; Spalte < spielFeld.GetLength(1); Spalte++)
                {
                    if (spielFeld[Spalte,Zeile] == 0)
                    {
                        for (int aktuelleZahl = 1; aktuelleZahl <= 9; aktuelleZahl++)
                        {
                            if(IstGueltig(Spalte, Zeile, aktuelleZahl))
                            {
                                spielFeld[Spalte, Zeile] = aktuelleZahl;
                                if (LoeseSudoku())
                                    return true;
                                else
                                    spielFeld[Spalte, Zeile] = 0;
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
            for (int i = 0; i < spielFeld.GetLength(0); i++)
            {
                for (int j = 0; j < spielFeld.GetLength(1); j++)
                {
                    Console.Write(string.Format("{0} ", spielFeld[i, j]));
                }
                Console.Write("\n");
            }
            Console.ReadLine();
        }
        #endregion

        #region Private
        private bool IstGueltig(int Zeile, int Spalte, int Wert)
        {
            for (int i = 0; i < maxLaenge; i++)
            {
                //check row  
                if (spielFeld[i, Spalte] != 0 && spielFeld[i, Spalte] == Wert)
                    return false;
                //check column  
                if (spielFeld[Zeile, i] != 0 && spielFeld[Zeile, i] == Wert)
                    return false;
                //check 3*3 block  
                int AktuellerIndex = spielFeld[3 * (Zeile / 3) + i / 3, 3 * (Spalte / 3) + i % 3];
                if (AktuellerIndex != 0 && AktuellerIndex == Wert)
                    return false;
            }
            return true;
        }
        #endregion
    }
}
