


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



# WARNING: Function '_interact' must NOT be defined 
_interact() {
	source ./bin/activate
	
	_set_LinePrinter
	
	#"$scriptAbsoluteFolder"/print.py '_python()'
	"$scriptAbsoluteFolder"/print.py '_interact("'"$current_LinePrinter_devfile"'", '"$current_LinePrinter_baud"')'
}







_qr_sequence() {
  _start
  
  local current_content
  current_content=$(_safeEcho_newline "$@")
  
  #source ./bin/activate
  
  _set_LinePrinter
  
  _messagePlain_probe "$scriptAbsoluteFolder"/print.py '_qr("     ", "'"$current_LinePrinter_devfile"'", '"$current_LinePrinter_baud"')'
  
  #_messagePlain_probe_cmd
  "$scriptAbsoluteFolder"/print.py '_qr("'"$current_content"'", "'"$current_LinePrinter_devfile"'", '"$current_LinePrinter_baud"')'
  
  _stop
}

_qr() {
  "$scriptAbsoluteLocation" _qr_sequence "$@"
}




# NOTICE: STRONGLY DISCOURAGED.
_barcode_sequence() {
  _start
  
  local current_content
  current_content=$(_safeEcho_newline "$@")
  
  #source ./bin/activate
  
  _set_LinePrinter
  
  _messagePlain_probe "$scriptAbsoluteFolder"/print.py '_barcode("     ", "'"$current_LinePrinter_devfile"'", '"$current_LinePrinter_baud"')'
  
  #_messagePlain_probe_cmd
  "$scriptAbsoluteFolder"/print.py '_barcode("'"$current_content"'", "'"$current_LinePrinter_devfile"'", '"$current_LinePrinter_baud"')'
  
  _stop
}

_barcode() {
  "$scriptAbsoluteLocation" _barcode_sequence "$@"
}



_seed() {
	_start

	local current_content
	current_content=$("$HOME"/core/infrastructure/coreoracle/pairKey _extractEntropyAlpha 14)
	
	local current_text
	current_text=$(_safeEcho_newline "$@")
	
	#source ./bin/activate
	
	_set_LinePrinter
	
	_messagePlain_probe "$scriptAbsoluteFolder"/print.py '_seed("     ", "'"$current_LinePrinter_devfile"'", '"$current_LinePrinter_baud"', "     ")'
	
	#_messagePlain_probe_cmd
	"$scriptAbsoluteFolder"/print.py '_seed("'"$current_content"'", "'"$current_LinePrinter_devfile"'", '"$current_LinePrinter_baud"', "'"$current_text"'")'
	
	_stop
	
	#local current_seed
	#current_seed=$("$HOME"/core/infrastructure/coreoracle/pairKey _extractEntropyAlpha 14)
	_barcode $("$HOME"/core/infrastructure/coreoracle/pairKey _extractEntropyAlpha 14)
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


