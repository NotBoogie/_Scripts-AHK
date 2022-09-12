
;
;   Layer exporter
;
;   Go up from current layer until top layer is reached
;
;   Detect top layer by scraping the layer name from the
;   clipboard? and when it's the same one twice then end?
;


#Include ..\Libraries\Sai.ahk


previousLayerName := ""
baseLayerName := "Frame-"
thisLayerName := ""
newLayerName := ""
topLayerHit := false
counter := 1

focusSai()
showAloneLayer()

While ! topLayerHit {

    ;   Get the layer name

    ;pressButton(layerPropertiesKey)
    thisLayerName := getCurrentLayerName()

    if(thisLayerName = previousLayerName){
        
        topLayerHit := true
        
        ;MsgBox dsfgdfg %topLayerHit%

    } else {

        exportCurrent(thisLayerName)
        previousLayerName := thisLayerName
        goUpLayer()
    }

    ;MsgBox topLayerHit %topLayerHit%

    sleep , 150
}

Esc::ExitApp
