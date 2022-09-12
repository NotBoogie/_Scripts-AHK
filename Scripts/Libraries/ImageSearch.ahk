
#Include %A_LineFile%\..\Gdip.ahk
#Include %A_LineFile%\..\Gdip_ImageSearch.ahk

;   https://github.com/Masonjar13/AHK-Library
;   TODO figure out if I can put this into the standard library and still have it be accessable for others

imageSearchc( byRef out1 , byRef out2 , options ){
    
    from = options.from
    to = options.to
    
    Ax = from[0]
    Ay = from[1]
    
    Bx = to[0]
    By = to[1]
    
	static ptok := gdip_startup()
    
	fileMap := gdip_createBitmapFromFile(options.image)
    screenMap := gdip_bitmapfromscreen( Ax "|" Ay "|" Bx - Ax "|" By - Ay )
	
    if(options.debug)
		gdip_saveBitmapToFile(screenMap,a_now ".png")
	
    error := gdip_imageSearch( screenMap 
        , fileMap 
        , tempxy 
        , 0 , 0 , 0 , 0 
        , options.vari || 0 
        , options.trans || "" 
        , options.direction || 5 )
	
    gdip_disposeImage(screenMap)
	gdip_disposeImage(fileMap)

	if(error){
		out := strSplit( tempxy , "`," )
		out1 := out[1] + Ax
		out2 := out[2] + Ay
		return % error
	}
    
	return 0
}
