# Versioning
BUILD_DATE:=$(shell date --iso-8601)
BUILD_NUMBER_FILE=VERSION
BUILD_NUMBER:=$(shell cat $(BUILD_NUMBER_FILE))

# Where do we write the file?
OUT_DIR=build
OUT_FILE:=sandbox_$(BUILD_DATE)_r$(BUILD_NUMBER).lua

# List of lua files to combine
IN_FILES = 01_helper_functions.lua \
02_landing_listener.lua \
03_markpoint_listener.lua \
04_smoke_markers.lua \
05_spawnable_units.lua \
06_spawn_engine.lua \
07_radio_menu.lua \
08_respawn_listener.lua

# Default job is to add the "loaded" message to the end of the combined script.
# It depends on the build number file job which increments the build number
# The build number file job depends on the sandbox job, which is the one that combines all the lua files.

default: $(BUILD_NUMBER_FILE)
	printf	'%s\n%s\n%s\n%s\n%s\n' \
		"local loadedMsg = {}" \
		"loadedMsg.text = 'Loaded Sandbox Version $(BUILD_NUMBER) ($(BUILD_DATE))'" \
		"loadedMsg.displayTime = 5" \
		"loadedMsg.msgFor = {coa = {'all'}}" \
		"mist.message.add(loadedMsg)" \
		>> $(OUT_DIR)/$(OUT_FILE)

$(BUILD_NUMBER_FILE): sandbox
	@if ! test -f $(BUILD_NUMBER_FILE); then echo 0 > $(BUILD_NUMBER_FILE); fi
	@echo $$(($$(cat $(BUILD_NUMBER_FILE)) + 1)) > $(BUILD_NUMBER_FILE)

sandbox:
	ls -1 $(IN_FILES) | xargs -n1 awk \
	'FNR==1{print "---------- BEGIN",FILENAME,"----------\n"} \
	END{print "\n---------- END",FILENAME,"----------\n"} \
	{print}' >> $(OUT_DIR)/$(OUT_FILE)

clean:
	rm -f $(OUT_DIR)/*.lua
