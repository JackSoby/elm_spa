module App.Pages exposing (Model, Msg(..), Page(..), changeRouteTo, init, update, updateWith, view)

import App.Pages.Home as Home
import App.Pages.Notes as Notes
import App.Route as Route exposing (..)
import App.Session as Session exposing (Session)
import Html exposing (Html, div, text)


type Page
    = Blank
    | NotFound
    | HomePage Home.Model
    | NotesPage Notes.Model


type alias Model =
    Page


init : Maybe Route -> Session -> ( Model, Cmd Msg )
init maybeRoute session =
    changeRouteTo maybeRoute session Blank


changeRouteTo : Maybe Route -> Session -> Model -> ( Model, Cmd Msg )
changeRouteTo maybeRoute session model =
    case maybeRoute of
        Nothing ->
            ( NotFound, Cmd.none )

        Just Route.Home ->
            Home.init
                |> updateWith HomePage HomeMsg

        Just (Route.NoteRoute subRoute) ->
            (case model of
                NotesPage subPage ->
                    Notes.changeRouteTo subRoute session subPage

                _ ->
                    Notes.init subRoute session
            )
                |> updateWith NotesPage NotesMsg


update : Session -> Msg -> Model -> ( Model, Cmd Msg )
update session msg page =
    case ( msg, page ) of
        ( HomeMsg pageMsg, HomePage pageModel ) ->
            Home.update session pageMsg pageModel
                |> updateWith HomePage HomeMsg

        ( NotesMsg pageMsg, NotesPage pageModel ) ->
            Notes.update session pageMsg pageModel
                |> updateWith NotesPage NotesMsg

        _ ->
            ( page, Cmd.none )


view : Session -> Model -> Html Msg
view session page =
    case page of
        HomePage pageModel ->
            Home.view session pageModel
                |> Html.map HomeMsg

        NotFound ->
            div [] [ text "Not Found" ]

        Blank ->
            text ""

        NotesPage pageModel ->
            Notes.view session pageModel
                |> Html.map NotesMsg


updateWith : (subModel -> Model) -> (subMsg -> Msg) -> ( subModel, Cmd subMsg ) -> ( Model, Cmd Msg )
updateWith toModel toMsg ( subModel, subCmd ) =
    ( toModel subModel
    , Cmd.map toMsg subCmd
    )


type Msg
    = HomeMsg Home.Msg
    | NotesMsg Notes.Msg
