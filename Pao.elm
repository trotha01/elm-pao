module Pao where

import Graphics.Element exposing (..)
import Graphics.Input.Field as Field
import String
import Dict
import Text
import PhoneticNumberSystem as PNS

content : Signal.Mailbox Field.Content
content =
  Signal.mailbox Field.noContent

main : Signal Element
main =
  Signal.map phoneticInput content.signal

header : Element
header =
  Text.fromString "Type some numbers and see the possible conversions!"
    |> Text.height 24
    |> leftAligned

phoneticInput : Field.Content -> Element
phoneticInput fieldContent =
  flow down
  [ container 600 50 midLeft header
  , Field.field Field.defaultStyle (Signal.message content.address) "Type Here!" fieldContent
  , flow down (List.map show (PNS.convertDigits fieldContent.string))
  ]

