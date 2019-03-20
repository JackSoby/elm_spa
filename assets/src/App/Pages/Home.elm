module App.Pages.Home exposing (Model, Msg(..), init, update, view)

import App.Session as Session exposing (Session)
import Html exposing (..)
import Html.Attributes exposing (..)


type alias Model =
    {}


type Msg
    = HomeMsg


init : ( Model, Cmd Msg )
init =
    let
        log =
            Debug.log "log" "I am home"
    in
    ( {}, Cmd.none )


view : Session -> Model -> Html Msg
view session model =
    let
        log =
            Debug.log "home" "view"
    in
    div []
        [ div [ attribute "style" "background: red;" ]
            [ text "HOME BOY" ]
        , a
            [ attribute "style" "background: pink;", href "/app/notes" ]
            [ text "go to list" ]
        ]


update : Session -> Msg -> Model -> ( Model, Cmd Msg )
update session msg model =
    case msg of
        HomeMsg ->
            ( model, Cmd.none )
