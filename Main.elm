port module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String


main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { fromJS : String
    , msgToJs : String
    }


init =
    ( Model "" "", Cmd.none )


type Msg
    = FromJS String
    | ToJS
    | MsgToJS String


update msg model =
    case msg of
        FromJS str ->
            ( { model | fromJS = str }, Cmd.none )

        ToJS ->
            ( model, toJS model.msgToJs )

        MsgToJS str ->
            ( { model | msgToJs = str }, Cmd.none )


port toJS : String -> Cmd msg


port fromJS : (String -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    fromJS FromJS


view model =
    div []
        [ br [] []
        , div []
            [ input [ onInput MsgToJS, placeholder "Msg to send to js" ] []
            , button [ onClick ToJS ] [ text "Send it" ]
            ]
              , br [] []
        , div []
            [ "FROMJS: " ++ model.fromJS |> text
            ]
        ]
