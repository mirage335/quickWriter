


_set_LinePrinter() {
	export current_LinePrinter_devfile=""
	unset current_LinePrinter_devfile
	
	export current_LinePrinter_devfile=/dev/ttyS1
	[[ "$OVERRIDE_LinePrinter_devfile" != "" ]] && export current_LinePrinter_devfile="$OVERRIDE_LinePrinter_devfile"
	
	export current_LinePrinter_baud=38400
	#export current_LinePrinter_baud=115200
	[[ "$OVERRIDE_LinePrinter_baud" != "" ]] && export current_LinePrinter_devfile="$OVERRIDE_LinePrinter_baud"
	
	stty -F "$current_LinePrinter_devfile" "$current_LinePrinter_baud"
}



# WARNING: Function '_interact' must NOT be defined within compressed_functions (or similar) !
_interact-escpos() {
	source "$scriptLib"/escpos-python/venv_python/bin/activate
	
	_set_LinePrinter
	
	_s

	local functionEntryPWD="$PWD"
	cd "$scriptLib"/escpos-python
	
	#"$scriptAbsoluteLocation" _abstractfs "$scriptLib"/escpos-python/print.py '_python()'
	"$scriptAbsoluteLocation" _abstractfs "$scriptLib"/escpos-python/print.py '_interact_escpos("'"$current_LinePrinter_devfile"'", '"$current_LinePrinter_baud"')'
	
	cd "$functionEntryPWD"
}







_qr_sequence() {
  _start
  
  local current_content
  current_content=$(_safeEcho_newline "$@")
  
  #source "$scriptLib"/escpos-python/venv_python/bin/activate
  
  _set_LinePrinter
  
  #_s
  
  local functionEntryPWD="$PWD"
  cd "$scriptLib"/escpos-python
  
  _messagePlain_probe '"$scriptAbsoluteLocation"' _abstractfs "$scriptLib"/escpos-python/print.py '_qr("     ", "'"$current_LinePrinter_devfile"'", '"$current_LinePrinter_baud"')'
  
  #_messagePlain_probe_cmd
  "$scriptAbsoluteLocation" _abstractfs "$scriptLib"/escpos-python/print.py '_qr("'"$current_content"'", "'"$current_LinePrinter_devfile"'", '"$current_LinePrinter_baud"')'
  
  cd "$functionEntryPWD"
  _stop
}

_qr() {
  _messagePlain_nominal ${FUNCNAME[0]}
  "$scriptAbsoluteLocation" _qr_sequence "$@"
}



# "$1" == SSID
# "$2" == security
_seed-wifi() {
	_messagePlain_nominal ${FUNCNAME[0]}
	# https://pocketables.com/2022/01/how-to-format-that-wifi-qr-code-in-plain-text.html
	# 'WIFI:S:'"$1"';T:WPA;P:'"$2"';H:<true|false|blank>;;'
	# 'WIFI:S:'"$1"';T:WPA;P:'"$2"';;'
	
	_set_LinePrinter
	
	_s
	
	local functionEntryPWD="$PWD"
	cd "$scriptLib"/escpos-python
	
	local current_SSID
	current_SSID="$1"
	
	local current_security
	current_security="$2"
	
	[[ "$current_security" == "" ]] && current_security=$(_extractEntropy-bitmask "$qrcode_bitmask" "$qrcode_filter")
	
	_messagePlain_probe '"$scriptAbsoluteLocation"' _abstractfs "$scriptLib"/escpos-python/print.py '_qr("     ", "'"$current_LinePrinter_devfile"'", '"$current_LinePrinter_baud"')'
	
	#_messagePlain_probe_cmd
	"$scriptAbsoluteLocation" _abstractfs "$scriptLib"/escpos-python/print.py '_qr("WIFI:S:'"$current_SSID"';T:WPA;P:'"$current_security"';;", "'"$current_LinePrinter_devfile"'", '"$current_LinePrinter_baud"', "WiFi: '"$current_SSID"' '"$current_security"'")'
	
	#_qr 'WIFI:S:'"$current_SSID"';T:WPA;P:'"$current_security"';;'
	
	cd "$functionEntryPWD" 
}
_wifi() {
	_seed-wifi "$@"
}




# NOTICE: STRONGLY DISCOURAGED.
_barcode_sequence() {
  _start
  
  local current_content
  current_content=$(_safeEcho_newline "$@")
  
  #source "$scriptLib"/escpos-python/venv_python/bin/activate
  
  _set_LinePrinter
  
  #_s
  
  local functionEntryPWD="$PWD"
  cd "$scriptLib"/escpos-python
  
  _messagePlain_probe '"$scriptAbsoluteLocation"' _abstractfs "$scriptLib"/escpos-python/print.py '_barcode("     ", "'"$current_LinePrinter_devfile"'", '"$current_LinePrinter_baud"')'
  
  #_messagePlain_probe_cmd
  "$scriptAbsoluteLocation" _abstractfs "$scriptLib"/escpos-python/print.py '_barcode("'"$current_content"'", "'"$current_LinePrinter_devfile"'", '"$current_LinePrinter_baud"')'
  
  cd "$functionEntryPWD"

  _stop
}

_barcode() {
  _messagePlain_nominal ${FUNCNAME[0]}
  "$scriptAbsoluteLocation" _barcode_sequence "$@"
}



