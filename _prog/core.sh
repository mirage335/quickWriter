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
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_seed
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_seed-barcode
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_seed-magswipe
	
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_basic
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_basic-barcode
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_basic-magswipe
	
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_seed-wifi
}


