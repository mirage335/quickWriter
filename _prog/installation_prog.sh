


_test_prog() {
	# venv ... python3 ... print("true") == "true" ...
	
	cd "$scriptLib"/escpos-python
	
	local current_abstract_PWD
	current_abstract_PWD=$(_abstractfs bash -c 'echo "$PWD"')
	
	if [[ $(echo 'print("true")' | "$scriptAbsoluteLocation" _abstractfs "$current_abstract_PWD"/venv_python/bin/python3 | tr -dc 'a-z') != "true" ]]
	then
		echo 'FAIL: venv: python: _lib/escpos-python'
	fi
	
	
	
	return 0
}







# ATTENTION: Unusually, this function may be called before any use of an end-user function. May be, but not necessarily. Thus, must not unnecessarily change a working installtion.
_setup-escpos_sequence() {
	_messageNormal 'init: _setup-escpos_sequence'
	
	mkdir -p "$scriptLib"/escpos-python
	
	cd "$scriptLib"/escpos-python
	
	local current_abstract_PWD
	current_abstract_PWD=$(_abstractfs bash -c 'echo "$PWD"')
	
	_messagePlain_probe_var current_abstract_PWD
	
	local current_abstract_PWD_absolute
	current_abstract_PWD_absolute=$(_abstractfs "$scriptAbsoluteLocation" _getAbsoluteLocation "$current_abstract_PWD")
	
	_messagePlain_probe_var current_abstract_PWD_absolute
	
	_messagePlain_probe_cmd "$scriptAbsoluteLocation" _abstractfs python3 -m venv "$current_abstract_PWD"/venv_python
	
	#source ./bin/activate
	
	_messagePlain_probe_cmd "$scriptAbsoluteLocation" _abstractfs "$current_abstract_PWD"/venv_python/bin/python3 -m pip install --upgrade pip
	_messagePlain_probe_cmd "$scriptAbsoluteLocation" _abstractfs "$current_abstract_PWD"/venv_python/bin/python3 -m pip --version
	
	
	_messagePlain_probe_cmd "$scriptAbsoluteLocation" _abstractfs "$current_abstract_PWD"/venv_python/bin/python3 -m pip install python-escpos[serial,usb]
	
	
	
	
	
	
}
_setup-escpos() {
	"$scriptAbsoluteLocation" _setup-escpos_sequence "$@"
}



_setup-msr605() {
	true
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
	
	_setup-msr605
}

