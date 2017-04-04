From: Jakub Racek <jracek@redhat.com>
Date: Tue,  4 Apr 2017 16:55:17 +0200
Subject: [LTP] [PATCH] syscalls/syslog: mitigate reading syslog issue in
	multiple files
Message-ID: <1491317717-14113-1-git-send-email-jracek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Syslog bash testcases grep syslog file right after writing to it.
Since there's only 2 second delay, the file might be checked too soon,
making the testcase fail.

There's currently no way to force syslog flush. This patch mitigates the
issue by polling the file repeatedly and outputs more info if grepping
fails.

Signed-off-by: Jakub Racek <jracek@redhat.com>
---
 testcases/kernel/syscalls/syslog/syslog-lib.sh | 31 ++++++++++++
 testcases/kernel/syscalls/syslog/syslog01      |  8 ++--
 testcases/kernel/syscalls/syslog/syslog02      | 10 ++--
 testcases/kernel/syscalls/syslog/syslog03      |  6 +--
 testcases/kernel/syscalls/syslog/syslog04      |  7 ++-
 testcases/kernel/syscalls/syslog/syslog05      |  7 +--
 testcases/kernel/syscalls/syslog/syslog07      | 65 ++++++++------------------
 testcases/kernel/syscalls/syslog/syslog08      | 27 ++++++-----
 testcases/kernel/syscalls/syslog/syslog09      | 13 +++---
 testcases/kernel/syscalls/syslog/syslog10      | 13 +++---
 10 files changed, 96 insertions(+), 91 deletions(-)

diff --git a/testcases/kernel/syscalls/syslog/syslog-lib.sh b/testcases/kernel/syscalls/syslog/syslog-lib.sh
index e166d3a..3afd80f 100755
--- a/testcases/kernel/syscalls/syslog/syslog-lib.sh
+++ b/testcases/kernel/syscalls/syslog/syslog-lib.sh
@@ -151,6 +151,37 @@ restart_syslog_daemon()
 	fi
 }
 
+check_syslog_content()
+{
+	logfile=$1
+	newvalue_getter=$2
+	oldvalue_getter=$3
+	cond=$4
+	attempts=$5
+
+	for i in `seq 1 $attempts`;
+	do
+		tst_resm TINFO "reading $logfile, attempt $i"
+
+		if [ $(( `eval $newvalue_getter` - `eval $oldvalue_getter` )) $cond ]; then
+			return 0
+		fi
+		sleep 1
+	done
+
+	tst_resm TFAIL "expected line is not in syslog - giving up."
+	get_info_on_fail "$logfile"
+	return 1
+}
+
+get_info_on_fail()
+{
+	status_daemon systemd-journald
+	status_daemon rsyslog
+	cat $1
+	set -x
+}
+
 export TST_TOTAL=${TST_TOTAL:=1}
 export TST_COUNT=1
 export TCID=${TCID:="$(basename "$0")"}
diff --git a/testcases/kernel/syscalls/syslog/syslog01 b/testcases/kernel/syscalls/syslog/syslog01
index 2f3aea0..ca9edd2 100755
--- a/testcases/kernel/syscalls/syslog/syslog01
+++ b/testcases/kernel/syscalls/syslog/syslog01
@@ -78,16 +78,14 @@ syslog_case1()
 
 	# Call syslogtst executable with case number as argument
 	if syslogtst 1 2>/dev/null; then
-
-		sleep 2
-
 		if [ ! -e $MAILLOG ]; then
 			tst_resm TBROK "$MAILLOG no such log file"
 			cleanup 1
 		fi
+		newvalue_getter="grep -c \"syslogtst: mail info test\" $MAILLOG"
+		check_syslog_content "$MAILLOG" "$newvalue_getter" "echo $oldvalue1" "-eq 1" 25
 
-		newvalue1=`grep -c "syslogtst: mail info test" $MAILLOG`
-		if [ "x$(( $newvalue1 - $oldvalue1 ))" != "x1" ]; then
+		if [ $? -ne 0 ]; then
 			status_flag=1
 		fi
 	else
diff --git a/testcases/kernel/syscalls/syslog/syslog02 b/testcases/kernel/syscalls/syslog/syslog02
index 2213ce3..a7e98db 100755
--- a/testcases/kernel/syscalls/syslog/syslog02
+++ b/testcases/kernel/syscalls/syslog/syslog02
@@ -79,7 +79,6 @@ syslog_case2()
 		if ! syslogtst 2 $level_no 2>/dev/null; then
 			cleanup 1
 		fi
-		sleep 2
 
 		# check if $MAILLOG script exists
 		if [ ! -e "$MAILLOG" ]; then
@@ -87,12 +86,13 @@ syslog_case2()
 			cleanup 1
 		fi
 
