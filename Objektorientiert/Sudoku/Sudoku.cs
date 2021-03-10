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
                                {
                                    return true;
                                }
                            }
                        }
                        Werte[Spalte, Zeile] = 0;
                        return false;
                    }
                }
            }
            return true;
        }
        private bool IstGueltig(int Spalte,int Zeile,int Wert)
        {
            if(ZeileGueltig(Zeile,Wert) && SpalteGueltig(Spalte, Wert) && BlockGueltig(Zeile, Spalte, Wert))
            {
                return true;
            }
            return false;
        }
        private bool BlockGueltig(int Zeile, int Spalte, int Wert)
        {
            //1 2 3
            //1 2 3
            //1 2 3 
            //Prüfung: Wo ist die obere Spalte? Von dort aus Prüfung nach rechts und nach unten --> Modulu
            for (int x = 0; x < 9; x++)
            {
               if (Werte[3 * (Zeile / 3) + x / 3, 3 * (Spalte / 3) + x % 3] != 0 && Werte[3 * (Zeile / 3) + x / 3, 3 * (Spalte / 3) + x % 3] == Wert) return false;
            }
            return true;

        }
        private bool SpalteGueltig(int Spalte, int Wert)
        {
            //Komplette Spalte durchlaufen
            for (int i = 0; i < 9; i++)
            {
                //Prüfung, ob Zeile = Wert 
                if (Werte[Spalte, i] == Wert) return false;
            }
            return true;
        }
        private bool ZeileGueltig(int Zeile, int Wert)
        {
            //Komplette Zeile durchlaufen
            for (int i = 0; i < 9; i++)
            {
                //Prüfung, ob Zeile = Wert 
                if (Werte[i, Zeile] == Wert) return false;
            }
            return true;
        }
        private bool IsValid()
        {

            return false;
        }
    }
}
