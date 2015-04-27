module PhoneticNumberSystem (convertDigits) where

import String
import Dict

dict2 : Dict.Dict Char (List String)
dict2 =
  let l = [('0', ["s", "z", "c"])
          ,('1', ["t", "d"])
          ,('2', ["n"])
          ,('3', ["m"])
          ,('4', ["r"])
          ,('5', ["l"])
          ,('6', ["sh", "ch", "j", "g"])
          ,('7', ["k", "q"])
          ,('8', ["f", "v"])
          ,('9', ["p", "b"])]
  in Dict.fromList l

-- converts a digit char to all possible correspondig characters
convertDigit : Char -> List String
convertDigit digit =
  case Dict.get digit dict2 of
    Just chars -> chars
    Nothing -> [String.fromChar digit]


-- converts a digit string to all possible coresponding characters
convertDigits : String -> List String
convertDigits digits =
  let digitChars = String.toList digits -- result is [Char], ex: ['1', '4', '3']
      lists = List.map convertDigit digitChars -- result is [[String]], ex: [["m"],["f", "v"],["p"]]
      combinations = List.foldr cartProduct [] lists
   in combinations

-- Returns cartesian product, string style
-- So cartProduct ["a", "b"] ["c", "d"] returns ["ac", "ad", "bc", "bd"]
cartProduct : (List String) -> (List String) -> List String
cartProduct xs ys =
  if | List.isEmpty xs -> ys
     | List.isEmpty ys -> xs
     | otherwise ->
  let combinations = List.map (\x -> List.map (\y -> [x ++ y]) ys) xs
  in List.concat (List.concat combinations)