-		newvalue=`grep -c "syslogtst: mail $level test" $MAILLOG`
-		diff=$(( $newvalue - $oldvalue ))
-		if [ $diff -eq 0 ]; then
+		newvalue_getter="grep -c \"syslogtst: mail $level test\" $MAILLOG"
+		check_syslog_content "$MAILLOG" "$newvalue_getter" "echo $oldvalue" "-ne 0" 25
+
+		if [ $? -ne 0 ] ; then
 			tst_resm TFAIL "***** Level $level failed *****"
 			status_flag=1
-		elif [ $diff -ge 1 ]; then
+		else
 			tst_resm TPASS "***** Level $level passed *****"
 		fi
 		# Increment the level_no for next level...
diff --git a/testcases/kernel/syscalls/syslog/syslog03 b/testcases/kernel/syscalls/syslog/syslog03
index 31b7fd6..e90040f 100755
--- a/testcases/kernel/syscalls/syslog/syslog03
+++ b/testcases/kernel/syscalls/syslog/syslog03
@@ -65,16 +65,16 @@ syslog_case3()
 	if ! syslogtst 3 2>/dev/null; then
 		cleanup 1
 	fi
-	sleep 2
 
 	# check if /var/log/messages exists
 	if [ ! -e /var/log/messages ]; then
 		tst_resm TBROK "/var/log/messages no such log file"
 		cleanup 1
 	fi
+	newvalue_getter="grep -c \"SYSLOG_CASE3\" /var/log/messages"
+	check_syslog_content "/var/log/messages" "$newvalue_getter" "echo $oldvalue4" "-eq 1" 25
 
-	newvalue4=`grep -c "SYSLOG_CASE3" /var/log/messages`
-	if [ "x$(( $newvalue4 - $oldvalue4 ))" != x1 ]; then
+	if [ $? -ne 0 ]; then
 		status_flag=1
 	fi
 }
diff --git a/testcases/kernel/syscalls/syslog/syslog04 b/testcases/kernel/syscalls/syslog/syslog04
index d1739d3..45ed809 100755
--- a/testcases/kernel/syscalls/syslog/syslog04
+++ b/testcases/kernel/syscalls/syslog/syslog04
@@ -61,16 +61,15 @@ syslog_case4()
 		cleanup 1
 	fi
 
-	sleep 2
-
 	# check if /var/log/messages script exists
 	if [ ! -e /var/log/messages ]; then
 		tst_resm TBROK "/var/log/messages no such log file"
 		cleanup 1
 	fi
+	newvalue_getter="grep -c \"\[$log_pid\]: syslogtst: user info test.\" /var/log/messages"
+	check_syslog_content "/var/log/messages" "$newvalue_getter" "echo 0" "-eq 1" 25
 
-	found=`grep -c "\[$log_pid\]: syslogtst: user info test." /var/log/messages`
-	if [ $found -ne 1 ]; then
+	if [ $? -ne 0 ]; then
 		status_flag=1
 	fi
 }
diff --git a/testcases/kernel/syscalls/syslog/syslog05 b/testcases/kernel/syscalls/syslog/syslog05
index 40dd1fa..4d9f036 100755
--- a/testcases/kernel/syscalls/syslog/syslog05
+++ b/testcases/kernel/syscalls/syslog/syslog05
@@ -70,16 +70,17 @@ syslog_case5()
 	if ! syslogtst 5 2>/dev/null; then
 		cleanup 1
 	fi
-	sleep 2
 
 	# check if /var/log/messages script exists
 	if [ ! -e /var/log/messages ]; then
 		tst_resm TBROK "/var/log/messages no such log file"
 		cleanup 1
 	fi
-	newvalue=`grep -c "syslogtst: info to console test." /var/log/messages`
 
-	if [ "x$(( $newvalue - $oldvalue ))" != "x1" ]; then
+	newvalue_getter="grep -c \"syslogtst: info to console test.\" /var/log/messages"
+	check_syslog_content "/var/log/messages" "$newvalue_getter" "echo $oldvalue" "-eq 1" 25
+
+	if [ $? -ne 0 ]; then
 		status_flag=1
 	fi
 }
diff --git a/testcases/kernel/syscalls/syslog/syslog07 b/testcases/kernel/syscalls/syslog/syslog07
index a24c3e2..332ff70 100755
--- a/testcases/kernel/syscalls/syslog/syslog07
+++ b/testcases/kernel/syscalls/syslog/syslog07
@@ -40,6 +40,7 @@
 
 syslog_case7()
 {
+	LOG_MES="/var/log/messages"
 	tst_resm TINFO "testing syslog priorities ..."
 
 	# Adds some clarification of log message when syslog-ng is used
@@ -56,7 +57,7 @@ syslog_case7()
 	case "$CONFIG_FILE" in
 	/etc/syslog.conf|/etc/rsyslog.conf)
 	        echo "$RSYSLOG_CONFIG" > $CONFIG_FILE
