From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 4 May 2016 18:26:56 +0200
Subject: [LTP] [PATCH V2 1/9] tracing: reorganize ftrace-stress tests to
 general tests
In-Reply-To: <1460966656-28328-2-git-send-email-chuhu@redhat.com>
References: <1460966656-28328-1-git-send-email-chuhu@redhat.com>
 <1460966656-28328-2-git-send-email-chuhu@redhat.com>
Message-ID: <20160504162655.GB22563@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh b/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh
> new file mode 100755
> index 0000000..ea082dc
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh
> @@ -0,0 +1,156 @@
> +#! /bin/sh
     ^
     The space should be removed

> +###########################################################################
> +##                                                                       ##
> +## Copyright (c) 2010 FUJITSU LIMITED                                    ##
> +##                                                                       ##
> +## This program is free software: you can redistribute it and/or modify  ##
> +## it under the terms of the GNU General Public License as published by  ##
> +## the Free Software Foundation, either version 3 of the License, or     ##
> +## (at your option) any later version.                                   ##
> +##                                                                       ##
> +## This program is distributed in the hope that it will be useful,       ##
> +## but WITHOUT ANY WARRANTY; without even the implied warranty of        ##
> +## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the          ##
> +## GNU General Public License for more details.                          ##
> +##                                                                       ##
> +## You should have received a copy of the GNU General Public License     ##
> +## along with this program. If not, see <http://www.gnu.org/licenses/>.  ##
> +##                                                                       ##
> +## Author: Li Zefan <lizf@cn.fujitsu.com>                                ##
> +##                                                                       ##
> +###########################################################################
> +
> +cd $LTPROOT/testcases/bin
> +
> +export TPATH="$PWD"
> +export DEBUGFS_PATH="$PWD/debugfs"
> +export TRACING_PATH="$PWD/debugfs/tracing"

The test must not create files and mount things outside of the test
temporary directory. Expecially not in $LTPROOT. You should call
tst_tmpdir to create temporary directory instead, then create directory
there.

Also the ftrace filesystem seems to be mounted on
/sys/kernel/debug/tracing/ on recent distributions, why don't we just
set TRACING_PATH accodingly if it's already mounted and fallback to
mounting it only when debugfs couldn't be found in /proc/mounts?

> +export FPATH="$TPATH/ftrace_function"
> +export RPATH="$TPATH/ftrace_regression"
> +export SPATH="$TPATH/ftrace_stress"
> +
> +. test.sh
> +
> +test_interval=$1
> +
> +save_old_setting()
> +{
> +	cd $TRACING_PATH
> +
> +	old_trace_options=( `cat trace_options` )
> +	old_tracing_on=`cat tracing_on`
> +	old_tracing_enabled=`cat tracing_enabled`
> +	old_buffer_size=`cat buffer_size_kb`
> +
> +	if [ -e stack_max_size ]; then
> +		old_stack_tracer_enabled=`cat /proc/sys/kernel/stack_tracer_enabled`
> +	fi
> +
> +	if [ -e "/proc/sys/kernel/ftrace_enabled" ]; then
> +		old_ftrace_enabled=`cat /proc/sys/kernel/ftrace_enabled`
> +	fi
> +
> +	if [ -e "function_profile_enabled" ]; then
> +		old_profile_enabled=`cat function_profile_enabled`
> +	fi
> +
> +	cd - > /dev/null
> +}
> +
> +
> +restore_old_setting()
> +{
> +	cd $TRACING_PATH
> +
> +	echo nop > current_tracer
> +	echo 0 > events/enable
> +	echo 0 > tracing_max_latency 2> /dev/null
> +
> +	if [ -e trace_clock ]; then
> +		echo local > trace_clock
> +	fi
> +
> +	if [ -e "function_pofile_enabled" ]; then
> +		echo $old_profile_enabled > function_profile_enabled
> +	fi
> +
> +	if [ -e "/proc/sys/kernel/ftrace_enabled" ]; then
> +		echo $old_ftrace_enabled > /proc/sys/kernel/ftrace_enabled
> +	fi
> +
> +	if [ -e stack_max_size ]; then
> +		echo $old_stack_tracer_enabled > /proc/sys/kernel/stack_tracer_enabled
> +		echo 0 > stack_max_size
> +	fi
> +
> +	echo $old_buffer_size > buffer_size_kb
> +	echo $old_tracing_on > tracing_on
> +	echo $old_tracing_enabled > tracing_enabled
> +
> +	for option in $old_trace_options
> +	do
> +		echo $option > trace_options 2> /dev/null
> +	done
> +
> +	echo > trace
> +
> +	cd - > /dev/null
> +}
> +
> +clean_up()
> +{
> +	restore_old_setting
> +
> +	umount $DEBUGFS_PATH
> +	rmdir $DEBUGFS_PATH
> +}
> +
> +clean_up_exit()
> +{
> +	clean_up
> +	exit 1
> +}
> +
> +test_begin()
> +{
> +	start_time=`date +%s`
> +}
> +
> +test_wait()
> +{
> +	for ((; ;))
> +	{
> +		sleep 2
> +
> +		cur_time=`date +%s`
> +		elapsed=$(( $cur_time - $start_time ))
> +
> +		# run the test for $test_interval secs
> +		if [ $elapsed -ge $test_interval ]; then
> +			break
> +		fi
> +	}
> +}

