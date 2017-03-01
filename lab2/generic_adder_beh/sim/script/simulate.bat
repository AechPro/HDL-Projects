vsim -do sim.do
del -force work
rmdir -force work
del -force transcript
del -force vsim.wlf
del -force vsim_stacktrace.vstf
pushd S:\"HDL labs"
svn add . --force
svn commit -m "Automatic script commit, use this one."
pause