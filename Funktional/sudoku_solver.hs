import Data.List
import System.IO

type Spielfeld = Matrix Wert

type Matrix a = [Zeile a]

type Zeile a = [a]

type Wert = Char

einfach :: Spielfeld
einfach = ["2....1.38",
        "........5",
        ".7...6...",
        ".......13",
        ".981..257",
        "31....8..",
        "9..8...2.",
        ".5..69784",
        "4..25...."]

zeilen :: Matrix a -> [Zeile a]
zeilen = id

spalten :: Matrix a -> [Zeile a]
spalten = transpose

boxen :: Matrix a -> [Zeile a]
boxen = unpack . map spalten . pack
    where
        pack = split . map split
        split = aufteilen 3
        unpack = map concat . concat

aufteilen :: Int -> [a] -> [[a]]
aufteilen n [] = []
aufteilen n xs = take n xs : aufteilen n (drop n xs)


gueltig :: Spielfeld -> Bool
gueltig g =   all keinedopplung (zeilen g) &&
            all keinedopplung (spalten g) &&
            all keinedopplung (boxen g)

keinedopplung :: Eq a => [a] -> Bool
keinedopplung [] = True
keinedopplung (x:xs) = not (elem x xs) && keinedopplung xs

loesen :: Spielfeld -> [Spielfeld]
--         Am Ende das  Dann das  Erst das
loesen = filter gueltig . zusammenfuehren . moeglichkeiten

type Choices = [Wert]
moeglichkeiten :: Spielfeld -> Matrix Choices
moeglichkeiten g = map(map choice) g
            where
                choice v = if v == '.' then
                                ['1'..'9']
                            else
                                [v]

zusammenfuehren :: Matrix [a] -> [Matrix a]
zusammenfuehren m = cp (map cp m)

cp :: [[a]] -> [[a]]
cp [] = [[]]
cp (xs:xss) = [y:ys | y <- xs, ys <- cp xss]

vereinfachen :: Matrix Choices -> Matrix Choices
vereinfachen = pruneBy boxen . pruneBy spalten . pruneBy zeilen
        where pruneBy f = f . map reduzieren . f

single :: [a] -> Bool
single [_] =  True
single _ =  False

reduzieren :: Zeile Choices -> Zeile Choices
reduzieren xss = [xs `minus` singles | xs <- xss]
                where singles = concat (filter single xss)

minus :: Choices -> Choices -> Choices
xs `minus` ys =  if single xs then xs else xs \\ ys

loesen2 = filter gueltig . zusammenfuehren . vereinfachen . moeglichkeiten

loesen3 = filter gueltig . zusammenfuehren . fix vereinfachen . moeglichkeiten

fix :: Eq a => (a -> a) -> a -> a
fix f x = if x == x' then x else fix f x'
            where x' = f x