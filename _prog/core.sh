##### Core


# 0000 (0) = NULL (string termination, do not emit characters at positions set NULL)
# 0001 (1) = 0-9
# 0010 (2) = a-z
# 0100 (4) = A-Z
# 1000 (8) = '%' IF NOT last character, ELSE '?'
# 
# 0011 (3) = a-z0-9
# 0101 (5) = A-Z0-9
# 0111 (7) = a-zA-Z0-9

_s() {
	#BARCODE - basic ONLY. Normally this is the ONLY bitmask to change, and ONLY to address (discouraged) tradeoffs with specialized software.
	[[ "$1" != "" ]] && export barcode_bitmask="$1"
	[[ "$barcode_bitmask" == "" ]] && export barcode_bitmask=33333333333333
	[[ "$barcode_filter" == "" ]] && export barcode_filter="cat"
	#[[ "$barcode_bitmask" == "" ]] && export barcode_bitmask=111111111111111111111111
	#[[ "$barcode_filter" == "" ]] && export barcode_filter="cat"
	
	#DANGER: Strongly discouraged. Low entropy, for very specialized use only.
	#[[ "$barcode_bitmask" == "" ]] && export barcode_bitmask=111111111111111
	#[[ "$barcode_filter" == "" ]] && export barcode_filter="cat"
	
	
	
	#MAGSWIPE SEED. No normal reason to change this.
	[[ "$2" != "" ]] && export magswipe_bitmask="$2"
	[[ "$magswipe_bitmask" == "" ]] && export magswipe_bitmask=5555555555555555555555555
	[[ "$magswipe_filter" == "" ]] && export magswipe_filter="_extractEntropy-bitmask-FILTER"
	#[[ "$magswipe_bitmask" == "" ]] && export magswipe_bitmask=55555555555555555555
	#[[ "$magswipe_filter" == "" ]] && export magswipe_filter="cat"
	
	# WiFi SEED. No normal reason to change this.
	[[ "$3" != "" ]] && export qrcode_bitmask="$3"
	[[ "$qrcode_bitmask" == "" ]] && export qrcode_bitmask=833333333333333333333338
	[[ "$qrcode_bitmask" == "" ]] && export qrcode_filter="_extractEntropy-bitmask-FILTER"
	#[[ "$qrcode_bitmask" == "" ]] && export qrcode_bitmask=83333333333333333338
	#[[ "$qrcode_filter" == "" ]] && export qrcode_filter="cat"
	
	
	#BARCODE SEED. No normal reason to change this.
	[[ "$4" != "" ]] && export barcode_bitmask_seed="$4"
	[[ "$barcode_bitmask_seed" == "" ]] && export barcode_bitmask_seed=77777777777777
	[[ "$barcode_bitmask_seed_filter" == "" ]] && export barcode_bitmask_seed_filter="cat"
	
	true
}


# ^

# NOTICE: DANGER: Minimum examples. Do NOT generate less entropy than offered here.

# DEFAULT WiFi SEED
#  QRCODE/MAGSWIPE EQUIVALENT.
# entropy 2^93.06
#qrcode_bitmask=83333333333333333338
#qrcode=%AAAA1AAAAA1A1A1AAA?
#magswipe=$(echo -n "$barcode" | tr 'a-z' 'A-Z' | tr -dc 'a-z0-9')


# DEFAULT MAGSWIPE SEED (as either independent 'sub' or combined with BARCODE).
#  BARCODE/MAGSWIPE NOT equivalent, MAGSWIPE ONLY.
# entropy 2^103.4
#magswipe_bitmask=55555555555555555555
#magswipe=AAAA1AAAAA1A1A1AAAAA

# DEFAULT BARCODE SEED (as either independent 'sub' or combined with MAGSWIPE).
# KDF strengthening may use this adequately.
# Fewer keystrokes.
#  BARCODE/MAGSWIPE NOT equivalent, BARCODE/TEXT ONLY.
# entropy 2^83.36
#barcode_bitmask=77777777777777
#barcode=AaAAAaA1AaAAaA


