module App.Pages.Notes.List exposing (Model, Msg(..), init, update, view)

import App.Schemas.Note exposing (Note)
import App.Session as Session exposing (Session)
import Html exposing (..)
import Html.Attributes exposing (..)
import Http
import Json.Decode as Decode exposing (Decoder, field, string)


type alias Model =
    { notes : List Note }


type Msg
    = GetNotes (Result Http.Error (List Note))


init : Session -> ( Model, Cmd Msg )
init session =
    let
        log =
            Debug.log "LIST PAGE" ""
    in
    ( { notes = [] }, Cmd.none )


view : Session -> Model -> Html Msg
view session model =
    div [ attribute "style" "background: pink;" ] [ text "List Page" ]


update : Session -> Msg -> Model -> ( Model, Cmd Msg )
update session msg model =
    case msg of
        GetNotes result ->
            let
                log =
                    Debug.log "result" result
            in
            ( model, Cmd.none )
