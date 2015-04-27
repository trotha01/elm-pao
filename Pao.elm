module Pao where

import Graphics.Element exposing (..)
import Graphics.Input.Field as Field
import String
import Dict
import PhoneticNumberSystem as PNS

content : Signal.Mailbox Field.Content
content =
  Signal.mailbox Field.noContent

main : Signal Element
main =
  Signal.map phoneticInput content.signal

-- field : Style -> (Content -> Signal.Message) -> String -> Content -> Element
--    The next two arguments are a Handle and a handler function that processes or augments events before sending them along to the associated Input.
--    (Content -> Signal.Message) is a Handle
-- message : Address a -> a -> Message
--    Create a message that may be sent to a Mailbox at a later time.

phoneticInput : Field.Content -> Element
phoneticInput fieldContent =
  flow down
  [ Field.field Field.defaultStyle (Signal.message content.address) "Type Here!" fieldContent
  , flow down (List.map show (PNS.convertDigits fieldContent.string))
  ]
