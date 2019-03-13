module Main exposing (main)

import App.Pages as Pages
import App.Route as Route exposing (..)
import App.Schemas.User exposing (User)
import App.Session as Session exposing (Session)
import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Url
import Url.Parser exposing ((</>), Parser, int, map, oneOf, parse, s, string, top)


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        , onUrlRequest = LinkClicked
        , onUrlChange = UrlChanged
        }


type alias Flags =
    { user : User }


type Route
    = Home
    | About
    | NotFound


parser : Parser (Route -> a) a
parser =
    oneOf
        [ map Home top
        , map About (s "about")
        ]



-- MODEL


type alias Model =
    { page : Pages.Model
    , session : Session
    }


init : Flags -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url navKey =
    let
        ( nextSession, nextSessionCmd ) =
            Session.init navKey flags.user

        ( nextPage, nextPageCmd ) =
            Pages.init (Route.fromUrl url) nextSession

        nextModel =
            { page = nextPage
            , session = nextSession
            }
    in
    ( nextModel, Cmd.none )



-- UPDATE


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | PageMsg Pages.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    if String.startsWith "/app" url.path then
                        ( model, Nav.pushUrl model.session.navKey (Url.toString url) )

                    else
                        ( model, Nav.load (Url.toString url) )

                Browser.External "" ->
                    ( model, Cmd.none )

                Browser.External href ->
                    ( model, Nav.load href )

        PageMsg subMsg ->
            let
                ( nextPage, nextPageMsg ) =
                    Pages.update model.session subMsg model.page
            in
            ( { model | page = nextPage }, Cmd.map PageMsg nextPageMsg )

        UrlChanged url ->
            let
                ( nextPage, nextPageCmd ) =
                    Pages.changeRouteTo (Route.fromUrl url) model.session model.page
            in
            ( { model | page = nextPage }, Cmd.map PageMsg nextPageCmd )


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
    let
        page =
            Pages.view model.session model.page
                |> Html.map PageMsg

        content =
            div [ class "columns" ]
                [ div [ class "column has-background-light", id "page" ]
                    [ page ]
                ]

        body =
            div [ id "layout" ]
                [ text "toolbah"
                ]

        title =
            "Quiver | Dashboard"
    in
    { title = title
    , body = [ body ]
    }


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
    div [ class "collapse navbar-collapse" ]
        [ p [] [ text "Header" ]
        , ul []
            [ viewLink "/"
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
