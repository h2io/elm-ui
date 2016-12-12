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


boxStyle : List Css.Mixin
boxStyle =
    [ property "all" "initial"
    , display block
    , boxSizing borderBox
    , position relative
    , property "z-index" "9"
    ]


contentStyle : List Css.Mixin
contentStyle =
    [ property "all" "initial"
    , backgroundColor (hex "fff")
    , display block
    , border3 (px 30) solid (hex "fff")
    , boxSizing borderBox
    , width (pct 100)
    , borderTop zero
    , borderBottom zero
    ]


clipTopLeft : List Css.Mixin
clipTopLeft =
    [ property "all" "initial"
    , border (px 30)
    , borderTop zero
    , borderColor (hex "fff")
    , borderStyle solid
    , boxSizing borderBox
    , display block
    , width (pct 100)
    , height zero
    , borderLeftColor transparent
    ]


clipBottomRight : List Css.Mixin
clipBottomRight =
    [ property "all" "initial"
    , border (px 30)
    , borderColor (hex "fff")
    , borderStyle solid
    , display block
    , boxSizing borderBox
    , width (pct 100)
    , height zero
    , borderBottom zero
    , borderRightColor transparent
    ]


styles : List Css.Mixin -> Html.Attribute msg
styles =
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
                    [ style
                        [ ( "all", "initial" )
                        , ( "position", "absolute" )
                        , ( "left", "-2px" )
                        , ( "right", "-2px" )
                        , ( "bottom", "-2px" )
                        , ( "top", "-2px" )
                        , ( "z-index", "-1" )
                        , ( "opacity", ".45" )
                        ]
                    ]
                    [ div
                        [ styles
                            (clipTopLeft
                                ++ [ border (px 31)
                                   , borderColor (hex "005a81")
                                   , borderLeftColor transparent
                                   , borderTop zero
                                   , width (pct 100)
                                   ]
                            )
                        ]
                        []
                    , div
                        [ styles
                            [ all initial
                            , display block
                            , property "height" "calc( 100% - 62px )"
                            , backgroundColor (hex "005a81")
                            , width (pct 100)
                            ]
                        ]
                        []
                    , div
                        [ styles
                            (clipBottomRight
                                ++ [ border (px 31)
                                   , borderColor (hex "005a81")
                                   , borderRightColor transparent
                                   , borderBottom zero
                                   , width (pct 100)
                                   ]
                            )
                        ]
                        []
                    ]
            else
                div [] []
    in
        div [ styles boxStyle, style css ]
            [ borderBox
            , span [ styles clipTopLeft ] []
            , div [ styles contentStyle ] [ content ]
            , span [ styles clipBottomRight ] []
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
            [ all initial
            , fontFamilies [ qt ("Fira Sans"), "sans-serif" ]
            , fontSize (px (toFloat size))
            , fontWeight bold
            , color (hex "379ac4")
            , display inlineBlock
            , lineHeight (num 1.3)
            ]
        , style css
        ]
        [ Html.text "[±]" ]


{-|
  Heading CSS
-}
heading : List Css.Mixin
heading =
    [ all initial
    , displayFlex
    , margin3 (px 10) zero (px 25)
    , fontFamilies [ qt ("Fira Sans"), "sans-serif" ]
    , fontSize (px 28)
    , fontWeight bold
    , color (hex "464b4d")
    , textAlign center
    , flexWrap wrap
    , property "justify-content" "center"
    ]


{-|
  Button CSS
-}
button : List Css.Mixin
button =
    [ all initial
    , backgroundColor (hex "008ac5")
    , property "background" "linear-gradient( to bottom, #0096d6 0%, #008ac5 50%, #008ac5 50%, #007eb4 100% )"
    , border3 (px 1) solid (hex "007eb4")
    , borderRadius (px 6)
    , display inlineBlock
    , boxSizing borderBox
    , cursor pointer
    , color (hex "fcfcfc")
    , fontFamilies [ (qt "Fira Sans"), "sans-serif" ]
    , fontSize (px 16)
    , padding (px 10)
    , textAlign center
    , fontWeight bold
    , textDecoration none
    , position relative
    , verticalAlign textBottom
    , property "background-size" "100% 200%"
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
buttonDisabled : List Css.Mixin
buttonDisabled =
    [ all initial
    , opacity (num 0.6)
    , cursor default
    , paddingLeft (px 40)
    , property "transition" "padding .2s ease"
    ]


{-|
  Button Spinner CSS
-}
buttonLoader : List Css.Mixin
buttonLoader =
    [ all initial
    , position absolute
    , width (px 20)
    , height (px 20)
    , boxSizing borderBox
    , border3 (px 2) solid (hex "fcfcfc")
    , borderRightColor transparent
    , top (pct 50)
    , borderRadius (pct 50)
    , transform (translate2 (pct -50) (pct -50))
    , display inlineBlock
    , left (px 20)
    , marginTop (px -2)
    , property "will-change" "transform"
    , property "animation" "rotate 1s linear infinite"
    ]


{-|
  Input CSS
-}
input : List Css.Mixin
input =
    [ all initial
    , display block
    , boxSizing borderBox
    , fontFamilies [ (qt "Fira Sans"), "sans-serif" ]
    , border3 (px 1) solid (hex "b5b9bb")
    , fontSize (px 16)
    , fontWeight bold
    , marginRight (px 10)
    , padding (px 10)
    , flex3 zero (int 1) (pct 10)
    , flexFlow2 wrap column
    ]


{-|
  Text CSS
-}
text : List Css.Mixin
text =
    [ all initial
    , display block
    , margin3 (em 1) zero (em 0.1)
    , fontFamilies [ (qt "Fira Sans"), "sans-serif" ]
    , fontSize (px 14)
    , color (hex "464b4d")
    , textAlign center
    , width (pct 100)
    ]
