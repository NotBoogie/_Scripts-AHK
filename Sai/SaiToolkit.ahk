
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
global exportPngKey := "F8"
global erodeSelectionKey := "F7"
global invertSelectionKey := "F6"
global newLayerKey := "F10"
global newFolderKey := "F9"
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

;https://github.com/Masonjar13/AHK-Library
;TODO figure out if I can put this into the standard library and still have it be accessable for others
imageSearchc(byRef out1,byRef out2,x1,y1,x2,y2,image,vari:=0,trans:="",direction:=5,debug:=0){
	static ptok:=gdip_startup()
	imageB:=gdip_createBitmapFromFile(image)
	scrn:=gdip_bitmapfromscreen(x1 "|" y1 "|" x2 - x1 "|" y2 - y1)
	if(debug)
		gdip_saveBitmapToFile(scrn,a_now ".png")
	errorlev:=gdip_imageSearch(scrn,imageB,tempxy,0,0,0,0,vari,trans,direction)
	gdip_disposeImage(scrn)
	gdip_disposeImage(imageB)

	if (errorlev) {
		out:=strSplit(tempxy,"`,")
		out1:=out[1] + x1
		out2:=out[2] + y1
		return % errorlev
	}
	return 0
}