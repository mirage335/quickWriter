##### Core


_rand_bin() {
	local currentPath_bin
	
	currentPath_bin="$HOME"/core/infrastructure/coreoracle/pairKey
	if [[ -e "$currentPath_bin" ]]
	then
		"$currentPath_bin" _rand "$@"
		return
	fi
	
	
	if _if_cygwin
	then
		currentPath_bin=/cygdrive/c/core/infrastructure/coreoracle/pairKey
		if [[ -e "$currentPath_bin" ]]
		then
			"$currentPath_bin" _rand "$@"
			return
		fi
		
		currentPath_bin=/cygdrive/c/core/infrastructure/extendedInterface/_lib/coreoracle-msw/pairKey
		if [[ -e "$currentPath_bin" ]]
		then
			"$currentPath_bin" _rand "$@"
			return
		fi
		
		currentPath_bin=/cygdrive/c/core/infrastructure/extendedInterface/_lib/coreoracle/pairKey
		if [[ -e "$currentPath_bin" ]]
		then
			"$currentPath_bin" _rand "$@"
			return
		fi
	fi
	
	
	_stop 1
	exit 1
	return 1
}







_seed() {
	echo test
}









_refresh_anchors() {
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_seed.bat
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_seed-barcode.bat
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_seed-magswipe.bat
	
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_basic.bat
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_basic-barcode.bat
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_basic-magswipe.bat
	
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_seed-wifi.bat
}


