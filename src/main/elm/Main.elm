import Graphics.Collage as C exposing (..)
import Graphics.Element as E exposing (..)
import Color exposing (..)
import Matrix exposing (Matrix)
import Random exposing (Seed)
import Text
import Debug
import Maybe exposing (map, withDefault, andThen, Maybe (..) )
import Array
import Time

import World exposing (World, Tile, defaultSeaLevel, initialMap)
import Elevation
import Native.Now as Now

import Html
import StartApp

main =
    StartApp.start { model = model, view = view, update = update }


model =
    generateWorld <| Random.initialSeed Native.Now.loadTime


generateWorld : Seed -> World
generateWorld seed =
    { seaLevel = defaultSeaLevel
    , map = generateMap seed |> fst
    }


generateMap : Seed -> (Matrix Tile, Seed)
generateMap seed =
    initialMap
    |> (flip (,)) seed
    |> Elevation.generate


view address model =
    (render (512,512) .elevation address model)
    |> Html.fromElement


render : (Int,Int) -> (Tile -> Float) -> Signal.Address Action -> World -> Element
render (mapWidth,mapHeight) extract address world =
    let
        map = world.map
        boxWidth = (toFloat mapWidth) / (toFloat <| Matrix.colCount map)
        boxHeight = (toFloat mapHeight) / (toFloat <| Matrix.rowCount map)
        box = C.rect boxWidth boxHeight

        colorFor elevation =
            let
                belowSeaLevel =
                    elevation < world.seaLevel

                elevationDiff =
                    elevation - world.seaLevel |> abs
            in
                if | belowSeaLevel -> rgb 0 0 (floor <| 255 * (0.5 * (elevation) + 0.5))
                   | otherwise -> rgb (floor <| 255 * 0.75 * elevation) (floor <| 255 * 0.75 * elevation) 0

        cell value =
            [ C.filled (colorFor value) box ]
            |> C.collage (floor boxWidth) (floor boxHeight)
    in
        map
        |> Matrix.map (extract >> cell)
        |> Matrix.toList
        |> List.map (flow right)
        |> flow down


type Action
    = NewSeed Seed
    | SeaLevel Float


update : Action -> World -> World
update msg model =
    case msg of
        NewSeed seed ->
            { model | map <- generateMap seed |> fst }

        SeaLevel newSeaLevel ->
            { model | seaLevel <- newSeaLevel }