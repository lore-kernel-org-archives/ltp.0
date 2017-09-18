From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Mon, 18 Sep 2017 19:35:49 +0800
Subject: [LTP] [PATCH] syscalls/syslog: Fix log file paths for different
	distros
Message-ID: <20170918113549.30373-1-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In various distros (e.g. RedHat/Debian) the paths are different:

RHEL	*.*	/var/log/messages
	mail.*	/var/log/maillog

Ubuntu	*.*	/var/log/syslog
	mail.*	/var/log/mail.log

Fix this by getting the paths from config file instead of hard code

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/syslog/syslog-lib.sh |  7 ++++-
 testcases/kernel/syscalls/syslog/syslog01      |  4 +--
 testcases/kernel/syscalls/syslog/syslog03      | 16 +++++------
 testcases/kernel/syscalls/syslog/syslog04      | 12 ++++----
 testcases/kernel/syscalls/syslog/syslog05      | 18 ++++++------
 testcases/kernel/syscalls/syslog/syslog06      |  4 +--
 testcases/kernel/syscalls/syslog/syslog07      | 38 +++++++++++++-------------
 testcases/kernel/syscalls/syslog/syslog08      | 22 +++++++--------
 testcases/kernel/syscalls/syslog/syslog09      | 20 +++++++-------
 testcases/kernel/syscalls/syslog/syslog10      | 20 +++++++-------
 10 files changed, 83 insertions(+), 78 deletions(-)

diff --git a/testcases/kernel/syscalls/syslog/syslog-lib.sh b/testcases/kernel/syscalls/syslog/syslog-lib.sh
index 35c13da..0d4be20 100755
--- a/testcases/kernel/syscalls/syslog/syslog-lib.sh
+++ b/testcases/kernel/syscalls/syslog/syslog-lib.sh
@@ -18,7 +18,8 @@
 
 ##################################################################
 
-readonly MAILLOG=/var/log/maillog
+MAILLOG=/var/log/maillog
+ALLLOG=/var/log/messages
 
 # Signals to trap.
 readonly TRAP_SIGS="1 2 3 6 11 15"
@@ -71,6 +72,10 @@ setup()
 		CONFIG_FILE="/etc/syslog-ng/syslog-ng.conf"
 	elif [ "$SYSLOG_DAEMON" = "rsyslog" ]; then
 		CONFIG_FILE="/etc/rsyslog.conf"
+		MAILLOG=`awk '/^mail\.\*.*\/var\/log/ {print $2}' \
+			/etc/rsyslog.conf | cut -d '-' -f 2`
+		ALLLOG=`awk '/^\*.*\/var\/log/ {print $2}' \
+			/etc/rsyslog.conf | cut -d '-' -f 2`
 		if grep -q -r '^\$ModLoad[[:space:]]*imjournal' /etc/rsyslog.conf /etc/rsyslog.d/ ; then
 			systemd_journal=$(grep -Ehoi "^[^#].*(imjournal|workdirectory).*" -r /etc/rsyslog.conf /etc/rsyslog.d/)
 			RSYSLOG_CONFIG=$(cat <<EOF
diff --git a/testcases/kernel/syscalls/syslog/syslog01 b/testcases/kernel/syscalls/syslog/syslog01
index 2f3aea0..7d90add 100755
--- a/testcases/kernel/syscalls/syslog/syslog01
+++ b/testcases/kernel/syscalls/syslog/syslog01
@@ -45,7 +45,7 @@ syslog_case1()
 	case "$CONFIG_FILE" in
 	/etc/syslog.conf|/etc/rsyslog.conf)
 		echo "$RSYSLOG_CONFIG" > $CONFIG_FILE
-		echo "*.crit		/var/log/messages" >> $CONFIG_FILE
+		echo "*.crit		$ALLLOG" >> $CONFIG_FILE
 		echo "mail.info	$MAILLOG" >> $CONFIG_FILE
 		;;
 
