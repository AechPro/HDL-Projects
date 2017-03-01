vsim -do sim.do
del /F /Q work
rmdir -force work
del /F transcript
del /F vsim.wlf
del /F vsim_stacktrace.vstf
pushd S:\"HDL labs"
svn add . --force
svn commit -m "Automatic script commit"
pause