_seed-barcode_sequence() {
	_start
	
	local current_text
	current_text=$(_safeEcho_newline "$@")
	
	#source "$scriptLib"/escpos-python/venv_python/bin/activate
	
	_set_LinePrinter
	
	#_s

	local functionEntryPWD="$PWD"
	cd "$scriptLib"/escpos-python

	local current_content
	#current_content=$(_extractEntropy-bitmask "$barcode_bitmask" "$barcode_filter")
	current_content=$(_extractEntropy-bitmask "$barcode_bitmask_seed" "$barcode_bitmask_seed_filter")
	
	_messagePlain_probe '"$scriptAbsoluteLocation"' _abstractfs "$scriptLib"/escpos-python/print.py '_seed("     ", "'"$current_LinePrinter_devfile"'", '"$current_LinePrinter_baud"', "     ")'
	
	#_messagePlain_probe_cmd
	"$scriptAbsoluteLocation" _abstractfs "$scriptLib"/escpos-python/print.py '_seed("'"$current_content"'", "'"$current_LinePrinter_devfile"'", '"$current_LinePrinter_baud"', "'"$current_text"'")'
	
	cd "$functionEntryPWD"
	
	_stop
}

_seed-barcode() {
	_messagePlain_nominal ${FUNCNAME[0]}
	"$scriptAbsoluteLocation" _seed-barcode_sequence "$@"
}




# DANGER: Strongly discouraged.
_legacy-barcode_sequence() {
	_start

	local current_content
	current_content="$1"
	#current_content='%'"$current_content"'?'
	shift
	
	local current_text
	current_text=$(_safeEcho_newline "$@")
	
	#source "$scriptLib"/escpos-python/venv_python/bin/activate
	
	_set_LinePrinter
	
	_s

	local functionEntryPWD="$PWD"
	cd "$scriptLib"/escpos-python
	
	_messagePlain_probe '"$scriptAbsoluteLocation"' _abstractfs "$scriptLib"/escpos-python/print.py '_seed("     ", "'"$current_LinePrinter_devfile"'", '"$current_LinePrinter_baud"', "     ")'
	
	#_messagePlain_probe_cmd
	"$scriptAbsoluteLocation" _abstractfs "$scriptLib"/escpos-python/print.py '_seed("'"$current_content"'", "'"$current_LinePrinter_devfile"'", '"$current_LinePrinter_baud"', "'"$current_text"'")'
	
	cd "$functionEntryPWD"
	
	_stop
}
_legacy-barcode() {
	_messagePlain_nominal ${FUNCNAME[0]}
	"$scriptAbsoluteLocation" _legacy-barcode_sequence "$@"
}


_basic-barcode_procedure() {
	#_start
	
	_s

	local functionEntryPWD="$PWD"
	cd "$scriptLib"/escpos-python
	
	local current_content
	
	
	#p.barcode(current_content, "code128", 64, 3, 'BELOW', 'A', False, None, True, True)
	current_content="$current_security"
	[[ "$current_content" == "" ]] && current_content=$(_extractEntropy-bitmask "$barcode_bitmask" "$barcode_filter")
	
	
	
	cd "$functionEntryPWD"
	
	
	
	local current_text
	current_text=$(_safeEcho_newline "$@")
	
	#source "$scriptLib"/escpos-python/venv_python/bin/activate
	
	_set_LinePrinter
	
	_s

	local functionEntryPWD="$PWD"
	cd "$scriptLib"/escpos-python
	
	_messagePlain_probe '"$scriptAbsoluteLocation"' _abstractfs "$scriptLib"/escpos-python/print.py '_seed("     ", "'"$current_LinePrinter_devfile"'", '"$current_LinePrinter_baud"', "     ")'
	
	#_messagePlain_probe_cmd
	"$scriptAbsoluteLocation" _abstractfs "$scriptLib"/escpos-python/print.py '_seed("'"$current_content"'", "'"$current_LinePrinter_devfile"'", '"$current_LinePrinter_baud"', "'"$current_text"'")'
	
	cd "$functionEntryPWD"
	
	#_stop
}
_basic-barcode() {
	_messagePlain_nominal ${FUNCNAME[0]}
	"$scriptAbsoluteLocation" _basic-barcode_procedure "$@"
}



_print() {
  _set_LinePrinter
  
  if [[ "$1" == "/"* ]] && [[ -e "$1" ]]
  then
    cat "$1" | pv -L 300 2>/dev/null > "$current_LinePrinter_devfile"
    
    echo -e '\n\n\n' > "$current_LinePrinter_devfile"
    echo 1B6D | xxd -p -r > "$current_LinePrinter_devfile"
    return
  fi
  
  _safeEcho "$@" | pv -L 300 2>/dev/null > "$current_LinePrinter_devfile"
  
  echo -e '\n\n\n' > "$current_LinePrinter_devfile"
  echo 1B6D | xxd -p -r > "$current_LinePrinter_devfile"
}

p() {
  _set_LinePrinter
  
  _print "$@"
}

_label() {
  _set_LinePrinter
  
  echo '_____________________________________________' > "$current_LinePrinter_devfile"
  echo -e '\n\n\n' > "$current_LinePrinter_devfile"
  echo 1B6D | xxd -p -r > "$current_LinePrinter_devfile"
  
  _safeEcho "$@" | pv -L 300 2>/dev/null > "$current_LinePrinter_devfile"
  
  echo -e '\n\n\n' > "$current_LinePrinter_devfile"
  echo 1B6D | xxd -p -r > "$current_LinePrinter_devfile"
}

_tear() {
  _set_LinePrinter
  
  echo -e '\n\n\n' > "$current_LinePrinter_devfile"
  echo 1B6D | xxd -p -r > "$current_LinePrinter_devfile"
}