@@ -57,7 +57,7 @@ syslog_case1()
 		echo "# Added for syslog testcase"  >> $CONFIG_FILE
 		echo "filter f_syslog	 { level(crit);};" >> $CONFIG_FILE
 		echo "filter f_syslogMail { level(info)	and facility(mail); };" >> $CONFIG_FILE
-		echo "destination syslog-messages { file(\"/var/log/messages\");};" >> $CONFIG_FILE
+		echo "destination syslog-messages { file(\"$ALLLOG\");};" >> $CONFIG_FILE
 		echo "log { source(src); filter(f_syslog); destination(syslog-messages); };" >> $CONFIG_FILE
 		echo "destination syslog-mail { file(\"$MAILLOG\");};" >> $CONFIG_FILE
 		echo "log { source(src); filter(f_syslogMail); destination(syslog-mail); };"  >> $CONFIG_FILE
diff --git a/testcases/kernel/syscalls/syslog/syslog03 b/testcases/kernel/syscalls/syslog/syslog03
index 31b7fd6..6d7dda1 100755
--- a/testcases/kernel/syscalls/syslog/syslog03
+++ b/testcases/kernel/syscalls/syslog/syslog03
@@ -40,7 +40,7 @@ syslog_case3()
 	case "$CONFIG_FILE" in
 	/etc/syslog.conf|/etc/rsyslog.conf)
 		echo "$RSYSLOG_CONFIG" > $CONFIG_FILE
-		echo "daemon.info	/var/log/messages" >> $CONFIG_FILE
+		echo "daemon.info	$ALLLOG" >> $CONFIG_FILE
 		;;
 
 	/etc/syslog-ng/syslog-ng.conf)
@@ -48,7 +48,7 @@ syslog_case3()
 		echo " " >> $CONFIG_FILE
 		echo "# Added for syslog testcase"  >> $CONFIG_FILE
 		echo "filter f_syslog_daemon { level(info) and facility(daemon); }; " >> $CONFIG_FILE
-		echo "destination syslog-messages { file(\"/var/log/messages\");};" >> $CONFIG_FILE
+		echo "destination syslog-messages { file(\"$ALLLOG\");};" >> $CONFIG_FILE
 		echo "log { source(src); filter(f_syslog_daemon); destination(syslog-messages);};"  >> $CONFIG_FILE
 		;;
 	esac
@@ -56,8 +56,8 @@ syslog_case3()
 	restart_syslog_daemon
 
 	# Grep for the ident prefix: SYSLOG_CASE3 in the log file.
-	if [ -e /var/log/messages ]; then
-		oldvalue4=`grep -c "SYSLOG_CASE3" /var/log/messages`
+	if [ -e $ALLLOG ]; then
+		oldvalue4=`grep -c "SYSLOG_CASE3" $ALLLOG`
 	else
 		oldvalue4=0
 	fi
@@ -67,13 +67,13 @@ syslog_case3()
 	fi
 	sleep 2
 
-	# check if /var/log/messages exists
-	if [ ! -e /var/log/messages ]; then
-		tst_resm TBROK "/var/log/messages no such log file"
+	# check if $ALLLOG exists
+	if [ ! -e $ALLLOG ]; then
+		tst_resm TBROK "$ALLLOG no such log file"
 		cleanup 1
 	fi
 
-	newvalue4=`grep -c "SYSLOG_CASE3" /var/log/messages`
+	newvalue4=`grep -c "SYSLOG_CASE3" $ALLLOG`
 	if [ "x$(( $newvalue4 - $oldvalue4 ))" != x1 ]; then
 		status_flag=1
 	fi
diff --git a/testcases/kernel/syscalls/syslog/syslog04 b/testcases/kernel/syscalls/syslog/syslog04
index d1739d3..2da5978 100755
--- a/testcases/kernel/syscalls/syslog/syslog04
+++ b/testcases/kernel/syscalls/syslog/syslog04
@@ -40,14 +40,14 @@ syslog_case4()
 	case "$CONFIG_FILE" in
 	/etc/syslog.conf|/etc/rsyslog.conf)
 		echo "$RSYSLOG_CONFIG" > $CONFIG_FILE
