
;SaiToolkit
#SingleInstance Force
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
;Define globals
global acceptKey := "Enter"
global forwardLayerKey := "F1"
global backwardLayerKey := "F3"
global showAloneLayerKey := "F4"
global layerPropertiesKey := "F5"
global exportPngKey := "F7"
;exportCurrent("test")

exportCurrent(fileName := ""){
	focusSai()
	ctrlDown()
	pressButton(exportPngKey)
	ctrlUp()
	Sleep 100
	if(fileName != "")
		Send %fileName%
	pressButton(acceptKey)
	Sleep 500
	WinGetTitle, title, Confirm
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

;Uses the clipboard to get whatever's currently highlighted
getHighlighted(){
	clipsaved:= clipboard	;Save clipboard
 	clipboard := ""	;Erase clipboard
	Send, ^c    ;Set clipboard
	Sleep 200    ;Wait so Windows can process
	clipsaved2 := clipboard	;Get Clipboard contents
 	clipboard := clipsaved    ;Reset clipboard back to what it was before
	Sleep 200
	return clipsaved2	;Return whatever text was highlighted
}

focusSai(){
	WinActivate, PaintTool SAI
}
shiftDown(){
Send, {Shift Down}
}
shiftUp(){
Send, {Shift Up}
}
ctrlDown(){
Send, {Ctrl Down}
}
ctrlUp(){
Send, {Ctrl Up}
}
pressButton(butt){
    Send, {%butt% Down}
    Sleep 50
    Send, {%butt% Up}
}
goUpLayer(){
	pressButton(forwardLayerKey)
}