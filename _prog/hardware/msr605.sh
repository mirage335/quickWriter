

_set_msr605() {
	true
}



# WARNING: Function '_interact' must NOT be defined within compressed_functions (or similar) !
# WARNING: Function '_interact' must NOT be defined within compressed_functions (or similar) !
_interact-magswipe() {
	#source "$scriptLib"/msr605-python/venv_python/bin/activate
	
	_set_msr605
	
	#"$scriptLib"/msr605-python/magswipe.py '_python()'
	"$scriptLib"/msr605-python/magswipe.py '_interact_magswipe()'
}


_seed-wifi-magswipe_sequence() {
	_start
	
	
	_s
	
	local current_content
	current_content="$1"
	
	[[ "$current_content" == "" ]] && current_content=$(_extractEntropy-bitmask "$qrcode_bitmask" "$qrcode_filter")
	
	
	local current_content_track1
	current_content_track1="$current_content"
	
	local current_content_track2
	current_content_track2=''
	
	local current_content_track3
	current_content_track3=''
	
	
	
	
	#source "$scriptLib"/msr605-python/venv_python/bin/activate
	
	_set_msr605
	
	_messagePlain_probe '"$scriptAbsoluteLocation"' _abstractfs "$scriptLib"/msr605-python/magswipe.py '_seed("     ", "     ", "     ")'
	
	(sleep 2 ; _messagePlain_request 'request: swipe magswipe card') &
	
	#_messagePlain_probe_cmd
	"$scriptLib"/msr605-python/magswipe.py '_seed("'"$current_content_track1"'", "'"$current_content_track2"'", "'"$current_content_track3"'")'
	
	_stop
}
_seed-wifi-magswipe() {
	_messagePlain_nominal ${FUNCNAME[0]}
	"$scriptAbsoluteLocation" _seed-wifi-magswipe_sequence "$@"
}



_seed-magswipe_sequence() {
	_start
	
	
	_s
	
	local current_content
	#current_content="$1"
	
	#[[ "$current_content" == "" ]] && 
	current_content=$(_extractEntropy-bitmask "$magswipe_bitmask" "$magswipe_filter")
	
	
	local current_content_track1
	current_content_track1="$current_content"
	
	local current_content_track2
	current_content_track2=''
	
	local current_content_track3
	current_content_track3=''
	
	
	
	
	#source "$scriptLib"/msr605-python/venv_python/bin/activate
	
	_set_msr605
	
	_messagePlain_probe '"$scriptAbsoluteLocation"' _abstractfs "$scriptLib"/msr605-python/magswipe.py '_seed("     ", "     ", "     ")'
	
	(sleep 2 ; _messagePlain_request 'request: swipe magswipe card') &
	
	#_messagePlain_probe_cmd
	"$scriptLib"/msr605-python/magswipe.py '_seed("'"$current_content_track1"'", "'"$current_content_track2"'", "'"$current_content_track3"'")'
	
	_stop
}
_seed-magswipe() {
	_messagePlain_nominal ${FUNCNAME[0]}
	"$scriptAbsoluteLocation" _seed-magswipe_sequence "$@"
}




# DANGER: Strongly discouraged.
_legacy-magswipe_sequence() {
	_start
	
	
	_s
	
	local current_content
	current_content="$1"
	
	[[ "$current_content" == "" ]] && current_content=$(_extractEntropy-bitmask "$magswipe_bitmask" "$magswipe_filter")
	
	
	local current_content_track1
	current_content_track1="$current_content"
	
	local current_content_track2
	current_content_track2=''
	
	local current_content_track3
	current_content_track3=''
	
	
	
	
	#source "$scriptLib"/msr605-python/venv_python/bin/activate
	
	_set_msr605
	
	_messagePlain_probe '"$scriptAbsoluteLocation"' _abstractfs "$scriptLib"/msr605-python/magswipe.py '_seed("     ", "     ", "     ")'
	
	(sleep 2 ; _messagePlain_request 'request: swipe magswipe card') &
	
	#_messagePlain_probe_cmd
	"$scriptLib"/msr605-python/magswipe.py '_seed("'"$current_content_track1"'", "'"$current_content_track2"'", "'"$current_content_track3"'")'
	
	_stop
}
_legacy-magswipe() {
	_messagePlain_nominal ${FUNCNAME[0]}
	"$scriptAbsoluteLocation" _legacy-magswipe_sequence "$@"
}



_basic-magswipe_sequence() {
	_start
	
	
	_s
	
	local current_content
	current_content="$1"
	
	[[ "$current_content" == "" ]] && current_content=$(_extractEntropy-bitmask "$barcode_bitmask" "$barcode_filter")
	
	
	local current_content_track1
	current_content_track1="$current_content"
	
	local current_content_track2
	current_content_track2=''
	
	local current_content_track3
	current_content_track3=''
	
	
	
	
	#source "$scriptLib"/msr605-python/venv_python/bin/activate
	
	_set_msr605
	
	_messagePlain_probe '"$scriptAbsoluteLocation"' _abstractfs "$scriptLib"/msr605-python/magswipe.py '_seed("     ", "     ", "     ")'
	
	(sleep 2 ; _messagePlain_request 'request: swipe magswipe card') &
	
	#_messagePlain_probe_cmd
	"$scriptLib"/msr605-python/magswipe.py '_seed("'"$current_content_track1"'", "'"$current_content_track2"'", "'"$current_content_track3"'")'
	
	_stop
}
_basic-magswipe() {
	_messagePlain_nominal ${FUNCNAME[0]}
	"$scriptAbsoluteLocation" _basic-magswipe_sequence "$@"
}



_erase-magswipe() {
	#source "$scriptLib"/msr605-python/venv_python/bin/activate
	
	_set_msr605
	
	_messagePlain_probe '"$scriptAbsoluteLocation"' _abstractfs "$scriptLib"/msr605-python/magswipe.py '_erase()'
	
	(sleep 2 ; _messagePlain_request 'request: swipe magswipe card') &
	
	#_messagePlain_probe_cmd
	"$scriptLib"/msr605-python/magswipe.py '_erase()'
}
_erase() {
	_erase-magswipe "$@"
}

