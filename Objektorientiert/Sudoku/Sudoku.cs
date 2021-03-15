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
        private Spielfeld spielfeld;
        #endregion

        #region Public
        public Sudoku(Spielfeld spielfeld)
        {
            this.spielfeld = spielfeld;
        }
        public bool LoeseSudoku()
        {
            for (int Zeile = 0; Zeile < spielfeld.SpielfeldWerte.GetLength(0); Zeile++)
            {
                for (int Spalte = 0; Spalte < spielfeld.SpielfeldWerte.GetLength(1); Spalte++)
                {
                    if (spielfeld.SpielfeldWerte[Spalte,Zeile] == 0)
                    {
                        for (int aktuelleZahl = 1; aktuelleZahl <= 9; aktuelleZahl++)
                        {
                            if(IstGueltig(Spalte, Zeile, aktuelleZahl))
                            {
                                spielfeld.SetzeWert(Spalte, Zeile, aktuelleZahl);
                                if (LoeseSudoku())
                                    return true;
                                else
                                    spielfeld.SpielfeldWerte[Spalte, Zeile] = 0;
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
            for (int i = 0; i < spielfeld.SpielfeldWerte.GetLength(0); i++)
            {
                for (int j = 0; j < spielfeld.SpielfeldWerte.GetLength(1); j++)
                {
                    Console.Write(string.Format("{0} ", spielfeld.SpielfeldWerte[i, j]));
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
                if (spielfeld.SpielfeldWerte[i, Spalte] != 0 && spielfeld.SpielfeldWerte[i, Spalte] == Wert)
                    return false;
                //check column  
                if (spielfeld.SpielfeldWerte[Zeile, i] != 0 && spielfeld.SpielfeldWerte[Zeile, i] == Wert)
                    return false;
                //check 3*3 block  
                int AktuellerIndex = spielfeld.SpielfeldWerte[3 * (Zeile / 3) + i / 3, 3 * (Spalte / 3) + i % 3];
                if (AktuellerIndex != 0 && AktuellerIndex == Wert)
                    return false;
            }
            return true;
        }
        #endregion
    }
}