-		echo "user.info        /var/log/messages" >> $CONFIG_FILE
+		echo "user.info        $ALLLOG" >> $CONFIG_FILE
 		;;
 
 	/etc/syslog-ng/syslog-ng.conf)
 		echo "source src{ internal(); unix-dgram(\"/dev/log\"); udp(ip(\"0.0.0.0\") port(514)); };" > $CONFIG_FILE
 		echo " " >> $CONFIG_FILE
 		echo "filter f_syslog_user { level(info) and facility(user); };" >> $CONFIG_FILE
-		echo "destination syslog_messages { file(\"/var/log/messages\");};" >> $CONFIG_FILE
+		echo "destination syslog_messages { file(\"$ALLLOG\");};" >> $CONFIG_FILE
 		echo "log { source(src); filter(f_syslog_user); destination(syslog_messages);};"  >> $CONFIG_FILE
 		;;
 	esac
@@ -63,13 +63,13 @@ syslog_case4()
 
 	sleep 2
 
-	# check if /var/log/messages script exists
-	if [ ! -e /var/log/messages ]; then
-		tst_resm TBROK "/var/log/messages no such log file"
+	# check if $ALLLOG script exists
+	if [ ! -e $ALLLOG ]; then
+		tst_resm TBROK "$ALLLOG no such log file"
 		cleanup 1
 	fi
 
-	found=`grep -c "\[$log_pid\]: syslogtst: user info test." /var/log/messages`
+	found=`grep -c "\[$log_pid\]: syslogtst: user info test." $ALLLOG`
 	if [ $found -ne 1 ]; then
 		status_flag=1
 	fi
diff --git a/testcases/kernel/syscalls/syslog/syslog05 b/testcases/kernel/syscalls/syslog/syslog05
index 40dd1fa..e90e0de 100755
--- a/testcases/kernel/syscalls/syslog/syslog05
+++ b/testcases/kernel/syscalls/syslog/syslog05
@@ -45,22 +45,22 @@ syslog_case5()
 	case "$CONFIG_FILE" in
 	/etc/syslog.conf|/etc/rsyslog.conf)
 		echo "$RSYSLOG_CONFIG" > $CONFIG_FILE
-		echo "user.info	/var/log/messages" >> $CONFIG_FILE
+		echo "user.info	$ALLLOG" >> $CONFIG_FILE
 		;;
 
 	/etc/syslog-ng/syslog-ng.conf)
 		echo "source src{ internal(); unix-dgram(\"/dev/log\"); udp(ip(\"0.0.0.0\") port(514)); };" > $CONFIG_FILE
 		echo "filter f_syslog_user { level(info)      and facility(user); };" >> $CONFIG_FILE
-		echo "destination syslog-messages { file(\"/var/log/messages\");};" >> $CONFIG_FILE
+		echo "destination syslog-messages { file(\"$ALLLOG\");};" >> $CONFIG_FILE
 		echo "log { source(src); filter(f_syslog_user); destination(syslog-messages);};" >> $CONFIG_FILE
 		;;
 	esac
 
 	restart_syslog_daemon
 
-	# check if /var/log/messages script exists
-	if [ -e /var/log/messages ]; then
-		oldvalue=`grep -c "syslogtst: info to console test." /var/log/messages`
+	# check if $ALLLOG script exists
+	if [ -e $ALLLOG ]; then
+		oldvalue=`grep -c "syslogtst: info to console test." $ALLLOG`
 	else
 		oldvalue=0
 	fi
@@ -72,12 +72,12 @@ syslog_case5()
 	fi
 	sleep 2
 
-	# check if /var/log/messages script exists
-	if [ ! -e /var/log/messages ]; then
-		tst_resm TBROK "/var/log/messages no such log file"
+	# check if $ALLLOG script exists
+	if [ ! -e $ALLLOG ]; then
+		tst_resm TBROK "$ALLLOG no such log file"
 		cleanup 1
 	fi
