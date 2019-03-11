module App.Route exposing (Route(..))

import Browser.Navigation as Nav
import Html exposing (Attribute)
import Html.Attributes as Attr
import Url exposing (Url)
import Url.Parser as Parser exposing ((</>), (<?>), Parser, oneOf, s, string)
import Url.Parser.Query as Query


type Route
    = Home


parser : Parser (Route -> a) a
parser =
    s "app" </> routeParser


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ Parser.map Home Parser.top
        ]


replaceUrl : Nav.Key -> Route -> Cmd msg
replaceUrl key route =
    Nav.replaceUrl key (routeToString route)


fromUrl : Url -> Maybe Route
fromUrl url =
    -- We treat the fragment like a path.
    -- This makes it *literally* the path, so we can proceed
    -- with parsing as if it had been a normal path all along.
    -- { url | path = Maybe.withDefault "" url.fragment, fragment = Nothing }
    Parser.parse parser url


routeToString : Route -> String
routeToString page =
    let
        ( pieces, query ) =
            case page of
                Home ->
                    ( [], "" )
    in
    "/app/" ++ String.join "/" pieces
