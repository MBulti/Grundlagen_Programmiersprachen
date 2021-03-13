import Data.List
import System.IO

-- Ein Typ Spieldfeld, welches aus einer Matrix aus Char Werten besteht
type Spielfeld = Matrix Wert

-- Eine Matrix ist dabei ine Liste an Zeilen
type Matrix a = [Zeile a]

-- Eine Zeile ist eine Liste an Elementen
type Zeile a = [a]

type Wert = Char

-- Ein einfaches Spielfeld
-- Es gibt immer einen Punkt, wo nur eine Zahl möglich ist
einfach :: Spielfeld
einfach =   ["2....1.38",
             "........5",
             ".7...6...",
             ".......13",
             ".981..257",
             "31....8..",
             "9..8...2.",
             ".5..69784",
             "4..25...."]

-- Diese funktion ist dazu da, um die Zeilen auszulesen und zurückzugeben
zeilen :: Matrix a -> [Zeile a]
zeilen = id

-- Die Matrix des Spielfeldes wird gedreht, um Spalten zu Zeilen und Zeilen zu Spalten zu machen
spalten :: Matrix a -> [Zeile a]
spalten = transpose

-- Boxen werden aufgeteilt, um aus einer Box eine Zeile zu machen
boxen :: Matrix a -> [Zeile a]
boxen = unpack . map spalten . pack
    where
        pack = split . map split
        split = aufteilen 3
        unpack = map concat . concat

-- Hilfsfunktion um zu Ermitteln, an welchem Punkt eine Box aufgeteilt werden muss
aufteilen :: Int -> [a] -> [[a]]
aufteilen n [] = [] -- Standartwert
aufteilen n xs = take n xs : aufteilen n (drop n xs)

-- Überprüft, ob ein Spielfeld nur gültige Werte enthält
gueltig :: Spielfeld -> Bool
gueltig g =   all keinedopplung (zeilen g) &&
            all keinedopplung (spalten g) &&
            all keinedopplung (boxen g)

-- Hilfsfunktion zum überprüfen, ob es innerhalb eine Zeile/Spalte/Box keine Doppelten Werte gibt
keinedopplung :: Eq a => [a] -> Bool
keinedopplung [] = True -- Standartwert
keinedopplung (x:xs) = notElem x xs && keinedopplung xs

loesen :: Spielfeld -> [Spielfeld]
-- Erste möglichkeit ein Sudoku zu lösen. Es gibt aber so viele Möglichkeiten, dass das Zusammenfuehren und Überprüfen Ewigkeiten dauern würde.
-- Verbindungen von Funktionen werden von rechts nach links ausgeführt. Die Ausgabe er einen Funktion wird die Eingabe in die nächste Funktion. 
loesen = filter gueltig . zusammenfuehren . moeglichkeiten

-- Generiere alle Möglichkeiten an Matrixen, welche im aktuellen Spielfeld möglich sind.
-- Es wird nicht darauf geachtet, ob die Zahl gültig ist oder nicht
type Moeglichkeiten = [Wert]
moeglichkeiten :: Spielfeld -> Matrix Moeglichkeiten
moeglichkeiten = map(map moeglichkeit)
    where
        -- Ersetze nur den Punkt mit Werten von 1-9
        moeglichkeit v = if v == '.' then
                            ['1'..'9']
                        else
                            [v]

-- Für jede Möglichkeit in einem Feld wird eine neue Matrix erzeugt.
zusammenfuehren :: Matrix [a] -> [Matrix a]
zusammenfuehren m = cp (map cp m)

-- Hilfsfunktion zum Zusammenführen
cp :: [[a]] -> [[a]]
cp [] = [[]]
cp (xs:xss) = [y:ys | y <- xs, ys <- cp xss]

-- Entferne unnötige Werteoptionen, welche sowieso unmöglich sind.
vereinfachen :: Matrix Moeglichkeiten -> Matrix Moeglichkeiten
vereinfachen = pruneBy boxen . pruneBy spalten . pruneBy zeilen
        where pruneBy f = f . map reduzieren . f

--Überprüfe, ob es nur einen möglichen Wert gibt, oder mehrere
isteinzeln :: [a] -> Bool
isteinzeln [_] =  True
isteinzeln _ =  False

-- Lösche werte, welche schon einzeln in der Zeile vorkommen
reduzieren :: Zeile Moeglichkeiten -> Zeile Moeglichkeiten
reduzieren xss = [xs `minus` singles | xs <- xss]
                where singles = concat (filter isteinzeln xss)

-- Hilfsfunktion zum Entfernen von Werten
minus :: Moeglichkeiten -> Moeglichkeiten -> Moeglichkeiten
xs `minus` ys =  if isteinzeln xs then xs else xs \\ ys

-- Zweite Möglichkeit ein Sudoku zu lösen, welche zwar vereinfacht wurde, aber immer noch zu lange dauert.
loesen2 = filter gueltig . zusammenfuehren . vereinfachen . moeglichkeiten

-- Dritte Möglichkeit ein Sudoku zu lösen, bei der so lange vereinfacht wird, bis die Möglichkeiten nicht mehr vereinfacht werden können.
loesen3 = filter gueltig . zusammenfuehren . fix vereinfachen . moeglichkeiten

-- ermittle, ab wann eine Matrix nicht mehr vereinfacht werden kann.
-- Wenn bei der eingabe in eien Funktion die Ausgabe das selbe ist
fix :: Eq a => (a -> a) -> a -> a
fix f x = if x == x' then x else fix f x'
            where x' = f x