-	newvalue=`grep -c "syslogtst: info to console test." /var/log/messages`
+	newvalue=`grep -c "syslogtst: info to console test." $ALLLOG`
 
 	if [ "x$(( $newvalue - $oldvalue ))" != "x1" ]; then
 		status_flag=1
diff --git a/testcases/kernel/syscalls/syslog/syslog06 b/testcases/kernel/syscalls/syslog/syslog06
index 7050fd2..c3f7e7d 100755
--- a/testcases/kernel/syscalls/syslog/syslog06
+++ b/testcases/kernel/syscalls/syslog/syslog06
@@ -45,13 +45,13 @@ syslog_case6()
 	case "$CONFIG_FILE" in
 	/etc/syslog.conf|/etc/rsyslog.conf)
 		echo "$RSYSLOG_CONFIG" > $CONFIG_FILE
-		echo "user.info        /var/log/messages" >> $CONFIG_FILE
+		echo "user.info        $ALLLOG" >> $CONFIG_FILE
 		;;
 
 	/etc/syslog-ng/syslog-ng.conf)
 		echo "source src{ internal(); unix-dgram(\"/dev/log\"); udp(ip(\"0.0.0.0\") port(514)); };" > $CONFIG_FILE
 		echo "filter f_syslog_user { level(info) and facility(user); };">> $CONFIG_FILE
-		echo "destination syslog-messages { file(\"/var/log/messages\");};" >> $CONFIG_FILE
+		echo "destination syslog-messages { file(\"$ALLLOG\");};" >> $CONFIG_FILE
 		echo "log { source(src); filter(f_syslog_user); destination(syslog-messages);};" >> $CONFIG_FILE
 		;;
 	esac
diff --git a/testcases/kernel/syscalls/syslog/syslog07 b/testcases/kernel/syscalls/syslog/syslog07
index a24c3e2..26a3cc5 100755
--- a/testcases/kernel/syscalls/syslog/syslog07
+++ b/testcases/kernel/syscalls/syslog/syslog07
@@ -56,7 +56,7 @@ syslog_case7()
 	case "$CONFIG_FILE" in
 	/etc/syslog.conf|/etc/rsyslog.conf)
 	        echo "$RSYSLOG_CONFIG" > $CONFIG_FILE
-	        echo "user.debug /var/log/messages" >> $CONFIG_FILE
+	        echo "user.debug $ALLLOG" >> $CONFIG_FILE
 		;;
 
 	/etc/syslog-ng/syslog-ng.conf)
@@ -65,22 +65,22 @@ syslog_case7()
 		echo " " >> $CONFIG_FILE
 		echo "# Added for syslog testcase" >> $CONFIG_FILE
 		echo "filter f_syslog_messages {facility(user); };" >> $CONFIG_FILE
-		echo "destination syslog-messages { file(\"/var/log/messages\");};" >> $CONFIG_FILE
+		echo "destination syslog-messages { file(\"$ALLLOG\");};" >> $CONFIG_FILE
 		echo "log { source(src); filter(f_syslog_messages); destination(syslog-messages); };" >> $CONFIG_FILE
 		;;
 	esac
 
 	restart_syslog_daemon
 
