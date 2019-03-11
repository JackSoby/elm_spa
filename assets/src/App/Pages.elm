module App.Pages exposing (Page(..))

import App.Pages.Home as Home
import App.Route as Route exposing (..)


type Page
    = Blank


type alias Model =
    Page


init : Maybe Route -> ( Model, Cmd Msg )
init maybeRoute =
    changeRouteTo maybeRoute Blank


type Msg
    = HomeMsg Home.Msg
