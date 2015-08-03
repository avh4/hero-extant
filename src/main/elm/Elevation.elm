module Elevation (generate) where

import Matrix exposing (Matrix)
import Random exposing (Seed)


all : List (Maybe a) -> Maybe (List a)
all =
    List.foldr (
        \maybeItem total ->
            case total of
                Nothing -> Nothing
                Just list ->
                    case maybeItem of
                        Nothing -> Nothing
                        Just item -> Just (item :: list)
    ) (Just [])


generate : (Matrix a, Seed) -> (Matrix { a | elevation : Float }, Seed)
generate (input, seed) =
    let
        roughness = 100.0 / 20
        elevation = 100.0 / 200
        w = Matrix.colCount input
        h = Matrix.rowCount input

        divideWorld : Int -> Int -> Int -> Int -> Float -> Float -> Matrix { a | elevation : Float } -> Matrix { a | elevation : Float }
        divideWorld x1 y1 x2 y2 roughness midinit map =
            let
                w' = x2 - x1
                h' = y2 - y1
                midx = (x1 + x2) // 2
                midy = (y1 + y2) // 2

                d = (((w' + h' |> toFloat) / 2) / (w + h |> toFloat))
                random1 = 0.7 -- TODO r.nextDouble()
                d' = d * (random1 * 2 - 1) * roughness

                getElevation loc matrix =
                    Maybe.map (.elevation) (Matrix.get loc matrix)

                setElevation loc v matrix =
                    Matrix.update loc (\r -> { r | elevation <- v }) matrix

                updater inputLocs destination valueComputer map' =
                    let
                        allElevations =
                            List.map ((flip getElevation) map') inputLocs
                            |> all
                    in
                        allElevations
                        |> Maybe.map (\inputs ->
                            setElevation destination (valueComputer inputs) map'
                        )
                        |> Maybe.withDefault map'

                computer inputs = List.sum inputs / 2
            in
                if w' > 1 || h' > 1
                then
                    map
                    |> updater
                        [ Matrix.loc x1 y1
                        , Matrix.loc x2 y1
                        ]
                        (Matrix.loc midx y1)
                        computer
                    |> updater
                        [ Matrix.loc x1 y2
                        , Matrix.loc x2 y2
                        ]
                        (Matrix.loc midx y2)
                        computer
                    |> updater
                        [ Matrix.loc x1 y1
                        , Matrix.loc x1 y2
                        ]
                        (Matrix.loc x1 midy)
                        computer
                    |> updater
                        [ Matrix.loc x2 y1
                        , Matrix.loc x2 y2
                        ]
                        (Matrix.loc x2 midy)
                        computer
                    |> updater
                        [ Matrix.loc x1 y1
                        , Matrix.loc x1 y2
                        , Matrix.loc x2 y1
                        , Matrix.loc x2 y2
                        ]
                        (Matrix.loc midx midy)
                        (\inputs -> List.sum inputs / 4 + d)
                    |> (\map' -> if midinit > -1 then setElevation (Matrix.loc midx midy) midinit map' else map')
                    |> divideWorld x1 y1 midx midy roughness -1
                    |> divideWorld midx y1 x2 midy roughness -1
                    |> divideWorld x1 midy midx y2 roughness -1
                    |> divideWorld midx midy x2 y2 roughness -1

                else map
        result =
            Matrix.map (\r -> { r | elevation = 0}) input
            |> divideWorld 0 0 w h roughness elevation
    in
    (result, seed)
