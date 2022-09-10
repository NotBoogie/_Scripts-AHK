
;   SaiToolkit

#SingleInstance Force

CoordMode, Mouse, Screen
CoordMode, Pixel, Screen


;   Define globals

global layerPropertiesKey := "F5"
global invertSelectionKey := "F6"
global showAloneLayerKey := "F4"
global erodeSelectionKey := "F7"
global backwardLayerKey := "F3"
global forwardLayerKey := "F1"
global exportPngKey := "F8"
global newFolderKey := "F9"
global newLayerKey := "F10"
global acceptKey := "Enter"
global fillKey := "F12"

;exportCurrent("test")


renameLayer(newName){
	
    pressButton(layerPropertiesKey)
	
    Sleep 50
	
    thisLayerName := getHighlighted()
	
    send %newName%
	
    pressButton(acceptKey)
}

fillLayer(){
	pressButton(fillKey)
}

newLayer(){
	pressButton(newLayerKey)
}

newFolder(){
	pressButton(newFolderKey)
}

invertSelection(){
	pressButton(invertSelectionKey)
}

erodeSelection(){

	pressButton(erodeSelectionKey)

	Sleep 100

	pressButton(acceptKey)
}

exportCurrent( fileName := "" ){
	
    focusSai()
	ctrlDown()
	pressButton(exportPngKey)
	ctrlUp()
	
    Sleep 100
	
    if(fileName != "")
		Send %fileName%
	
    pressButton(acceptKey)
    
	Sleep 500
	
    WinGetTitle , title , Confirm
	
    if(title == "Confirm Save As"){
	
    	pressButton("Tab")
	
    	Sleep 100
	
    	pressButton(acceptKey)
	}
    
	Sleep 1000
}

showAloneLayer(){
	pressButton(showAloneLayerKey)
}

getCurrentLayerName(){
    
	result := ""
	
    focusSai()
	pressButton(layerPropertiesKey)
	
    result := getHighlighted()
	
    pressButton("Tab")
	pressButton("Tab")
	pressButton(acceptKey)
	
    return result
}


;   Uses the clipboard to get 
;   whatever's currently highlighted

getHighlighted(){
	
    ;   Save clipboard
    
    clipsaved := clipboard
 	
    ;   Erase clipboard
    
    clipboard := ""	
	
    ;   Set clipboard
    
    Send , ^c
	
    ;   Wait so Windows can process
    
    Sleep 200
	
    ;   Get Clipboard contents
    
    clipsaved2 := clipboard
 	
    ;   Reset clipboard back to what it was before
    
    clipboard := clipsaved
	
    Sleep 200
	
    ;   Return whatever text was highlighted
    
    return clipsaved2
}

focusSai(){
	WinActivate , PaintTool SAI
}

shiftDown(){
    Send , { Shift Down }
}

shiftUp(){
    Send , { Shift Up }
}

ctrlDown(){
    Send , { Ctrl Down}
}

ctrlUp(){
    Send , { Ctrl Up }
}

pressButton( button ){
    
    Send , { %button% Down }
    
    Sleep 50
    
    Send , { %button% Up }
}

goUpLayer(){
	pressButton(forwardLayerKey)
}


;   https://github.com/Masonjar13/AHK-Library
;   TODO figure out if I can put this into the standard library and still have it be accessable for others

imageSearchc(
    byRef out1 , byRef out2 , 
    Ax , Ay , Bx , By , 
    image , 
    vari := 0 ,
    trans := "" ,
    direction := 5 ,
    debug := 0
){
    
	static ptok := gdip_startup()
    
	fileMap := gdip_createBitmapFromFile(image)
    screenMap := gdip_bitmapfromscreen( Ax "|" Ay "|" Bx - Ax "|" By - Ay )
	
    if(debug)
		gdip_saveBitmapToFile(screenMap,a_now ".png")
	
    error := gdip_imageSearch(
        screenMap , fileMap , tempxy ,
        0 , 0 , 0 , 0 , vari , trans , 
        direction
    )
	
    gdip_disposeImage(screenMap)
	gdip_disposeImage(fileMap)

	if(error){
		out := strSplit(tempxy,"`,")
		out1 := out[1] + Ax
		out2 := out[2] + Ay
		return % error
	}
    
	return 0
}
