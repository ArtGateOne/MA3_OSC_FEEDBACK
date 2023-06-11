# MA3_OSC_FEEDBACK
Plugin send osc feedback on grandma3


This is a plugin that provides feedback on the status of executors/faders in the grand ma3 system.

The original version of the plugin was created by Mr-Button, with my modifications, and the final version was written by Andreas from MAforum (Thank you very much!)

The enabled plugin checks every half second for changes in the ma3 system for the executor/fader/encoder on the current page and sends them via OSC.

In this plugin, the following numbers are entered in the table - 201-215.

If you want, you can add the remaining numbers (e.g., from another wing , or encoders 301-315).

local executor_table = {201,202,203,204,205,206,207,208,209,210,211,212,213,214,215}



Second line

local osc_config = 1

This means that the selected OSC IN/OUT settings will be used for sending - the first position.

If you want to send OSC on a different port, add the appropriate entry in OSC IN/OUT, and change to

local osc_config = 2

Have fun!
