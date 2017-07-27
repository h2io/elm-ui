module H2ioUi
    exposing
        ( createFontStyles
        , box
        , heading
        , text
        , input
        , logo
        , logoSvg
        , button
        , buttonHover
        , buttonDisabled
        , buttonLoader
        )

{-|
# H2ioUi - Ui pieces for H2io apps

## Layout
@docs createFontStyles, box, heading, text, input

## Logo
@docs logo, logoSvg

## Button styles
@docs button, buttonHover, buttonDisabled, buttonLoader
-}

import Css exposing (..)
import Html exposing (div, Html, span, strong)
import Html.Attributes exposing (style)
import Svg
import Svg.Attributes exposing (d)
import Html.CssHelpers as CssHelpers
import Html.Styles exposing (..)


fontStyles : String -> String
fontStyles uri =
    """
    @font-face {
      font-family: 'Fira Sans';
      src: url('""" ++ uri ++ """/public/firasans-regular.woff2') format('woff2'),
        url('""" ++ uri ++ """/public/firasans-regular.woff') format('woff');
      font-weight: normal;
      font-style: normal;
    }

    @font-face {
      font-family: 'Fira Sans';
      src: url('""" ++ uri ++ """/public/firasans-bold.woff2') format('woff2'),
        url('""" ++ uri ++ """/public/firasans-bold.woff') format('woff');
      font-weight: bold;
      font-style: normal;
    }
    """


type alias StandardCss =
    List ( String, String )


type alias URI =
    String


{-|
  creates inline `style` elements that bring in the Fira Sans font
-}
createFontStyles : URI -> Html msg
createFontStyles uri =
    CssHelpers.style (fontStyles uri)


boxStyle : StandardCss
boxStyle =
    [ ( "all", "initial" )
    , ( "box-sizing", "border-box" )
    , ( "display", "flex" )
    , ( "flex-direction", "column" )
    , ( "position", "relative" )
    , ( "z-index", "9" )
    ]


contentStyle : StandardCss
contentStyle =
    [ ( "all", "initial" )
    , ( "background-color", "#fff" )
    , ( "display", "block" )
    , ( "border", "30px solid  #fff" )
    , ( "box-sizing", "border-box" )
    , ( "flex", "1" )
    , ( "overflow", "auto" )
    , ( "width", "100%" )
    , ( "border-top", "0" )
    , ( "border-bottom", "0" )
    ]


clipTopLeft : StandardCss
clipTopLeft =
    [ ( "all", "initial" )
    , ( "border", "30px" )
    , ( "border-top", "0" )
    , ( "border-color", "#fff" )
    , ( "border-style", "solid" )
    , ( "box-sizing", "border-box" )
    , ( "display", "block" )
    , ( "width", "100%" )
    , ( "height", "0" )
    , ( "border-left-color", "transparent" )
    ]


clipBottomRight : StandardCss
clipBottomRight =
    [ ( "all", "initial" )
    , ( "border", "30px" )
    , ( "border-bottom", "0" )
    , ( "border-color", "#fff" )
    , ( "border-style", "solid" )
    , ( "box-sizing", "border-box" )
    , ( "display", "block" )
    , ( "width", "100%" )
    , ( "height", "0" )
    , ( "border-right-color", "transparent" )
    ]


styl : List Css.Mixin -> Html.Attribute msg
styl =
    Css.asPairs >> style


{-|
  H2io Layout shape
-}
box : StandardCss -> Bool -> Html msg -> Html msg
box css showBorder content =
    let
        borderBox =
            if showBorder then
                div
                    [ styles
                        [ ( "all", "initial" )
                        , ( "position", "absolute" )
                        , ( "left", "-2px" )
                        , ( "right", "-2px" )
                        , ( "bottom", "-2px" )
                        , ( "top", "-2px" )
                        , ( "offset-block-end", "-2px" )
                        , ( "offset-block-start", "-2px" )
                        , ( "offset-inline-end", "-2px" )
                        , ( "offset-inline-start", "-2px" )
                        , ( "z-index", "-1" )
                        , ( "opacity", ".45" )
                        ]
                        []
                    ]
                    [ div
                        [ styles
                            (clipTopLeft
                                ++ [ ( "border", "31px" )
                                   , ( "border-color", "#005a81" )
                                   , ( "borderleft-color", "transparent" )
                                   , ( "border-top", "0" )
                                   , ( "width", "100%" )
                                   ]
                            )
                            []
                        ]
                        []
                    , div
                        [ styles
                            [ ( "all", "initial" )
                            , ( "display", "block" )
                            , ( "height", "calc( 100% - 62px )" )
                            , ( "background-color", "#005a81" )
                            , ( "width", "100%" )
                            ]
                            []
                        ]
                        []
                    , div
                        [ styles
                            (clipBottomRight
                                ++ [ ( "border", "31px" )
                                   , ( "border-color", "#005a81" )
                                   , ( "border-right-color", "transparent" )
                                   , ( "border-bottom", "0" )
                                   , ( "width", "100%" )
                                   ]
                            )
                            []
                        ]
                        []
                    ]
            else
                div [] []
    in
        div [ styles boxStyle [], style css ]
            [ borderBox
            , span [ styles clipTopLeft [] ] []
            , div [ styles contentStyle [] ] [ content ]
            , span [ styles clipBottomRight [] ] []
            ]


