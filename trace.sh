#! /bin/sh -

# create lttng session
lttng create ros-tracing-test-1

# enable events
./util-ws/src/tracetools/scripts/setup-lttng-roscpp.sh

# start
lttng start

# preload UST library
LD_PRELOAD=/usr/lib/x86_64-linux-gnu/liblttng-ust-cyg-profile.so

# launch
roslaunch elikos_sim decisionmaking2018_sim.launch &

# wait
echo "waiting for <enter>..."
read a

# kill
echo "killing"
kill $!

# stop
lttng stop

# destroy
lttng destroy
