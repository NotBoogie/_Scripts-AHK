;Layer renamer
;Goes up from the currently selected layer and renames all layers to [your input]-#

#Include ./SaiToolkit.ahk

topLayerHit := false
previousLayerName :=""
thisLayerName :=""
newLayerName := ""
counter := 1
baseLayerName := "Frame"

InputBox, baseLayerName, Enter Name, Enter layer base name (result will be "Basename-#"):, , 300, 150

focusSai()
While !topLayerHit{

			;Get the layer name
			pressButton(layerPropertiesKey)
			thisLayerName := getHighlighted()

			if(thisLayerName = previousLayerName){
				topLayerHit := true
				;MsgBox dsfgdfg %topLayerHit%
			}
			else
			{
				newLayerName := baseLayerName "-" counter
				;MsgBox %newLayerName%
				send %newLayerName%
				pressButton("Enter")
				goUpLayer()
				counter := counter+1
				;MsgBox thisLayerName %thisLayerName% previousLayerName %previousLayerName%
				previousLayerName := newLayerName
			}

			;Close properties pane
			;pressButton("Tab")
			;pressButton("Tab")
			pressButton(acceptKey)

;MsgBox topLayerHit %topLayerHit%

sleep, 150
     }

	 Esc::ExitApp