Why don't we just do sleep $test_interval instead?

> +trap clean_up_exit INT
> +
> +tst_require_root
> +
> +# Don't run the test on kernels older than 2.6.34, otherwise
> +# it can crash the system if the kernel is not latest-stable
> +tst_kvercmp 2 6 34
> +if [ $? -eq 0 ]; then
> +	tst_brkm TCONF ignored "The test should be run in kernels >= 2.6.34. Skip the test..."
> +	exit 0
> +fi

Don't do this. Really the whole point of LTP is to validate kernel, if
we skip known bugs by default we would give users false impression that
the kernel was thoroughly tested.

Also since you include the test.sh here the tst_brkm format is different
and it exits the test, so the exit 0 is never reached.

> +mkdir $DEBUGFS_PATH
> +mount -t debugfs xxx $DEBUGFS_PATH
> +
> +# Check to see tracing feature is supported or not
> +if [ ! -d $TRACING_PATH ]; then
> +	tst_brkm TCONF ignored "Tracing is not supported. Skip the test..."
> +	umount $DEBUGFS_PATH
> +	rmdir $DEBUGFS_PATH
> +	exit 0
> +fi

Here as well, the tst_brkm from test.sh exit the test. Ideally you
should setup TST_CLEANUP to point to a cleanup function once you do the
test initalization which would be then executed before the test exits
automatically.

...


> diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
> new file mode 100755
> index 0000000..d9f7f8b
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
> @@ -0,0 +1,123 @@
> +#! /bin/sh
> +
> +###########################################################################
> +##                                                                       ##
> +## Copyright (c) 2010 FUJITSU LIMITED                                    ##
> +##                                                                       ##
> +## This program is free software: you can redistribute it and/or modify  ##
> +## it under the terms of the GNU General Public License as published by  ##
> +## the Free Software Foundation, either version 3 of the License, or     ##
> +## (at your option) any later version.                                   ##
> +##                                                                       ##
> +## This program is distributed in the hope that it will be useful,       ##
> +## but WITHOUT ANY WARRANTY; without even the implied warranty of        ##
> +## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the          ##
> +## GNU General Public License for more details.                          ##
> +##                                                                       ##
> +## You should have received a copy of the GNU General Public License     ##
> +## along with this program. If not, see <http://www.gnu.org/licenses/>.  ##
> +##                                                                       ##
> +## Author: Li Zefan <lizf@cn.fujitsu.com>                                ##
> +##                                                                       ##
> +###########################################################################
> +
> +
> +export TCID="ftrace-stress-test"
> +export TST_TOTAL=1
> +export TST_COUNT=1
> +
> +. ftrace_lib.sh
> +
> +test_success=true
> +
> +export_pids()
> +{
> +	export pid1 pid2 pid3 pid4 pid5 pid6 pid7 pid8 pid9 pid10 pid11 pid12 \
> +		pid13 pid14 pid15 pid16
> +
> +	export NR_PIDS=16
> +}
> +
> +test_stress()
> +{
> +	export_pids
> +
> +	$SPATH/ftrace_trace_clock.sh &
> +	pid1=$!
> +	$SPATH/ftrace_current_tracer.sh &
> +	pid2=$!
> +	$SPATH/ftrace_trace_options.sh &
> +	pid3=$!
> +	$SPATH/ftrace_tracing_max_latency.sh &
> +	pid4=$!
> +	$SPATH/ftrace_stack_trace.sh &
> +	pid5=$!
> +	$SPATH/ftrace_stack_max_size.sh &
> +	pid6=$!
> +	$SPATH/ftrace_tracing_on.sh &
> +	pid7=$!
> +	$SPATH/ftrace_tracing_enabled.sh &
> +	pid8=$!
> +	$SPATH/ftrace_set_event.sh &
> +	pid9=$!
> +	$SPATH/ftrace_buffer_size.sh &
> +	pid10=$!
> +	$SPATH/ftrace_trace.sh &
> +	pid11=$!
> +	$SPATH/ftrace_trace_pipe.sh &
> +	pid12=$!
> +	$SPATH/ftrace_ftrace_enabled.sh &
> +	pid13=$!
> +	$SPATH/ftrace_set_ftrace_pid.sh &
> +	pid14=$!
> +	$SPATH/ftrace_profile_enabled.sh &
> +	pid15=$!
> +	$SPATH/ftrace_trace_stat.sh &
> +	pid16=$!
> +}
> +
> +test_kill()
> +{
> +	kill -KILL $pid1 || test_success=false
> +	kill -KILL $pid2 || test_success=false
> +	kill -KILL $pid3 || test_success=false
> +	kill -KILL $pid4 || test_success=false
> +	kill -KILL $pid5 || test_success=false
> +	kill -KILL $pid6 || test_success=false
> +	kill -KILL $pid7 || test_success=false
> +	kill -KILL $pid8 || test_success=false
> +	kill -KILL $pid9 || test_success=false
> +	kill -KILL $pid10 || test_success=false
> +	kill -KILL $pid11 || test_success=false
> +	kill -USR1 $pid12 || test_success=false
> +	kill -KILL $pid13 || test_success=false
> +	kill -KILL $pid14 || test_success=false
> +	kill -KILL $pid15 || test_success=false
> +	kill -KILL $pid16 || test_success=false
> +
> +	sleep 2

I remember telling you to call wait on each pid instead of the sleep 2
here.

> +	clean_up
> +}
> +
> +
> +# ----------------------------
> +echo "Ftrace Stress Test Begin"

That should be tst_resm TINFO "..." but that is very minor.

> +save_old_setting
> +
> +test_begin
> +
> +test_stress
> +
> +test_wait
> +
> +test_kill

Hmm, shouldn't you restore old settings here?

> +echo "Ftrace Stress Test End"

Here as well.

> +if $test_success; then
> +	tst_resm TPASS "finished running the test. Run dmesg to double-check for bugs"
> +else
> +	tst_resm TFAIL "please check log message."
> +	exit 1
> +fi

You should call tst_exit at the end of the test instead of doing exit 1
after the tst_resm. This is another leftover caused by the
broken-by-desing tst_resm and tst_brkm binaries.

-- 
Cyril Hrubis
chrubis@suse.cz
