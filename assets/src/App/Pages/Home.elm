module App.Pages.Home exposing (Model, Msg(..), init, update, view)

import App.Session as Session exposing (Session)
import Html exposing (..)


type alias Model =
    {}


type Msg
    = HomeMsg


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )


view : Session -> Model -> Html Msg
view session model =
    div [] [ text "HOME BOY" ]


update : Session -> Msg -> Model -> ( Model, Cmd Msg )
update session msg model =
    case msg of
        HomeMsg ->
            ( model, Cmd.none )
