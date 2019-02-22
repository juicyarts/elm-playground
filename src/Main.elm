port module Main exposing (Model, Msg(..), init, main, toJs, update, view)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Decode
-- PORTS-

port toJs : String -> Cmd msg

-- MODEL

type alias Model =
  { websocketUrl: String
  , message: String
  }

init : Int -> (Model, Cmd Msg)
init flags = ({ websocketUrl = "127.0.0.1:3012" , message = "BAr!" }, Cmd.none)

-- UPDATE

type Msg
  = ChangedWebsocketUrl String
  | ChangedMessage String

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ChangedWebsocketUrl changedUrl ->
      ({ model | websocketUrl = changedUrl }, toJs "Hello Js")
    ChangedMessage newMessage ->
      ({ model | message = newMessage }, toJs "Hello Js")

-- VIEW

websocketUrlDisplay: String -> Html Msg
websocketUrlDisplay webSocketUrl =
  div [class "foo"] [ text webSocketUrl ]

view : Model -> Html Msg
view model =
  div []
    [ div [class "container-lg clearfix"]
      [ div [class "col-12 float-left border p-4"]
        [ Html.form []
          [ div [class "input-group"]
            [ input [class "form-control input-block", type_ "text", placeholder "WebsocketUrl", value model.websocketUrl, onInput ChangedWebsocketUrl] [],
              span [class "input-group-button", type_ "button"]
                [ button [class "btn", type_ "button"]
                  [ i [class "material-icons md-18"]
                    [ text "face" ]
                  ]
                ]
            ]
          ]
        ]
      ]
    ]



-- ---------------------------
-- MAIN
-- ---------------------------

main : Program Int Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , view =
            \m ->
                { title = "Socker"
                , body = [ view m ]
                }
        , subscriptions = \_ -> Sub.none
        }