-	if [ -e /var/log/messages ]; then
-		emerg_old=`grep -c "syslogtst: emergency log" /var/log/messages`
-		alert_old=`grep -c "syslogtst: alert log" /var/log/messages`
-		crit_old=`grep -c "syslogtst: critical log" /var/log/messages`
-		err_old=`grep -c "syslogtst: error log" /var/log/messages`
-		warning_old=`grep -c "syslogtst: warning log" /var/log/messages`
-		notice_old=`grep -c "syslogtst: notice log" /var/log/messages`
-		info_old=`grep -c "syslogtst: info log" /var/log/messages`
-		debug_old=`grep -c "syslogtst: debug log" /var/log/messages`
+	if [ -e $ALLLOG ]; then
+		emerg_old=`grep -c "syslogtst: emergency log" $ALLLOG`
+		alert_old=`grep -c "syslogtst: alert log" $ALLLOG`
+		crit_old=`grep -c "syslogtst: critical log" $ALLLOG`
+		err_old=`grep -c "syslogtst: error log" $ALLLOG`
+		warning_old=`grep -c "syslogtst: warning log" $ALLLOG`
+		notice_old=`grep -c "syslogtst: notice log" $ALLLOG`
+		info_old=`grep -c "syslogtst: info log" $ALLLOG`
+		debug_old=`grep -c "syslogtst: debug log" $ALLLOG`
 	else
 		emerg_old=0
 		alert_old=0
@@ -99,14 +99,14 @@ syslog_case7()
 	fi
 	sleep 2
 
-	emerg_new=`grep -c "syslogtst: emergency log" /var/log/messages`
-	alert_new=`grep -c "syslogtst: alert log" /var/log/messages`
-	crit_new=`grep -c "syslogtst: critical log" /var/log/messages`
-	err_new=`grep -c "syslogtst: error log" /var/log/messages`
-	warning_new=`grep -c "syslogtst: warning log" /var/log/messages`
-	notice_new=`grep -c "syslogtst: notice log" /var/log/messages`
-	info_new=`grep -c "syslogtst: info log" /var/log/messages`
-	debug_new=`grep -c "syslogtst: debug log" /var/log/messages`
+	emerg_new=`grep -c "syslogtst: emergency log" $ALLLOG`
+	alert_new=`grep -c "syslogtst: alert log" $ALLLOG`
+	crit_new=`grep -c "syslogtst: critical log" $ALLLOG`
+	err_new=`grep -c "syslogtst: error log" $ALLLOG`
+	warning_new=`grep -c "syslogtst: warning log" $ALLLOG`
+	notice_new=`grep -c "syslogtst: notice log" $ALLLOG`
+	info_new=`grep -c "syslogtst: info log" $ALLLOG`
+	debug_new=`grep -c "syslogtst: debug log" $ALLLOG`
 
 	emerg=$(( $emerg_new - $emerg_old ))
 	alert=$(( $alert_new - $alert_old ))
diff --git a/testcases/kernel/syscalls/syslog/syslog08 b/testcases/kernel/syscalls/syslog/syslog08
index 5388620..1999458 100755
--- a/testcases/kernel/syscalls/syslog/syslog08
+++ b/testcases/kernel/syscalls/syslog/syslog08
@@ -52,15 +52,15 @@ syslog_case8()
 		case "$CONFIG_FILE" in
 		/etc/syslog.conf|/etc/rsyslog.conf)
 			echo "$RSYSLOG_CONFIG" > $CONFIG_FILE
-			echo "$facility.info	/var/log/messages" >> $CONFIG_FILE
-			echo "$facility.info	/var/log/maillog" >> $CONFIG_FILE
+			echo "$facility.info	$ALLLOG" >> $CONFIG_FILE
+			echo "$facility.info	$MAILLOG" >> $CONFIG_FILE
 			;;
 
 		/etc/syslog-ng/syslog-ng.conf)
 			echo "source src{ internal(); unix-dgram(\"/dev/log\"); udp(ip(\"0.0.0.0\") port(514)); };" > $CONFIG_FILE
 			echo "filter f_syslog-$facility { level(info) and facility($facility); };" >> $CONFIG_FILE
-			echo "destination syslog-messages { file(\"/var/log/messages\"); };" >> $CONFIG_FILE
-			echo "destination syslog-mail { file(\"/var/log/maillog\");};" >> $CONFIG_FILE
+			echo "destination syslog-messages { file(\"$ALLLOG\"); };" >> $CONFIG_FILE
+			echo "destination syslog-mail { file(\"$MAILLOG\");};" >> $CONFIG_FILE
 			echo "log { source(src); filter(f_syslog-$facility); destination(syslog-mail); };"  >> $CONFIG_FILE
 			echo "log { source(src); filter(f_syslog-$facility); destination(syslog-messages); };"  >> $CONFIG_FILE
 			;;
