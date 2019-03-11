module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Url
import Url.Parser exposing ((</>), Parser, int, map, oneOf, parse, s, string, top)


main =
    Browser.application
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        , onUrlRequest = LinkClicked
        , onUrlChange = UrlChanged
        }


type Route
    = Home
    | About
    | NotFound


parser : Parser (Route -> a) a
parser =
    oneOf
        [ map Home (s "home")
        , map About (s "about")
        ]



-- MODEL


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    , route : Route
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model key url Home, Cmd.none )



-- UPDATE


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | route = fromUrl url }
            , Cmd.none
            )


fromUrl : Url.Url -> Route
fromUrl url =
    Maybe.withDefault NotFound (parse parser url)



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Browser.Document Msg
view model =
    case model.route of
        Home ->
            viewHomePage

        About ->
            viewAboutPage

        NotFound ->
            viewNotFoundPage


viewHomePage : Page msg
viewHomePage =
    buildPage "Home Page"
        (template
            (div []
                [ p [] [ text "Homepage" ] ]
            )
        )


type alias Page msg =
    { title : String
    , body : List (Html msg)
    }


header : Html msg
header =
    div []
        [ p [] [ text "Header" ]
        , ul []
            [ viewLink "/home"
            , viewLink "/about"
            ]
        ]


footer : Html msg
footer =
    div []
        [ p [] [ text "Footer" ]
        ]


template : Html msg -> List (Html msg)
template content =
    [ header
    , content
    , footer
    ]


buildPage : String -> List (Html msg) -> Page msg
buildPage title body =
    { title = title
    , body = body
    }


viewAboutPage : Page msg
viewAboutPage =
    buildPage "Blog"
        (template
            (div []
                [ p [] [ text "Blog Page" ] ]
            )
        )


viewNotFoundPage : Page msg
viewNotFoundPage =
    buildPage "Not Found"
        (template
            (div []
                [ p [] [ text "Not Found" ] ]
            )
        )


viewLink : String -> Html msg
viewLink path =
    li [] [ a [ href path ] [ text path ] ]