{-|
  H2io Logo in SVG format
-}
logoSvg : Int -> StandardCss -> Html msg
logoSvg size css =
    Svg.svg
        [ Svg.Attributes.width "16"
        , Svg.Attributes.height "16"
        , Svg.Attributes.viewBox "0 0 16 16"
        , Svg.Attributes.preserveAspectRatio "xMaxYMax"
        , style
            ([ ( "fill", "#379ac4" )
             , ( "display", "inline-block" )
             , ( "vertical-align", "middle" )
               -- , ( "transform", ("scale(" ++ (toString ((toFloat size) / 9) ++ ")")) )
               -- , ( "transform-origin", "0 top 0" )
             , ( "width", ((toString size) ++ "px") )
             , ( "height", "auto" )
             ]
                ++ css
            )
        ]
        [ Svg.path [ d "M1 1h4v2H1zM1 3h2v10H1zM1 13h4v2H1zM11 1h4v2h-4zM13 3h2v10h-2zM11 13h4v2h-4zM5 11h6v2H5zM5 5h6v2H5z" ] []
        , Svg.path [ d "M7 3h2v6H7z" ] []
        ]


{-|
  H2io logo in simple text format. Recommended.
-}
logo : Int -> StandardCss -> Html msg
logo size css =
    strong
        [ styles
            [ ( "all", "initial" )
            , ( "font-family", "'Fira Sans', sans-serif" )
            , ( "font-size", (toString (toFloat size) ++ "px") )
            , ( "font-weight", "bold" )
            , ( "color", "#379ac4" )
            , ( "display", "inline-block" )
            , ( "line-height", "1.3" )
            ]
            []
        , style css
        ]
        [ Html.text "[±]" ]


{-|
  Heading CSS
-}
heading : StandardCss
heading =
    [ ( "all", "initial" )
    , ( "display", "flex" )
    , ( "margin", "10px 0 25px" )
    , ( "font-family", "'Fira Sans', sans-serif" )
    , ( "font-size", "28px" )
    , ( "font-weight", "bold" )
    , ( "color", "#464b4d" )
    , ( "text-align", "center" )
    , ( "flex-wrap", "wrap" )
    , ( "justify-content", "center" )
    ]


{-|
  Button CSS
-}
button : StandardCss
button =
    [ ( "all", "initial" )
    , ( "background-color", "#008ac5" )
    , ( "background", "linear-gradient( to bottom, #0096d6 0%, #008ac5 50%, #008ac5 50%, #007eb4 100% )" )
    , ( "border", "1px solid #007eb4" )
    , ( "borderRadius", "6px" )
    , ( "display", "inline-block" )
    , ( "box-sizing", "border-box" )
    , ( "cursor", "pointer" )
    , ( "color", "#fcfcfc" )
    , ( "font-family", "'Fira Sans', sans-serif" )
    , ( "font-size", "16px" )
    , ( "padding", "10px" )
    , ( "text-align", "center" )
    , ( "font-weight", "bold" )
    , ( "text-decoration", "none" )
    , ( "position", "relative" )
    , ( "vertical-align", "text-bottom" )
    , ( "background-size", "100% 200%" )
    ]


{-|
  Button Inline Hover CSS
-}
buttonHover : StandardCss
buttonHover =
    [ ( "background-position", "0 99%" )
    , ( "outline", "none" )
    ]


{-|
  Disabled Button CSS
-}
buttonDisabled : StandardCss
buttonDisabled =
    [ ( "all", "initial" )
    , ( "opacity", "0.6" )
    , ( "cursor", "default" )
    , ( "padding-left", "40px" )
    , ( "transition", "padding .2s ease" )
    ]


{-|
  Button Spinner CSS
-}
buttonLoader : StandardCss
buttonLoader =
    [ ( "all", "initial" )
    , ( "position", "absolute" )
    , ( "width", "20px" )
    , ( "height", "20px" )
    , ( "box-sizing", "border-box" )
    , ( "border", "2px solid #fcfcfc" )
    , ( "border-right-color", "transparent" )
    , ( "top", "50%" )
    , ( "border-radius", "50%" )
    , ( "transform", "translate -50% -50%" )
    , ( "display", "inline-block" )
    , ( "left", "20px" )
    , ( "offset-inline-start", "20px" )
    , ( "margin-top", "-2px" )
    , ( "will-change", "transform" )
    , ( "animation", "rotate 1s linear infinite" )
    ]


{-|
  Input CSS
-}
input : StandardCss
input =
    [ ( "all", "initial" )
    , ( "display", "block" )
    , ( "box-sizing", "border-box" )
    , ( "font-family", "'Fira Sans', sans-serif" )
    , ( "border", "1px solid #b5b9bb" )
    , ( "font-size", "16px" )
    , ( "font-weight", "bold" )
    , ( "margin-right", "10px" )
    , ( "padding", "10px" )
    , ( "flex", "0 1 10%" )
    , ( "flex-flow", "wrap column" )
    ]


{-|
  Text CSS
-}
text : StandardCss
text =
    [ ( "all", "initial" )
    , ( "display", "block" )
    , ( "margin", "1em 0 0.1em" )
    , ( "font-family", "'Fira Sans', sans-serif" )
    , ( "font-size", "14px" )
    , ( "color", "#464b4d" )
    , ( "text-align", "center" )
    , ( "width", "100%" )
    ]
