

_setup-escpos_sequence() {
	mkdir -p "$scriptLib"/escpos-python
	
	cd "$scriptLib"/escpos-python
	
	_abstractfs python3 -m venv escpos-python
}
_setup-escpos() {
	"$scriptAbsoluteLocation" _setup-escpos_sequence "$@"
}


_setup_prog() {
	if [[ $("$scriptAbsoluteLocation" _rand_bin | wc -c | tr -dc '0-9') -lt 16 ]]
	then
		echo 'missing: _rand (coreoracle, pairKey)'
		_messageFAIL
		_stop 1
		return 1
	fi
	
	
	# WARNING: Due to versioning in relevant path text, 'python3.11-venv' and similar dependency does NOT have a '_getDep' entry.
	
	# libcups2-dev
	_getDep 'cups/cups.h'
	
	# python3-serial
	_getDep 'pyserial-ports'
	_getDep 'pyserial-miniterm'
	_getDep 'python3/dist-packages/serial/__main__.py'
	
	_setup-escpos
}