# Online manager for passwords with KDF strengthening may use this adequately. ### Preferable PIN+KDF/HardwareTPM .
# Fewer keystrokes.
#  BARCODE/MAGSWIPE EQUIVALENCE REWRITE (ie. use BARCODE characters to rewrite, MAGSWIPE will add '%' , '?').
# entropy 2^72.38
#barcode_bitmask=33333333333333
#barcode=a11aaa1aa1aaaa
#magswipe=$(echo -n "$barcode" | tr 'a-z' 'A-Z' | tr -dc 'a-z0-9')

# KDF strengthening may use this adequately.
# Online manager for passwords with KDF strengthening may use this adequately.
#  BARCODE/MAGSWIPE EQUIVALENCE REWRITE (ie. use BARCODE characters to rewrite, MAGSWIPE will add '%' , '?').
# entropy ~2^79.73 , ~10^24 , 2^(79.73 + 19) ≈ ~10^29
#barcode_bitmask=111111111111111111111111
#barcode=111111111111111111111111
#magswipe=$(echo -n "$barcode" | tr 'a-z' 'A-Z' | tr -dc 'a-z0-9')



# Online password. Entropy NOT sufficient to more than delay misuse if offline searchable (ie. published login hashes from compromised server).
# Complies with common password 'requirements'.
#  BARCODE/MAGSWIPE EQUIVALENCE LIMITED. Magswipe requires manually typed character.
#  entropy ~2^62.04 , ~10^18 , 2^(62.04 + 19) ≈ ~10^24
#barcode_bitmask=48333333333338
#barcode=A%aaa1a1aa1aa?
#magswipe=$(echo -n "$barcode" | tr 'a-z' 'A-Z' | tr -dc 'a-z0-9')



# PIN+KDF possibility expansion. May frustrate misuse if HardwareTPM protected storage of intermediates is exposed (but not if protected storage for a header to a volume is exposed). ### Numeric ONLY PIN+KDF/HardwareTPM .
# entropy ~2^49.83 , ~10^15 , 2^(49.83 + 19) ≈ ~10^20
#  BARCODE/MAGSWIPE EQUIVALENCE REWRITE (ie. use BARCODE characters to rewrite, MAGSWIPE will add '%' , '?').
#barcode_bitmask=111111111111111
#barcode=111111111111111
#magswipe=$(echo -n "$barcode" | tr 'a-z' 'A-Z' | tr -dc 'a-z0-9')





_extractEntropyAlpha_bin() {
	local currentPath_bin
	
	currentPath_bin="$HOME"/core/infrastructure/coreoracle/pairKey
	if [[ -e "$currentPath_bin" ]]
	then
		"$currentPath_bin" "$@"
		return
	fi
	
	
	if _if_cygwin
	then
		currentPath_bin=/cygdrive/c/core/infrastructure/coreoracle/pairKey
		if [[ -e "$currentPath_bin" ]]
		then
			"$currentPath_bin" "$@"
			return
		fi
		
		currentPath_bin=/cygdrive/c/core/infrastructure/extendedInterface/_lib/coreoracle-msw/pairKey
		if [[ -e "$currentPath_bin" ]]
		then
			"$currentPath_bin" "$@"
			return
		fi
		
		currentPath_bin=/cygdrive/c/core/infrastructure/extendedInterface/_lib/coreoracle/pairKey
		if [[ -e "$currentPath_bin" ]]
		then
			"$currentPath_bin" "$@"
			return
		fi
	fi
	
	
	_stop 1
	exit 1
	return 1
}





