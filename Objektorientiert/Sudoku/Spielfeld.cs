using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sudoku_Solver
{
    public class Spielfeld
    {
        int[,] Werte = new int[9, 9];
        public Spielfeld(int[,] Werte)
        {
            foreach (int Zahl in Werte)
            {
                if (Zahl < 0 || Zahl > 9)
                {
                    throw new Exception("Die eingegebenen Werte sind in einem falschen Format.");
                }
            }
            this.Werte = Werte;
        }
        public int[,] SpielfeldWerte
        {
            get
            {
                return Werte;
            }
        }
        public void SetzeWert(int Spalte, int Zeile, int NeuerWert)
        {
            if(NeuerWert > 9 || NeuerWert < 0)
            {
                throw new Exception("Eingabe ist zu groß oder zu klein!");
            }
            Werte[Spalte, Zeile] = NeuerWert;
        }
    }
}