-	        echo "user.debug /var/log/messages" >> $CONFIG_FILE
+	        echo "user.debug $LOG_MES" >> $CONFIG_FILE
 		;;
 
 	/etc/syslog-ng/syslog-ng.conf)
@@ -65,62 +66,36 @@ syslog_case7()
 		echo " " >> $CONFIG_FILE
 		echo "# Added for syslog testcase" >> $CONFIG_FILE
 		echo "filter f_syslog_messages {facility(user); };" >> $CONFIG_FILE
-		echo "destination syslog-messages { file(\"/var/log/messages\");};" >> $CONFIG_FILE
+		echo "destination syslog-messages { file(\"$LOG_MES\");};" >> $CONFIG_FILE
 		echo "log { source(src); filter(f_syslog_messages); destination(syslog-messages); };" >> $CONFIG_FILE
 		;;
 	esac
 
 	restart_syslog_daemon
+	levels="emergency alert critical error warning notice info debug"
 
-	if [ -e /var/log/messages ]; then
-		emerg_old=`grep -c "syslogtst: emergency log" /var/log/messages`
-		alert_old=`grep -c "syslogtst: alert log" /var/log/messages`
-		crit_old=`grep -c "syslogtst: critical log" /var/log/messages`
-		err_old=`grep -c "syslogtst: error log" /var/log/messages`
-		warning_old=`grep -c "syslogtst: warning log" /var/log/messages`
-		notice_old=`grep -c "syslogtst: notice log" /var/log/messages`
-		info_old=`grep -c "syslogtst: info log" /var/log/messages`
-		debug_old=`grep -c "syslogtst: debug log" /var/log/messages`
-	else
-		emerg_old=0
-		alert_old=0
-		crit_old=0
-		err_old=0
-		notice_old=0
-		warning_old=0
-		notice_old=0
-		info_old=0
-		debug_old=0
-	fi
+	for level in $levels
+	do
+		if [ -e $LOG_MES ]; then
+			oldvalue=`grep -c "syslogtst: $level log" $LOG_MES`
+		else
+			oldvalue=0
+		fi
+	done
 
 	# Call syslogtst. It will send the messages of all levels.
 	if ! syslogtst 7 2>/dev/null; then
 		cleanup 1
 	fi
-	sleep 2
-
-	emerg_new=`grep -c "syslogtst: emergency log" /var/log/messages`
-	alert_new=`grep -c "syslogtst: alert log" /var/log/messages`
-	crit_new=`grep -c "syslogtst: critical log" /var/log/messages`
-	err_new=`grep -c "syslogtst: error log" /var/log/messages`
-	warning_new=`grep -c "syslogtst: warning log" /var/log/messages`
-	notice_new=`grep -c "syslogtst: notice log" /var/log/messages`
-	info_new=`grep -c "syslogtst: info log" /var/log/messages`
-	debug_new=`grep -c "syslogtst: debug log" /var/log/messages`
 
-	emerg=$(( $emerg_new - $emerg_old ))
-	alert=$(( $alert_new - $alert_old ))
-	crit=$(( $crit_new - $crit_old ))
-	err=$(( $err_new - $err_old ))
-	warning=$(( $warning_new - $warning_old ))
-	notice=$(( $notice_new - $notice_old ))
-	info=$(( $info_new - $info_old ))
-
-	if [ $emerg -ne 1 -o $alert -ne 1 -o $crit -ne 1 -o $err -ne 1 -o \
-	     $warning -ne 1 -o $notice -ne 1 -o $info -ne 1 -o \
-	     $info -ne 1 ]; then
-		status_flag=1
-	fi
+	for level in $levels
+	do
+		newvalue_getter="grep -c \"syslogtst: $level log\" $LOG_MES"
+		check_syslog_content "$LOG_MES" "$newvalue_getter" "echo $oldvalue" "-eq 1" 25
+		if [ $? -ne 0 ]; then
+			status_flag=1
+		fi
+	done
 }
 
 setup
diff --git a/testcases/kernel/syscalls/syslog/syslog08 b/testcases/kernel/syscalls/syslog/syslog08
index 5388620..4f69f28 100755
--- a/testcases/kernel/syscalls/syslog/syslog08
+++ b/testcases/kernel/syscalls/syslog/syslog08
@@ -87,7 +87,7 @@ syslog_case8()
 			status_flag=1
 			return
 		fi
-		sleep 2
+
 		# check if /var/log/maillog script exists
 		for logf in messages maillog
 		do
@@ -97,23 +97,26 @@ syslog_case8()
 			fi
 		done
 
