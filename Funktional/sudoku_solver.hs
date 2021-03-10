import Data.List
import System.IO

type Grid = Matrix Value

type Matrix a = [Row a]

type Row a = [a]

type Value = Char

easy :: Grid
easy = ["2....1.38",
        "........5",
        ".7...6...",
        ".......13",
        ".981..257",
        "31....8..",
        "9..8...2.",
        ".5..69784",
        "4..25...."]

gentle :: Grid
gentle =  [".1.42...5",
           "..2.71.39",
           ".......4.",
           "2.71....6",
           "....4....",
           "6....74.3",
           ".7.......",
           "12.73.5..",
           "3...82.7."]

--Genereiere ein leeres Grid. (9 Zeilen mit jeweils 9 Punkten)
blank :: Grid
blank = replicate 9 (replicate 9 '.')

rows :: Matrix a -> [Row a]
rows = id

cols :: Matrix a -> [Row a]
cols = transpose

boxs :: Matrix a -> [Row a]
boxs = unpack . map cols . pack
    where
        pack = split . map split
        split = chop 3
        unpack = map concat . concat

chop :: Int -> [a] -> [[a]]
chop n [] = []
chop n xs = take n xs : chop n (drop n xs)


valid :: Grid -> Bool
valid g =   all nodups (rows g) &&
            all nodups (cols g) &&
            all nodups (boxs g)

nodups :: Eq a => [a] -> Bool
nodups [] = True
nodups (x:xs) = not (elem x xs) && nodups xs

solve :: Grid -> [Grid]
--         Am Ende das  Dann das  Erst das
solve = filter valid . collapse . choices

type Choices = [Value]
choices :: Grid -> Matrix Choices
choices g = map(map choice) g
            where
                choice v = if v == '.' then
                                ['1'..'9']
                            else
                                [v]

collapse :: Matrix [a] -> [Matrix a]
collapse m = cp (map cp m)

cp :: [[a]] -> [[a]]
cp [] = [[]]
cp (xs:xss) = [y:ys | y <- xs, ys <- cp xss]

prune :: Matrix Choices -> Matrix Choices
prune = pruneBy boxs . pruneBy cols . pruneBy rows
        where pruneBy f = f . map reduce . f

single :: [a] -> Bool
single [_] =  True
single _ =  False

reduce :: Row Choices -> Row Choices
reduce xss = [xs `minus` singles | xs <- xss]
                where singles = concat (filter single xss)

minus :: Choices -> Choices -> Choices
xs `minus` ys =  if single xs then xs else xs \\ ys

solve2 = filter valid . collapse . prune . choices

solve3 = filter valid . collapse . fix prune . choices

fix :: Eq a => (a -> a) -> a -> a
fix f x = if x == x' then x else fix f x'
            where x' = f x