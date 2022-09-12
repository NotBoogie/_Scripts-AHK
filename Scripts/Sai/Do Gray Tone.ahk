
;
;   Pre-select areas to NOT shade
;   Invert selection
;   Contract
;   Add folder
;   Add shade layer
;   Fill with black
;   Change opacity to like 25%
;   Add blush layer
;   Add hilight layer
;

#Include ..\Libraries\Sai.ahk
#Include ..\Libraries\ImageSearch.ahk

coordMode 
    , pixel

focusSai()

sleep 200

invertSelection()
erodeSelection()
newFolder()
renameLayer("Tone")
newLayer()
renameLayer("Gray")
fillLayer()

options := { image : "../../Resources/OpacitySlider.png"
           , from  : [ 0 , 0 ]
           , to    : [ a_screenWidth , a_screenHeight ] }

imageSearchc( fx , fy , options )

MouseClick 
    , left 
    ,  fx + 110 
    , fy + 20

newLayer()
renameLayer("Blush")
newLayer()
renameLayer("Hilights")