-		new_mail_check=`grep -c "syslogtst: $facility info test." /var/log/maillog`
-		newvalue=`grep -c "syslogtst: $facility info test." /var/log/messages`
-		diff=$(( $newvalue - $oldvalue ))
-		mail_check=$(( $new_mail_check - $old_mail_check ))
-
 		if [ $facility = "mail" ]; then
-			if [ $mail_check -ne 1 ]; then
+			newvalue_getter="grep -c \"syslogtst: $facility info test.\" /var/log/maillog"
+			check_syslog_content "/var/log/maillog" "$newvalue_getter" "echo $old_mail_check" "-eq 1" 25
+
+			if [ $? -ne 0 ]; then
 				tst_resm TFAIL " Facility $facility failed"
 				status_flag=1
-			elif [ $mail_check -eq 1 ]; then
+			else
 				tst_resm TPASS " Facility $facility passed"
 			fi
-		elif [ $diff -ne 1 ]; then
-			tst_resm TFAIL " Facility $facility failed"
-			status_flag=1
 		else
-			tst_resm TPASS " Facility $facility passed"
+			newvalue_getter="grep -c \"syslogtst: $facility info test.\" /var/log/messages"
+			check_syslog_content "/var/log/messages" "$newvalue_getter" "echo $oldvalue" "-eq 1" 25
+
+			if [ $? -ne 0 ]; then
+				tst_resm TFAIL " Facility $facility failed"
+				status_flag=1
+			else
+				tst_resm TPASS " Facility $facility passed"
+			fi
 		fi
 		# Increment the facility_no for next...
 		: $(( facility_no += 1 ))
diff --git a/testcases/kernel/syscalls/syslog/syslog09 b/testcases/kernel/syscalls/syslog/syslog09
index 9cfafa8..3e44524 100755
--- a/testcases/kernel/syscalls/syslog/syslog09
+++ b/testcases/kernel/syscalls/syslog/syslog09
@@ -67,7 +67,6 @@ syslog_case9()
 	if ! syslogtst 9 2>/dev/null; then
 		cleanup 1
 	fi
-	sleep 2
 
 	# check if /var/log/messages script exists
 	if [ ! -e /var/log/messages ]; then
@@ -75,18 +74,18 @@ syslog_case9()
 		cleanup 1
 	fi
 
-	allow2=`grep -c "syslogtst: error level is logged" /var/log/messages`
-	donot_allow2=`grep -c "syslogtst: warning level not to be logged" /var/log/messages`
+	allow2="grep -c \"syslogtst: error level is logged\" /var/log/messages"
+	donot_allow2="grep -c \"syslogtst: warning level not to be logged\" /var/log/messages"
 
-	diff1=$(( $allow2 - $allow1 ))
-	if [ $diff1 -ne 1 ]; then
+	check_syslog_content "/var/log/messages" "$allow2" "echo $allow1" "-eq 1" 25
+	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "Expected message was not logged...."
 		status_flag=1
 		return
 	fi
 
-	diff2=$(( $donot_allow2 - $donot_allow1 ))
-	if [ $diff2 -ne 0 ]; then
+	check_syslog_content "/var/log/messages" "$donot_allow2" "echo $donot_allow1" "-eq 0" 25
+	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "Unexpected message was logged..."
 		status_flag=1
 	fi
diff --git a/testcases/kernel/syscalls/syslog/syslog10 b/testcases/kernel/syscalls/syslog/syslog10
index 573ab75..e743ec7 100755
--- a/testcases/kernel/syscalls/syslog/syslog10
+++ b/testcases/kernel/syscalls/syslog/syslog10
@@ -69,7 +69,6 @@ syslog_case10()
 		status_flag=1
 		return
 	fi
-	sleep 2
 
 	# check if /var/log/messages script exists
 	if [ ! -e /var/log/messages ]; then
@@ -77,18 +76,18 @@ syslog_case10()
 		cleanup 1
 	fi
 
-	allow2=`grep -c "syslogtst:10 error level is logged" /var/log/messages`
-	donot_allow2=`grep -c "syslogtst:10 warning level not to be logged" /var/log/messages`
+	allow2="grep -c \"syslogtst:10 error level is logged\" /var/log/messages"
+	donot_allow2="grep -c \"syslogtst:10 warning level not to be logged\" /var/log/messages"
 
-	diff1=$(( $allow2 - $allow1 ))
-	if [ $diff1 -ne 1 ]; then
+	check_syslog_content "/var/log/messages" "$allow2" "echo $allow1" "-eq 1" 25
+	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "Expected message was not logged...."
 		status_flag=1
 		return
 	fi
 
-	diff2=$(( $donot_allow2 - $donot_allow1 ))
-	if [ $diff2 -ne 0 ]; then
+	check_syslog_content "/var/log/messages" "$donot_allow2" "echo $donot_allow1" "-eq 0" 25
+	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "Unexpected message was logged..."
 		status_flag=1
 	fi
-- 
1.8.3.1