_extractEntropy-bitmask-FILTER_SUBSTITUTE_ambigious() {
	tr '15680blBDIOSUV' '23479abACEFGHJ'
}
_extractEntropy-bitmask-FILTER_REMOVE_ambigious() {
	tr -dc '15680blBDIOSUV'
}
_extractEntropy-bitmask-FILTER() {
	_extractEntropy-bitmask-FILTER_REMOVE_ambigious "$@"
}
_extractEntropy-bitmask() {
	local current_filter
	current_filter="$2"
	[[ "$current_filter" == "" ]] && current_filter="cat"
	
	local current_bitmask
	local currentIteration
	for currentIteration in $(seq 1 24);
	do
		current_bitmask=$(_safeEcho "$1" | tr -dc '0-9' | head -c "$currentIteration" | tail -c 1)
		
		if [[ "$currentIteration" -le $(_safeEcho "$1" | wc -c | tr -dc '0-9') ]]
		then
			case "$current_bitmask" in
				0)
					true
					;;
				1)
					_extractEntropyAlpha_bin _extractEntropyBin 10000000000 | base64 | tr -dc '0-9' | head -c 1
					;;
				2)
					_extractEntropyAlpha_bin _extractEntropyBin 10000000000 | base64 | tr -dc 'a-z' | head -c 1
					;;
				4)
					_extractEntropyAlpha_bin _extractEntropyBin 10000000000 | base64 | tr -dc 'A-Z' | head -c 1
					;;
				8)
					if [[ "$currentIteration" -lt $(_safeEcho "$1" | wc -c | tr -dc '0-9') ]] && [[ "$currentIteration" -lt "24" ]]
					then
						_extractEntropyAlpha_bin _extractEntropyBin 10000000000 | tr -dc '%' | head -c 1
					else
						_extractEntropyAlpha_bin _extractEntropyBin 10000000000 | tr -dc '?' | head -c 1
					fi
					;;
				3)
					_extractEntropyAlpha_bin _extractEntropyBin 10000000000 | base64 | tr -dc 'a-z0-9' | head -c 1
					;;
				5)
					_extractEntropyAlpha_bin _extractEntropyBin 10000000000 | base64 | tr -dc 'A-Z0-9' | head -c 1
					;;
				7)
					_extractEntropyAlpha_bin _extractEntropyBin 10000000000 | base64 | tr -dc 'a-zA-Z0-9' | head -c 1
					;;
			esac
		fi
	done
	
	
	
	
	
	
}




_seed-wifi-card() {
	_messageNormal ${FUNCNAME[0]}
	_s
	
	local current_SSID
	current_SSID="$1"
	
	local current_security
	current_security="$2"
	
	[[ "$current_security" == "" ]] && current_security=$(_extractEntropy-bitmask "$qrcode_bitmask" "$qrcode_filter")
	
	_seed-wifi "$current_SSID" "$current_security"
	
	_seed-wifi-magswipe $(echo -n "$current_security" | tr 'a-z' 'A-Z' | tr -dc '0-9A-Z' )
}
_wifi-card() {
	_seed-wifi-card "$@"
}





_seed() {
	_messageNormal ${FUNCNAME[0]}
	_s
	
	_seed-barcode "$@"
	
	_seed-magswipe "$@"
}




_legacy() {
	_messageNormal ${FUNCNAME[0]}
	_s
	
	_legacy-barcode "$@"
	
	_legacy-magswipe $(echo -n "$1" | tr 'a-z' 'A-Z' | tr -dc '0-9A-Z' )
}


_basic() {
	_messageNormal ${FUNCNAME[0]}
	_s
	
	local current_text
	current_text=$(_safeEcho_newline "$@")
	
	[[ "$current_security" == "" ]] && current_security=$(_extractEntropy-bitmask "$barcode_bitmask" "$barcode_filter")
	
	_messagePlain_nominal _basic-barcode
	_basic-barcode_procedure "$current_text"
	#_basic-barcode "$current_text"
	
	_basic-magswipe $(echo -n "$current_security" | tr 'a-z' 'A-Z' | tr -dc '0-9A-Z' )
}






_refresh_anchors() {
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_print
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_label
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_tear
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_qr
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_barcode
	
	
	
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_seed-wifi
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_wifi
	
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_seed-wifi-card
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_wifi-card
	
	
	
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_seed.bat
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_seed-barcode.bat
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_seed-magswipe.bat
	
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_basic.bat
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_basic-barcode.bat
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_basic-magswipe.bat
	
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_legacy.bat
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_legacy-barcode.bat
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_legacy-magswipe.bat
}


