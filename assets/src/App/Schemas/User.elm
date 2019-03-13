module App.Schemas.User exposing (User)


type alias User =
    { id : String
    , email : String
    , firstName : String
    , lastName : String
    , role : String
    }
