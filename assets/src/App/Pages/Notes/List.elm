module App.Pages.Notes.List exposing (Model, Msg(..), init, update, view)

import App.Session as Session exposing (Session)
import Html exposing (..)
import Html.Attributes exposing (..)


type alias Model =
    {}


type Msg
    = NoOp


init : Session -> ( Model, Cmd Msg )
init session =
    ( {}, Cmd.none )


view : Session -> Model -> Html Msg
view session model =
    div [ attribute "style" "background: pink;" ] [ text "List Page" ]


update : Session -> Msg -> Model -> ( Model, Cmd Msg )
update session msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )
