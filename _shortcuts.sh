#!/usr/bin/env bash


_s() {
	#BARCODE - basic ONLY. Normally this is the ONLY bitmask to change, and ONLY to address (discouraged) tradeoffs with specialized software.
	[[ "$1" != "" ]] && export barcode_bitmask="$1"
	[[ "$barcode_bitmask" == "" ]] && export barcode_bitmask=33333333333333
	#[[ "$barcode_bitmask" == "" ]] && export barcode_bitmask=111111111111111111111111
	
	#DANGER: Strongly discouraged. Low entropy, for very specialized use only.
	#[[ "$barcode_bitmask" == "" ]] && export barcode_bitmask=111111111111111
	
	
	
	#MAGSWIPE SEED. No normal reason to change this.
	[[ "$2" != "" ]] && export magswipe_bitmask="$2"
	[[ "$magswipe_bitmask" == "" ]] && export magswipe_bitmask=55555555555555555555
	
	# WiFi SEED. No normal reason to change this.
	[[ "$3" != "" ]] && export qrcode_bitmask="$3"
	[[ "$qrcode_bitmask" == "" ]] && export qrcode_bitmask=83333333333333333338
	
	
	#BARCODE SEED. No normal reason to change this.
	[[ "$4" != "" ]] && export barcode_bitmask_seed="$4"
	[[ "$barcode_bitmask_seed" == "" ]] && export barcode_bitmask_seed=77777777777777
	
	true
}





_print() {
	"$shortcutsPath_quickWriter"/quickWriter ${FUNCNAME[0]} "$@"
}

p() {
	"$shortcutsPath_quickWriter"/quickWriter _print "$@"
}

_label() {
	"$shortcutsPath_quickWriter"/quickWriter ${FUNCNAME[0]} "$@"
}

_tear() {
	"$shortcutsPath_quickWriter"/quickWriter ${FUNCNAME[0]} "$@"
}

_qr() {
	"$shortcutsPath_quickWriter"/quickWriter ${FUNCNAME[0]} "$@"
}

_barcode() {
	"$shortcutsPath_quickWriter"/quickWriter ${FUNCNAME[0]} "$@"
}



_seed() {
	"$shortcutsPath_quickWriter"/quickWriter ${FUNCNAME[0]} "$@"
}

_seed-barcode() {
	"$shortcutsPath_quickWriter"/quickWriter ${FUNCNAME[0]} "$@"
}

_seed-magswipe() {
	"$shortcutsPath_quickWriter"/quickWriter ${FUNCNAME[0]} "$@"
}


_basic() {
	"$shortcutsPath_quickWriter"/quickWriter ${FUNCNAME[0]} "$@"
}

_basic-barcode() {
	"$shortcutsPath_quickWriter"/quickWriter ${FUNCNAME[0]} "$@"
}

_basic-magswipe() {
	"$shortcutsPath_quickWriter"/quickWriter ${FUNCNAME[0]} "$@"
}


_seed-wifi() {
	"$shortcutsPath_quickWriter"/quickWriter ${FUNCNAME[0]} "$@"
}

_wifi() {
	"$shortcutsPath_quickWriter"/quickWriter ${FUNCNAME[0]} "$@"
}

_seed-wifi-card() {
	"$shortcutsPath_quickWriter"/quickWriter ${FUNCNAME[0]} "$@"
}

_wifi-card() {
	"$shortcutsPath_quickWriter"/quickWriter ${FUNCNAME[0]} "$@"
}


_erase-magswipe() {
	"$shortcutsPath_quickWriter"/quickWriter ${FUNCNAME[0]} "$@"
}
_erase() {
	"$shortcutsPath_quickWriter"/quickWriter ${FUNCNAME[0]} "$@"
}


