module App.Session exposing (Msg, Session, getZone, init, subscriptions, update)

import App.Schemas.User exposing (User)
import Browser.Navigation exposing (Key)
import Task
import Time exposing (Posix, Zone, utc)


type alias Session =
    { user : User
    , now : Posix
    , navKey : Key
    , zone : Maybe Zone
    }


init : Key -> User -> ( Session, Cmd Msg )
init key user =
    let
        nextModel =
            { user = user
            , now = Time.millisToPosix 0
            , navKey = key
            , zone = Nothing
            }

        nextCmd =
            Cmd.batch
                [ Task.perform Tick Time.now
                , Task.perform RecieveZone Time.here
                ]
    in
    ( nextModel, nextCmd )


getZone : Session -> Zone
getZone session =
    Maybe.withDefault utc session.zone


type Msg
    = Tick Posix
    | RecieveZone Zone


update : Msg -> Session -> Session
update msg model =
    case msg of
        Tick time ->
            { model | now = time }

        RecieveZone zone ->
            { model | zone = Just zone }


subscriptions : Session -> Sub Msg
subscriptions model =
    Time.every (60 * 1000) Tick
