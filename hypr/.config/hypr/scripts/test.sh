#!/usr/bin/wish

menubutton .myMenubutton -menu .myMenubutton.myMenu -text "ChangeText"
menu .myMenubutton.myMenu
.myMenubutton.myMenu add command -label Hello -command {set myvariable "Hello"}
.myMenubutton.myMenu add command -label World -command {set myvariable "World"}
pack .myMenubutton
pack [label .myLabel  -text "Select An option" -font {Helvetica -18 bold} -height 5
     -width 15 -textvariable myvariable]