@@ -69,14 +69,14 @@ syslog_case8()
 
 		restart_syslog_daemon
 
-		if [ -e /var/log/messages ]; then
-			oldvalue=`grep -c "syslogtst: $facility info test." /var/log/messages`
+		if [ -e $ALLLOG ]; then
+			oldvalue=`grep -c "syslogtst: $facility info test." $ALLLOG`
 		else
 			oldvalue=0
 		fi
 
-		if [ -e /var/log/maillog ]; then
-			old_mail_check=`grep -c "syslogtst: $facility info test." /var/log/maillog`
+		if [ -e $MAILLOG ]; then
+			old_mail_check=`grep -c "syslogtst: $facility info test." $MAILLOG`
 		else
 			old_mail_check=0
 		fi
@@ -88,7 +88,7 @@ syslog_case8()
 			return
 		fi
 		sleep 2
-		# check if /var/log/maillog script exists
+		# check if $MAILLOG script exists
 		for logf in messages maillog
 		do
 			if [ ! -e /var/log/$logf ]; then
@@ -97,8 +97,8 @@ syslog_case8()
 			fi
 		done
 
-		new_mail_check=`grep -c "syslogtst: $facility info test." /var/log/maillog`
-		newvalue=`grep -c "syslogtst: $facility info test." /var/log/messages`
+		new_mail_check=`grep -c "syslogtst: $facility info test." $MAILLOG`
+		newvalue=`grep -c "syslogtst: $facility info test." $ALLLOG`
 		diff=$(( $newvalue - $oldvalue ))
 		mail_check=$(( $new_mail_check - $old_mail_check ))
 
diff --git a/testcases/kernel/syscalls/syslog/syslog09 b/testcases/kernel/syscalls/syslog/syslog09
index 9cfafa8..564eece 100755
--- a/testcases/kernel/syscalls/syslog/syslog09
+++ b/testcases/kernel/syscalls/syslog/syslog09
@@ -42,23 +42,23 @@ syslog_case9()
 	case "$CONFIG_FILE" in
 	/etc/syslog.conf|/etc/rsyslog.conf)
 		echo "$RSYSLOG_CONFIG" > $CONFIG_FILE
-		echo "user.debug       /var/log/messages" >> $CONFIG_FILE
+		echo "user.debug       $ALLLOG" >> $CONFIG_FILE
 		;;
 
 	/etc/syslog-ng/syslog-ng.conf)
 		echo "source src{ internal(); unix-dgram(\"/dev/log\"); udp(ip(\"0.0.0.0\") port(514)); };" > $CONFIG_FILE
 		#echo "filter f_syslog_debug { level(debug) and facility(user); };" >> $CONFIG_FILE
 		echo "filter f_syslog_debug { facility(user); };" >> $CONFIG_FILE
-		echo "destination syslog-messages { file(\"/var/log/messages\");};" >> $CONFIG_FILE
+		echo "destination syslog-messages { file(\"$ALLLOG\");};" >> $CONFIG_FILE
 		echo "log { source(src); filter(f_syslog_debug); destination(syslog-messages);};" >> $CONFIG_FILE
 		;;
 	esac
 
 	restart_syslog_daemon
 
-	if [ -e /var/log/messages ]; then
-		allow1=`grep -c "syslogtst: error level is logged" /var/log/messages`
-		donot_allow1=`grep -c "syslogtst: warning level not to be logged" /var/log/messages`
+	if [ -e $ALLLOG ]; then
+		allow1=`grep -c "syslogtst: error level is logged" $ALLLOG`
+		donot_allow1=`grep -c "syslogtst: warning level not to be logged" $ALLLOG`
 	else
 		allow1=0
 		donot_allow1=0
