




_setup_prog() {
	if [[ $("$scriptAbsoluteLocation" _rand_bin | wc -c | tr -dc '0-9') -lt 16 ]]
	then
		echo 'missing: _rand (coreoracle, pairKey)'
		_messageFAIL
		_stop 1
		return 1
	fi
	
	
	# python3-serial
	_getDep 'pyserial-ports'
	_getDep 'pyserial-miniterm'
	_getDep 'python3/dist-packages/serial/__main__.py'
}

