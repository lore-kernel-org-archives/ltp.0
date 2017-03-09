From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  9 Mar 2017 13:31:54 +0100
Subject: [LTP] [PATCH v2 1/1] cron: Rewrite and cleanup cron_tests.sh script
Message-ID: <20170309123154.32018-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Look for results into more possible log locations, look also into
journalctl output.

This fixes systems with different cron log (Debian, Ubuntu and their
derivates, see github issue #136) and systems which log into journalctl
only (openSUSE Tumbleweed).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/commands                      |   2 +-
 testcases/commands/cron/cron_tests.sh | 606 +++++++++++++---------------------
 2 files changed, 232 insertions(+), 376 deletions(-)

diff --git a/runtest/commands b/runtest/commands
index fe9ce5d2d..fd5170339 100644
--- a/runtest/commands
+++ b/runtest/commands
@@ -5,7 +5,7 @@ ldd01 ldd01
 nm01 nm01
 file01 file_test.sh
 tar01  tar_tests.sh
-cron export TCdat=$LTPROOT/testcases/bin; cron_tests.sh
+cron cron_tests.sh
 logrotate export TCdat=$LTPROOT/testcases/bin; logrotate_tests.sh
 mail export TCdat=$LTPROOT/testcases/bin; mail_tests.sh
 cpio01 cpio_tests.sh
diff --git a/testcases/commands/cron/cron_tests.sh b/testcases/commands/cron/cron_tests.sh
index 3f70a2389..36e7181a1 100644
--- a/testcases/commands/cron/cron_tests.sh
+++ b/testcases/commands/cron/cron_tests.sh
@@ -1,418 +1,274 @@
 #!/bin/sh
 
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2001                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software		      ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##									      ##
-##                                                                            ##
-################################################################################
+# Copyright (c) International Business Machines Corp., 2001
+# Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
 #
-# File:			cron_tests.sh
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
-# Description:	This testcase tests if crontab <filename> installs the cronjob
-# and cron schedules the job correctly. The job is set such that it will run
-# forever every minute of the day.
-# The cronjob runs a program that will print a string followed by the current
-# date and time. Five samples are taken inorder to verify if cron job is run
-# every minute. It is not practical to check if it works for the remaining
-# fields of the crontab file also.
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
 #
-# Author:		Manoj Iyer manjo@mail.utexas.edu
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 #
-# History:
-# 	Dec - 19 - 2002 - Created.
-#	Dec - 20 - 2002 - Correted Test #3, grep for the filename of cronjob
-#                         after executing crontab -l.
-#                       - Fixed bug in #3, test was not installing the cronjob.
-#                       - Added more informational messages TINFO.
-#                       - Changed permissions to this file to 'x'
-
-export TST_TOTAL=3
-
-if [ -z "$LTPTMP" -a -z "$TMPBASE" ]
-then
-    LTPTMP=/tmp
-else
-    LTPTMP=$TMPBASE
-fi
-
-if [ -z "$LTPBIN" -a -z "$LTPROOT" ]
-then
-    LTPBIN=./
-else
-    LTPBIN=$LTPROOT/testcases/bin
-fi
-
-. cmdlib.sh
-SYSLOG_STARTED=0
-
-if [ -n "$SYSLOG_DAEMON" ]; then
-	status_daemon $SYSLOG_DAEMON
-	if [ $? -ne 0 ]; then
-		restart_daemon $SYSLOG_DAEMON
-		SYSLOG_STARTED=1
+# Author: Manoj Iyer <manjo@mail.utexas.edu>
+
+TST_ID="cron_tests01"
+TST_CNT=3
+TST_TESTFUNC=do_test
+TST_NEEDS_TMPDIR=1
+TST_SETUP=setup
+TST_CLEANUP=cleanup
+. tst_test.sh
+
+. daemonlib.sh
+
+SYSLOG_STARTED=
+CROND_STARTED=
+LOGS=
+
+grep_logs()
+{
+	local pattern="$1"
+	local fail_msg="$2"
+	local pass_msg="${3:-}"
+
+	local lines=10
+	local out=out.$$
+	local err=err.$$
+
+	if [ "$LOGS" ]; then
+		tail -n $lines $LOGS | grep "$pattern" > $out 2> $err
+	else
+		journalctl -n $lines | grep "$pattern" > $out 2> $err
 	fi
-fi
 
-# Set return code RC variable to 0, it will be set with a non-zero return code
-# in case of error. Set TFAILCNT to 0, increment if there occures a failure.
+	if [ $? -ne 0 ]; then
+		tst_res TFAIL "$fail_msg: `cat $err`"
+	else
+		[ "$pass_msg" ] && tst_res TPASS "$pass_msg"
+	fi
+}
 
-LOCTMP=${PWD}/tmp
-TFAILCNT=0
-RC=0
+create_crontab()
+{
+	local crontab=cronjob.cron
+	local script=$1
+	local out=out.$$
 
-# Test #1
-# Test if crontab <filename> installs the crontab file and cron schedules the
-# job correctly.
+	tst_res TINFO "creating crontab: $script"
 
-export TCID=cron01
-export TST_COUNT=1
+	cat > $crontab <<EOF
+* * * * * $script
+EOF
 
-$LTPBIN/tst_resm TINFO "Test #1: crontab <filename> installs the crontab file"
-$LTPBIN/tst_resm TINFO "Test #1: cron schedules the job listed in crontab file."
+	tst_res TINFO "installing crontab file"
+	crontab $crontab > $out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_brk TBROK "crontab: error while installing crontab file: `cat $out`"
+		return 1
+	fi
+	return 0
+}
+
+remove_crontab()
+{
+	local out=out.$$
+	tst_res TINFO "removing crontab file"
+	crontab -r > $out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_brk TBROK "crontab: error while removing crontab file `cat $out`"
+		return 1
+	fi
+	return 0
+}
 
-# create the cron job. The job is to run the program tst1_cronprg.sh
-# every minute, every hour, every day, every month, any weekday.
+create_hello_script()
+{
+	local script=$1
 
-cat > $LTPTMP/tst1_cronjob.cron <<EOF
-* * * * * $LTPTMP/tst1_cronprg.sh
+	cat > $script <<EOF
+#!/bin/sh
+echo "Hello Hell"
+exit 0
 EOF
+	chmod +x $script
+}
 
-# Create the program that will be run by the cronjob. This program will print a
-# "Hello Hell" string and date time information.
+install_cron_test()
+{
+	local script=$PWD/cronprg.sh
+	local cron_out=$PWD/tst1_cron.out
+	local err=err.log
+	local sleep_sec
+	local ts_min1 ts_min2 fail
 
-cat > $LTPTMP/tst1_cronprg.sh <<EOF
-#! /bin/sh
+	tst_res TINFO "test install cron job"
 
-DATE=\`LANG= date\`
-echo "Hello Hell today is \$DATE " > $LTPTMP/tst1_cron.out 2>&1
+	cat > $script <<EOF
+#! /bin/sh
+DATE=\`LC_ALL=C date\`
+echo "Hello Hell today is \$DATE" > $cron_out 2>&1
 exit 0
 EOF
+	chmod +x $script
 
-chmod +x $LTPTMP/tst1_cronprg.sh
-
-# install the cronjob, crontab <filename> does that. Sleep for 10s and the
-# check the /var/log/messages to see if there is a record of any crontab
-# activity.
-
-$LTPBIN/tst_resm TINFO "Test #1: Installing cron job ... "
-crontab $LTPTMP/tst1_cronjob.cron >$LTPTMP/cron_tst2n1.out 2>&1
-RC=$?
-
-if [ $RC -ne 0 ]
-then
-	$LTPBIN/tst_brk TBROK $LTPTMP/cron_tst2n1.out NULL \
-		"Test #1: crontab Broke while installing cronjob. Reason:"
-		 TFAILCNT=$(( $TFAILCNT+1 ))
-else
-	$LTPBIN/tst_resm TINFO "Test #1: Cronjob installed successfully"
-fi
-
-sleep 10s
-
-tail -n 10 /var/log/messages | grep crontab | grep REPLACE \
-	> $LTPTMP/cron_tst2n1.out 2>&1
-RC=$?
-#####
-# Some implementations log cron info to /var/log/cron instead...
-#####
-if [ "$RC" -ne 0 -a -f /var/log/cron ]; then
-	$LTPBIN/tst_resm TINFO "Test #1: /var/log/cron: Trying altenate log..."
-	tail -n 10 /var/log/cron | grep crontab | grep REPLACE \
-	    > $LTPTMP/cron_tst2n1.out 2>&1
-	RC=$?
-fi
-if [ $RC -ne 0 ]
-then
-	$LTPBIN/tst_resm TFAIL \
-		"Test #1: crontab activity not recorded in /var/log/messages."
-		 TFAILCNT=$(( $TFAILCNT+1 ))
-else
-	$LTPBIN/tst_resm TINFO \
-		"Test #1: cron activity logged in /var/log/messages"
-fi
-
-# just wait a random time for the cron to kickoff the cronjob.
-#####
-# Sleep enough to get _just past_ the start of the next minute --
-# like 2 or 3 seconds past... since the loop below sleeps for 62
-# seconds, we should start this 5-iteration loop closely following
-# the start of a minute...
-#####
-sleep 1m	# allows cron to run once
-XS=$(expr 60 - $(date | awk '{print $4}' | cut -f3 -d:))
-[ "$XS" -ne 0 ] && sleep ${XS}s		# sleep to the _next_ minute
-sleep 3					# ... for good measure...
-
-# The program executed by the cron job tst1_cronprg.sh will record the date
-# and time in a file tst1_cron.out. Extract the minute recorded by the program
-# into TS_MIN1 sleep for 1m 10s so that the cron will update this file after
-# 1m, extract TS_MIN2 and check if the minute recorded has advanced by 1. Take
-# 5 such samples, if any one of the fail, flag a failure.
-
-LOOP_CNTR=5
-TS_MIN1=0
-FAILCNT=0
-
-while [ $LOOP_CNTR -ne 0 ]
-do
-	TS_MIN1=$(awk '{print $8}' $LTPTMP/tst1_cron.out |
-	    awk -F: '{printf("%d", $2);}')
-
-	# wait for the cronjob to update the tst1_cron.out file.
-	sleep 1m 2s
-
-	# check the time recorded in the tst1_cron.out file,
-        # this should be 1 minute ahead of what was recored earlier.
-
-	TS_MIN2=$(awk '{print $8}' $LTPTMP/tst1_cron.out |
-	    awk -F: '{printf("%d", $2);}')
-
-	if [ "x${TS_MIN1}" = "x" ] || [ "x${TS_MIN2}" = "x" ]
-	then
-		$LTPBIN/tst_resm TFAIL \
-			"Test #1: Problem with $LTPTMP/tst1_cron.out file "
-		$LTPBIN/tst_resm TFAIL \
-			"Test #1: Cause: TS_MIN1= $TS_MIN1; TS_MIN2= $TS_MIN2"
-		FAILCNT=$(( $FAILCNT+1 ))
-		break;
-	fi
+	create_crontab $script 2> $err
 
-	if [ $TS_MIN1 -eq 59 ]
-	then
-		TS_MIN1=0
+	if [ $? -ne 0 ]; then
+		tst_brk TBROK "crontab: error while creating cron job: `cat $err`"
 	else
-		TS_MIN1=$(( $TS_MIN1+1 ))
+		tst_res TINFO "cron job installed successfully"
 	fi
 
-	if [ $TS_MIN2 -ne $TS_MIN1 ]
-	then
-		# if the value of the minute field did not advance by 1
-		# flag as failure.
-		FAILCNT=$(( $FAILCNT+1 ))
-		echo "    Expected $TS_MIN1;     Received $TS_MIN2" \
-			> $LTPTMP/tst1_cron.log
-		$LTPBIN/tst_res TFAIL $LTPTMP/tst1_cron.log \
-			"Test #1: Failed to update every minute. Reason:"
-		crontab -r >/dev/null 2>&1
-		break
-	else
-		echo "    Expected $TS_MIN1;     Received $TS_MIN2" \
-			> $LTPTMP/tst1_cron.log
-		$LTPBIN/tst_res TINFO $LTPTMP/tst1_cron.log \
-			"Test #1: Values are good: "
-	fi
-	LOOP_CNTR=$(( $LOOP_CNTR-1 ))
-done
-
-if [ $FAILCNT -eq 0 ]
-then
-	# check if var/log/messages file was updated.
-	grep "CMD ($LTPTMP/tst1_cronprg.sh)" /var/log/messages >$LTPTMP/cron_tst2n1.out 2>&1
-	RC=$?
-#####
-# Some implementations log cron info to /var/log/cron instead...
-#####
-	if [ "$RC" -ne 0 -a -f /var/log/cron ]; then
-		$LTPBIN/tst_resm TINFO "Test #1: /var/log/cron: alternate..."
-		grep "CMD ($LTPTMP/tst1_cronprg.sh)" /var/log/cron \
-		    >$LTPTMP/cron_tst2n1.out 2>&1
-		RC=$?
-	fi
-	if [ $RC -eq 0 ]
-	then
-		$LTPBIN/tst_resm TPASS  \
-			"Test #1: installed cronjob, and cron executed the cronjob."
-	else
-		$LTPBIN/tst_res TFAIL $LTPTMP/cron_tst2n1.out \
-			"Test #1: Test failed. Reason:"
-		 		 TFAILCNT=$(( $TFAILCNT+1 ))
+	sleep 10
+
+	grep_logs 'crontab.*REPLACE' \
+		"cron activity not recorded" \
+		"cron activity logged"
+
+	# Sleep 3s after next minute since the loop below sleeps for 62 seconds, we
+	# should start this 5-iteration loop closely following the start of a
+	# minute.
+	sleep_sec=$((123-`date +%-S`))
+	tst_res TINFO "sleep for ${sleep_sec}s"
+	sleep $sleep_sec
+
+	# $script executed by the cron job will record the date and time into file
+	# $cron_out. Get the minute recorded by the program, sleep to allow the cron
+	# job to update file after 1m, and check if the value is advanced by 1.
+	for i in $(seq 1 5); do
+		tst_res TINFO "loop: $i: start"
+
+		if [ ! -f "$cron_out" ]; then
+			tst_res TFAIL "loop $i: file $cron_out doesn't exist"
+			fail=1
+			break
+		fi
+
+		ts_min1=$(awk '{print $8}' $cron_out | awk -F: '{printf("%d", $2);}')
+
+		# wait for the cron job to update output file
+		sleep 62
+
+		# Check the time recorded in output file, this should be 1 minute ahead of
+		# what was recored earlier.
+		ts_min2=$(awk '{print $8}' $cron_out | awk -F: '{printf("%d", $2);}')
+
+		if [ "x${ts_min1}" = "x" ] || [ "x${ts_min2}" = "x" ]; then
+			tst_res TFAIL "loop $i: failed to get time: ts_min1: $ts_min1, ts_min2: $ts_min2"
+			fail=1
+			break
+		fi
+
+		[ $ts_min1 -eq 59 ] && ts_min1=0 || ts_min1=$(( $ts_min1+1 ))
+
+		if [ $ts_min2 -ne $ts_min1 ]; then
+			tst_res TFAIL "loop $i: failed to update every minute: expected: $ts_min1, received: $ts_min2"
+			fail=1
+			break
+		fi
+	done
+
+	if [ ! "$fail" ]; then
+		grep_logs "CMD ($script)" \
+			"failed to install cron job installed and execute it" \
+			"cron job installed and executed"
 	fi
-else
-	$LTPBIN/tst_res TFAIL $LTPTMP/cron_tst1.out \
-		"Test #1: Cron did not execute every minute"
-		 TFAILCNT=$(( $TFAILCNT+1 ))
-fi
 
-#remove the cron job that was installed.
-crontab -r >/dev/null 2>&1
+	remove_crontab
+}
 
+remove_cron_job_test()
+{
+	local script=$PWD/cronprg.sh
 
-# Test #2
-# Test if crontab -r removes the installed  crontab file
+	tst_res TINFO "test remove cron job"
 
-export TCID=cron02
-export TST_COUNT=2
+	create_hello_script $script
+	create_crontab $script
 
-$LTPBIN/tst_resm TINFO "Test #2: crontab -r removes the crontab file."
+	sleep 10
 
-cat > $LTPTMP/tst2_cronjob.cron <<EOF
-* * * * * $LTPTMP/tst2_cronprg.sh
-EOF
-
-cat > $LTPTMP/tst2_cronprg.sh <<EOF
-#! /bin/sh
-
-echo "Hello Hell"
-exit 0
-EOF
-
-chmod +x  $LTPTMP/tst2_cronprg.sh >/dev/null 2>&1
-
-$LTPBIN/tst_resm TINFO "Test #2: installing crontab file."
-
-crontab $LTPTMP/tst2_cronjob.cron >$LTPTMP/cron_tst2n1.out 2>&1
-
-if [ $? -ne 0 ]
-then
-    $LTPBIN/tst_brk TBROK $LTPTMP/cron_tst2n1.out NULL \
-        "Test #2: crontab Broke while installing cronjob. Reason:"
-    TFAILCNT=$(( $TFAILCNT+1 ))
-fi
-
-sleep 10s
-
-tail -n 10 /var/log/messages | grep crontab | grep REPLACE \
-    >$LTPTMP/cron_tst2n1.out 2>&1
-RC=$?
-#####
-# Some implementations log cron info to /var/log/cron instead...
-#####
-if [ "$RC" -ne 0 -a -f /var/log/cron ]; then
-	$LTPBIN/tst_resm TINFO "Test #1: /var/log/cron: alternate..."
-	tail -n 10 /var/log/cron | grep crontab | grep REPLACE \
-	    >$LTPTMP/cron_tst2n1.out 2>&1
-	RC=$?
-fi
-if [ $RC -ne 0 ]
-then
-    $LTPBIN/tst_resm TFAIL \
-        "Test #2: crontab activity not recorded in var/log/messages."
-    TFAILCNT=$(( $TFAILCNT+1 ))
-fi
-
-$LTPBIN/tst_resm TINFO "Test #2: uninstalling crontab file."
-
-crontab -r  >$LTPTMP/cron_tst2n1.out 2>&1
-RC=$?
-
-if [ $RC -ne 0 ]
-then
-    $LTPBIN/tst_brk TBROK $LTPTMP/cron_tst2n1.out NULL \
-        "Test #2: crontab Broke while installing cronjob. Reason:"
-    TFAILCNT=$(( $TFAILCNT+1 ))
-else
-	tail -n 10 /var/log/messages | grep DELETE >$LTPTMP/cron_tst2n1.out 2>&1
-	RC=$?
-#####
-# Some implementations log cron info to /var/log/cron instead...
-#####
-	if [ "$RC" -ne 0 -a -f /var/log/cron ]; then
-		$LTPBIN/tst_resm TINFO "Test #1: /var/log/cron: alternate..."
-		tail -n 10 /var/log/cron | grep DELETE \
-		    >$LTPTMP/cron_tst2n1.out 2>&1
-		RC=$?
-	fi
-	if [ $RC -ne 0 ]
-	then
-		$LTPBIN/tst_resm TFAIL \
-			"Test #2: crontab activity not recorded in var/log/messages."
-		 		 TFAILCNT=$(( $TFAILCNT+1 ))
-	else
-		$LTPBIN/tst_resm TPASS "Test #2: crontab removed the cronjob"
-	fi
-fi
+	grep_logs 'crontab.*REPLACE' \
+		"crontab activity not recorded"
 
+	remove_crontab && grep_logs DELETE \
+		"crontab activity not recorded" \
+		"crontab removed the cron job"
+}
 
-# Test #3
-# Test if crontab -l lists the cronjob installed.
+list_cron_jobs_test()
+{
+	local script=$PWD/cronprg.sh
+	local out=cron.out
 
-export TCID=cron03
-export TST_COUNT=3
+	tst_res TINFO "test list installed cron jobs"
 
-$LTPBIN/tst_resm TINFO "Test #3: crontab -l lists the cronjobs installed"
+	create_hello_script $script
+	create_crontab $script
 
-cat > $LTPTMP/tst2_cronjob.cron <<EOF
-* * * * * $LTPTMP/tst2_cronprg.sh
-EOF
+	tst_res TINFO "crontab: listing cron jobs"
+	crontab -l | grep "$script" > $out 2>&1 || \
+		tst_brk TBROK "crontab failed while listing installed cron jobs: `cat $out`"
 
-cat > $LTPTMP/tst2_cronprg.sh <<EOF
-#! /bin/sh
-
-echo "Hello Hell"
-exit 0
-EOF
+	remove_crontab
 
-chmod +x  $LTPTMP/tst2_cronprg.sh >/dev/null 2>&1
-
-$LTPBIN/tst_resm TINFO "Test #3: installing crontab file ..."
-crontab $LTPTMP/tst2_cronjob.cron >$LTPTMP/cron_tst2n1.out 2>&1
-if [ $? -ne 0 ]
-then
-    $LTPBIN/tst_brkm TBROK NULL \
-		"Test #3: crontab failed while installing cronjob"
-    TFAILCNT=$(( $TFAILCNT+1 ))
-else
-    $LTPBIN/tst_resm TINFO "Test #3: Cron job installed."
-fi
-
-crontab -l | grep "$LTPTMP/tst2_cronprg.sh" >$LTPTMP/cron_tst2n1.out 2>&1
-RC=$?
-if [ $RC -ne 0 ]
-then
-	$LTPBIN/tst_brkm TBROK NULL \
-		"Test #3: crontab failed while listing cronjobs installed"
-		 TFAILCNT=$(( $TFAILCNT+1 ))
-else
-	$LTPBIN/tst_resm TINFO \
-		"Test #3: crontab -l listed cronjob tst2_cronprg.sh"
-fi
-
-$LTPBIN/tst_resm TINFO "Test #3: uninstalling crontab file."
-crontab -r >/dev/null 2>&1
-
-if [ $? -ne 0 ]
-then
-	$LTPBIN/tst_brkm TBROK NULL "Test #3: crontab failed while removing cronjob"
-		 TFAILCNT=$(( $TFAILCNT+1 ))
-fi
-
-crontab -l >$LTPTMP/cron_tst2.out 2>&1
-if [ $? -ne 0 ]
-then
-	grep "no crontab for" $LTPTMP/cron_tst2.out >$LTPTMP/cron_tst2n1.out 2>&1
-	RC=$?
-	if [ $RC -ne 0 ]
-	then
-		$LTPBIN/tst_res TFAIL $LTPTMP/cron_tst2n1.out \
-			"Test #3: crontab failed removing cronjob. Reason:"
-		TFAILCNT=$(( $TFAILCNT+1 ))
+	crontab -l > $out 2>&1
+	if [ $? -ne 0 ]; then
+		grep -q "no crontab for" $out
+		if [ $? -ne 0 ]; then
+			tst_res TFAIL "crontab failed removing cron job: `cat $out`"
+		else
+			tst_res TPASS "crontab did not list any cron jobs"
+		fi
 	else
-		$LTPBIN/tst_resm TINFO "crontab uninstalled all jobs for user"
-		$LTPBIN/tst_resm TPASS "crontab did not list any cronjobs"
+		tst_res TFAIL "crontab failed removing cron job: `cat $out`"
+	fi
+}
+
+setup()
+{
+	if [ "$SYSLOG_DAEMON" ]; then
+		status_daemon $SYSLOG_DAEMON
+		if [ $? -ne 0 ]; then
+			restart_daemon $SYSLOG_DAEMON
+			SYSLOG_STARTED=1
+		fi
 	fi
-else
-	$LTPBIN/tst_res TFAIL $LTPTMP/cron_tst2n1.out \
-		"Test #3: crontab failed removing cronjob. Reason:"
-	TFAILCNT=$(( $TFAILCNT+1 ))
-fi
 
-if [ $SYSLOG_STARTED -eq 1 ]; then
-	stop_daemon $SYSLOG_DAEMON
-fi
+	if [ "$CROND_DAEMON" ]; then
+		status_daemon $CROND_DAEMON
+		if [ $? -ne 0 ]; then
+			restart_daemon $CROND_DAEMON
+			CROND_STARTED=1
+		fi
+	fi
 
-exit $TFAILCNT
+	for f in /var/log/syslog /var/log/messages /var/log/cron /var/log/cron.log; do
+		[ -f "$f" ] && LOGS="$f $LOGS"
+	done
+}
+
+cleanup()
+{
+	[ "$SYSLOG_STARTED" = "1" ] && stop_daemon $SYSLOG_DAEMON
+	[ "$CROND_STARTED" = "1" ] && stop_daemon $CROND_DAEMON
+}
+
+do_test()
+{
+	case $1 in
+	1) install_cron_test;;
+	2) remove_cron_job_test;;
+	3) list_cron_jobs_test;;
+	esac
+}
+
+tst_run
-- 
2.12.0