@@ -69,14 +69,14 @@ syslog_case9()
 	fi
 	sleep 2
 
-	# check if /var/log/messages script exists
-	if [ ! -e /var/log/messages ]; then
-		tst_resm TBROK "/var/log/messages no such log file"
+	# check if $ALLLOG script exists
+	if [ ! -e $ALLLOG ]; then
+		tst_resm TBROK "$ALLLOG no such log file"
 		cleanup 1
 	fi
 
-	allow2=`grep -c "syslogtst: error level is logged" /var/log/messages`
-	donot_allow2=`grep -c "syslogtst: warning level not to be logged" /var/log/messages`
+	allow2=`grep -c "syslogtst: error level is logged" $ALLLOG`
+	donot_allow2=`grep -c "syslogtst: warning level not to be logged" $ALLLOG`
 
 	diff1=$(( $allow2 - $allow1 ))
 	if [ $diff1 -ne 1 ]; then
diff --git a/testcases/kernel/syscalls/syslog/syslog10 b/testcases/kernel/syscalls/syslog/syslog10
index 573ab75..5025eac 100755
--- a/testcases/kernel/syscalls/syslog/syslog10
+++ b/testcases/kernel/syscalls/syslog/syslog10
@@ -43,13 +43,13 @@ syslog_case10()
 	case "$CONFIG_FILE" in
 	/etc/syslog.conf|/etc/rsyslog.conf)
 		echo "$RSYSLOG_CONFIG" > $CONFIG_FILE
-		echo "user.debug       /var/log/messages" >> $CONFIG_FILE
+		echo "user.debug       $ALLLOG" >> $CONFIG_FILE
 		;;
 
 	/etc/syslog-ng/syslog-ng.conf)
 		echo "source src{ internal(); unix-dgram(\"/dev/log\"); udp(ip(\"0.0.0.0\") port(514)); };" > $CONFIG_FILE
 		echo "filter f_syslog_debug{ facility(user); };" >> $CONFIG_FILE
-		echo "destination syslog_messages { file(\"/var/log/messages\");};" >> $CONFIG_FILE
+		echo "destination syslog_messages { file(\"$ALLLOG\");};" >> $CONFIG_FILE
 		echo "log { source(src); filter(f_syslog_debug); destination(syslog_messages); };" >> $CONFIG_FILE
 		;;
 
@@ -57,9 +57,9 @@ syslog_case10()
 
 	restart_syslog_daemon
 
-	if [ -e /var/log/messages ]; then
-		allow1=`grep -c "syslogtst:10 error level is logged" /var/log/messages`
-		donot_allow1=`grep -c "syslogtst:10 warning level not to be logged" /var/log/messages`
+	if [ -e $ALLLOG ]; then
+		allow1=`grep -c "syslogtst:10 error level is logged" $ALLLOG`
+		donot_allow1=`grep -c "syslogtst:10 warning level not to be logged" $ALLLOG`
 	else
 		allow1=0
 		donot_allow1=0
@@ -71,14 +71,14 @@ syslog_case10()
 	fi
 	sleep 2
 
-	# check if /var/log/messages script exists
-	if [ ! -e /var/log/messages ]; then
-		tst_resm TBROK "/var/log/messages no such log file"
+	# check if $ALLLOG script exists
+	if [ ! -e $ALLLOG ]; then
+		tst_resm TBROK "$ALLLOG no such log file"
 		cleanup 1
 	fi
 
-	allow2=`grep -c "syslogtst:10 error level is logged" /var/log/messages`
-	donot_allow2=`grep -c "syslogtst:10 warning level not to be logged" /var/log/messages`
+	allow2=`grep -c "syslogtst:10 error level is logged" $ALLLOG`
+	donot_allow2=`grep -c "syslogtst:10 warning level not to be logged" $ALLLOG`
 
 	diff1=$(( $allow2 - $allow1 ))
 	if [ $diff1 -ne 1 ]; then
-- 
2.9.4



