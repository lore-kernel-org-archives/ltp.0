Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F0EC433F5
	for <ltp@archiver.kernel.org>; Wed,  6 Apr 2022 19:37:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E7E83CA4A2
	for <ltp@archiver.kernel.org>; Wed,  6 Apr 2022 21:37:11 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCD163C176B
 for <ltp@lists.linux.it>; Wed,  6 Apr 2022 21:36:59 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6AEA51A00152
 for <ltp@lists.linux.it>; Wed,  6 Apr 2022 21:36:56 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E3FAD1F38A;
 Wed,  6 Apr 2022 19:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1649273815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=G2GWye/XJyl5WzlllWfAzZCP5bAV1HlGOKZch73RfPE=;
 b=jbCrNwq96SnlJGFu1tr3fIvQ8zk6jq7y1L2NzRawrrqCyqFdiwarHTZJ7otRcc2k/yJ1DX
 YAcZ8HnK8RHlTGam/JOyz0QXqHgzBbjDv3Tcn1rkfDFsQcWNZYQvVyzCV6mMNWqjsEjB1Z
 i7Ngbq6LAs1meLbSEz9BX2RT9SeGqS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1649273815;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=G2GWye/XJyl5WzlllWfAzZCP5bAV1HlGOKZch73RfPE=;
 b=qTpqg2s4bIohJyHY4b8dRTYCT81Cdp137uB+tyWcGU+xw9ZCTPU8FwPkoiYhAv3dcJwjkY
 aROh657XNlNG5sCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC8F813A8E;
 Wed,  6 Apr 2022 19:36:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CwcxJ9brTWLlGQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 06 Apr 2022 19:36:54 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  6 Apr 2022 21:36:50 +0200
Message-Id: <20220406193650.15653-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 1/1] Remove syslog shell tests
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

They always had sporadic failures that were related to configuration
(rsyslog config, journald rate-limiting, etc.) and lot of sleep to
restart daemon dozens of times.

+ there are tests which cover syslog() syscall (kmsg01.c, syslog11.c,
  syslog12.c)

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/syscalls                              |  10 -
 testcases/kernel/syscalls/syslog/Makefile     |   3 -
 .../kernel/syscalls/syslog/syslog-lib.sh      | 161 ---------
 testcases/kernel/syscalls/syslog/syslog01     | 108 ------
 testcases/kernel/syscalls/syslog/syslog02     | 111 ------
 testcases/kernel/syscalls/syslog/syslog03     |  87 -----
 testcases/kernel/syscalls/syslog/syslog04     |  84 -----
 testcases/kernel/syscalls/syslog/syslog05     |  96 -----
 testcases/kernel/syscalls/syslog/syslog06     |  76 ----
 testcases/kernel/syscalls/syslog/syslog07     | 128 -------
 testcases/kernel/syscalls/syslog/syslog08     | 132 -------
 testcases/kernel/syscalls/syslog/syslog09     | 103 ------
 testcases/kernel/syscalls/syslog/syslog10     | 108 ------
 testcases/kernel/syscalls/syslog/syslogtst.c  | 341 ------------------
 14 files changed, 1548 deletions(-)
 delete mode 100755 testcases/kernel/syscalls/syslog/syslog-lib.sh
 delete mode 100755 testcases/kernel/syscalls/syslog/syslog01
 delete mode 100755 testcases/kernel/syscalls/syslog/syslog02
 delete mode 100755 testcases/kernel/syscalls/syslog/syslog03
 delete mode 100755 testcases/kernel/syscalls/syslog/syslog04
 delete mode 100755 testcases/kernel/syscalls/syslog/syslog05
 delete mode 100755 testcases/kernel/syscalls/syslog/syslog06
 delete mode 100755 testcases/kernel/syscalls/syslog/syslog07
 delete mode 100755 testcases/kernel/syscalls/syslog/syslog08
 delete mode 100755 testcases/kernel/syscalls/syslog/syslog09
 delete mode 100755 testcases/kernel/syscalls/syslog/syslog10
 delete mode 100644 testcases/kernel/syscalls/syslog/syslogtst.c

diff --git a/runtest/syscalls b/runtest/syscalls
index c30383ee58..58adbbee7d 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1559,16 +1559,6 @@ sysinfo01 sysinfo01
 sysinfo02 sysinfo02
 sysinfo03 sysinfo03
 
-syslog01 syslog01
-syslog02 syslog02
-syslog03 syslog03
-syslog04 syslog04
-syslog05 syslog05
-syslog06 syslog06
-syslog07 syslog07
-syslog08 syslog08
-syslog09 syslog09
-syslog10 syslog10
 syslog11 syslog11
 syslog12 syslog12
 
diff --git a/testcases/kernel/syscalls/syslog/Makefile b/testcases/kernel/syscalls/syslog/Makefile
index f6b1e6a0f0..044619fb87 100644
--- a/testcases/kernel/syscalls/syslog/Makefile
+++ b/testcases/kernel/syscalls/syslog/Makefile
@@ -5,7 +5,4 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-# Not all of the syslog* files are bourne shell scripts.
-INSTALL_TARGETS		:= syslog0* syslog10 syslog-lib.sh
-
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/syslog/syslog-lib.sh b/testcases/kernel/syscalls/syslog/syslog-lib.sh
deleted file mode 100755
index eed501d9b3..0000000000
--- a/testcases/kernel/syscalls/syslog/syslog-lib.sh
+++ /dev/null
@@ -1,161 +0,0 @@
-#! /bin/sh
-#
-#  Copyright (c) Linux Test Project, 2010
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-
-##################################################################
-
-readonly MAILLOG=/var/log/maillog
-
-# Signals to trap.
-readonly TRAP_SIGS="1 2 3 6 11 15"
-
-# configuration file for syslog or syslog-ng
-CONFIG_FILE=""
-
-# rsyslogd .conf specific args.
-RSYSLOG_CONFIG=
-
-# number of seconds to wait for another syslog test to complete
-WAIT_COUNT=60
-
-cleanup()
-{
-	# Reentrant cleanup -> bad. Especially since rsyslogd on Fedora 13
-	# seems to get stuck FOREVER when not running as root. Lame...
-	disable_traps
-	exit_code=$1
-
-	# Restore the previous syslog daemon state.
-	if [ -f "$CONFIG_FILE.ltpback" ]; then
-		if mv "$CONFIG_FILE.ltpback" "$CONFIG_FILE"; then
-			# Make sure that restart_syslog_daemon doesn't loop
-			# back to cleanup again.
-			restart_syslog_daemon "return 1"
-			# Maintain any nonzero exit codes
-			if [ $exit_code -ne $? ]; then
-				exit_code=1
-			fi
-		else
-			exit_code=1
-		fi
-	fi
-
-	exit $exit_code
-}
-
-setup()
-{
-	tst_require_root
-
-	trap '	disable_traps
-		tst_resm TBROK "Testing is terminating due to a signal"
-		cleanup 1' $TRAP_SIGS || exit 1
-
-	if [ "$SYSLOG_DAEMON" = "syslog" ]; then
-		CONFIG_FILE="/etc/syslog.conf"
-	elif [ "$SYSLOG_DAEMON" = "syslog-ng" ]; then
-		CONFIG_FILE="/etc/syslog-ng/syslog-ng.conf"
-	elif [ "$SYSLOG_DAEMON" = "rsyslog" ]; then
-		CONFIG_FILE="/etc/rsyslog.conf"
-		# To cope with systemd-journal, we are looking for either:
-		#   $ModLoad imjournal
-		#   module(load="imjournal"...)
-		# in rsyslog config, and using those settings.
-		if grep -qri '^[^#]*modload.*imjournal' /etc/rsyslog.conf /etc/rsyslog.d/; then
-			RSYSLOG_CONFIG=$(grep -Ehoi "^[^#].*(imjournal|workdirectory).*" -r /etc/rsyslog.conf /etc/rsyslog.d/;
-				echo '$imjournalRatelimitInterval 0'; \
-				echo '$ImjournalIgnorePreviousMessages on';)
-		elif grep -qri '^[^#]*module.*load="imjournal"' /etc/rsyslog.conf /etc/rsyslog.d/; then
-			RSYSLOG_CONFIG=$(grep -Ehoi "^[^#].*workdirectory.*" -r /etc/rsyslog.conf /etc/rsyslog.d/; \
-				echo 'module(load="imjournal"'; \
-				echo '       StateFile="imjournal.state"'; \
-				echo '       Ratelimit.Interval="0"'; \
-				echo '       IgnorePreviousMessages="on")')
-		else
-			RSYSLOG_CONFIG=$(echo '$ModLoad imuxsock.so'; \
-				grep -ho "^\$SystemLogSocketName .*" -r /etc/rsyslog.conf /etc/rsyslog.d/ | head -1)
-		fi
-	else
-		tst_resm TCONF "Couldn't find syslogd, syslog-ng or rsyslogd"
-		cleanup 32
-	fi
-
-	# Back up configuration file
-	if [ -f "$CONFIG_FILE" ]; then
-		# Pause if another LTP syslog test is running
-		while [ -f "$CONFIG_FILE.ltpback" -a $WAIT_COUNT -gt 0 ]; do
-			: $(( WAIT_COUNT -= 1 ))
-			sleep 1
-		done
-		# Oops -- $CONFIG_FILE.ltpback is still there!
-		if [ $WAIT_COUNT -eq 0 ]; then
-			tst_resm TBROK "another syslog test is stuck"
-			cleanup 1
-		elif ! cp "$CONFIG_FILE" "$CONFIG_FILE.ltpback"; then
-			tst_resm TBROK "failed to backup $CONFIG_FILE"
-			cleanup 1
-		fi
-	else
-		tst_resm TBROK "$CONFIG_FILE not found!"
-	fi
-
-}
-
-disable_traps()
-{
-	trap - $TRAP_SIGS
-}
-
-# For most cases this isn't exotic. If you're running upstart however, you
-# might have fun here :).
-restart_syslog_daemon()
-{
-	# Default to running `cleanup 1' when dealing with error cases.
-	if [ $# -eq 0 ]; then
-		cleanup_command="cleanup 1"
-	else
-		cleanup_command=$1
-	fi
-
-	tst_resm TINFO "restarting syslog daemon"
-
-	if [ -n "$SYSLOG_DAEMON" ]; then
-		restart_daemon $SYSLOG_DAEMON
-		if [ $? -eq 0 ]; then
-			# XXX: this really shouldn't exist; if *syslogd isn't
-			# ready once the restart directive has been issued,
-			# then it needs to be fixed.
-			sleep 2
-		else
-			#
-			# Some distributions name the service syslog even if
-			# the package is syslog-ng or rsyslog, so try it once
-			# more with just syslog.
-			#
-			restart_daemon "syslog"
-
-			if [ $? -ne 0 ]; then
-				$cleanup_command
-			fi
-		fi
-	fi
-}
-
-export TST_TOTAL=${TST_TOTAL:=1}
-export TST_COUNT=1
-export TCID=${TCID:="$(basename "$0")"}
-. cmdlib.sh
diff --git a/testcases/kernel/syscalls/syslog/syslog01 b/testcases/kernel/syscalls/syslog/syslog01
deleted file mode 100755
index 2f3aea0bb6..0000000000
--- a/testcases/kernel/syscalls/syslog/syslog01
+++ /dev/null
@@ -1,108 +0,0 @@
-#! /bin/sh
-
-#  Copyright (c) International Business Machines  Corp., 2002
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-#  02/05/03  Modified - Manoj Iyer <manjo@mail.utexas.edu> use USCTEST macros
-#			fixed bugs.
-#  07/26/05  Michael Reed  <mreedltp@vnet.ibm.com>
-#			Made changes to account for the replacement of syslogd
-#			with syslog-ng
-#
-##################################################################
-# case1: Test whether messages are logged to the specified file  #
-# in the configuration file.					 #
-#								 #
-# Send messages to syslogd at some level and facility	 	 #
-# and grep for those messages.					 #
-#								 #
-# syslog.conf should contain:					 #
-# *.crit		/usr/adm/critical			 #
-# mail.info		/usr/spool/adm/syslog			 #
-##################################################################
-
-. syslog-lib.sh || exit 1
-
-syslog_case1()
-{
-	tst_resm TINFO "testing whether messages are logged into log file"
-
-	# Create the configuration file specific to this test case.
-
-	case "$CONFIG_FILE" in
-	/etc/syslog.conf|/etc/rsyslog.conf)
-		echo "$RSYSLOG_CONFIG" > $CONFIG_FILE
-		echo "*.crit		/var/log/messages" >> $CONFIG_FILE
-		echo "mail.info	$MAILLOG" >> $CONFIG_FILE
-		;;
-
-	/etc/syslog-ng/syslog-ng.conf)
-		echo "source src{ internal(); unix-dgram(\"/dev/log\"); \
-		      udp(ip(\"0.0.0.0\") port(514)); };" > $CONFIG_FILE
-		echo " " >> $CONFIG_FILE
-		echo " " >> $CONFIG_FILE
-		echo "# Added for syslog testcase"  >> $CONFIG_FILE
-		echo "filter f_syslog	 { level(crit);};" >> $CONFIG_FILE
-		echo "filter f_syslogMail { level(info)	and facility(mail); };" >> $CONFIG_FILE
-		echo "destination syslog-messages { file(\"/var/log/messages\");};" >> $CONFIG_FILE
-		echo "log { source(src); filter(f_syslog); destination(syslog-messages); };" >> $CONFIG_FILE
-		echo "destination syslog-mail { file(\"$MAILLOG\");};" >> $CONFIG_FILE
-		echo "log { source(src); filter(f_syslogMail); destination(syslog-mail); };"  >> $CONFIG_FILE
-		;;
-	esac
-
-	restart_syslog_daemon
-
-	# Grepping pattern has to be changed whenever the executable name
-	# changes, ex: syslogtst executable.
-	# This check is neccessary for syslog-ng because $MAILLOG is
-	# only created after syslogtst
-	if [ -e "$MAILLOG" ]; then
-		oldvalue1=`grep -c "syslogtst: mail info test" $MAILLOG`
-	else
-		oldvalue1=0
-	fi
-
-	# Call syslogtst executable with case number as argument
-	if syslogtst 1 2>/dev/null; then
-
-		sleep 2
-
-		if [ ! -e $MAILLOG ]; then
-			tst_resm TBROK "$MAILLOG no such log file"
-			cleanup 1
-		fi
-
-		newvalue1=`grep -c "syslogtst: mail info test" $MAILLOG`
-		if [ "x$(( $newvalue1 - $oldvalue1 ))" != "x1" ]; then
-			status_flag=1
-		fi
-	else
-		status_flag=1
-	fi
-
-}
-
-export TST_TOTAL=1
-export TST_COUNT=1
-export TCID=syslog01
-
-tst_resm TINFO "Send messages to syslogd at some level "
-tst_resm TINFO "and facility and grep for those messages."
-
-setup
-syslog_case1
-cleanup ${status_flag:=0}
diff --git a/testcases/kernel/syscalls/syslog/syslog02 b/testcases/kernel/syscalls/syslog/syslog02
deleted file mode 100755
index 2213ce3785..0000000000
--- a/testcases/kernel/syscalls/syslog/syslog02
+++ /dev/null
@@ -1,111 +0,0 @@
-#! /bin/sh
-
-#  Copyright (c) International Business Machines  Corp., 2002
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-
-# 12/05/02  Port to bash -Robbie Williamson <robbiew@us.ibm.com>
-# 02/05/03  Modified - Manoj Iyer <manjo@mail.utexas.edu> use USCTEST macros
-#		   fixed bugs.
-# 07/26/05  Michael Reed  <mreedltp@vnet.ibm.com>
-#		   Made changes to account for the replacement of syslogd
-#		   with syslog-ng
-#
-##################################################################
-# case2: Test if messages of all levels are logged.
-#	For each level, a separate configuration file is
-#	created and that will be used as syslog.conf file.
-##################################################################
-
-# Number of levels.
-export TST_TOTAL=8
-
-. syslog-lib.sh || exit 1
-
-syslog_case2()
-{
-	level_no=0
-	levels="emerg alert crit err warning notice info debug"
-	tst_resm TINFO "testing whether messages are logged into log file"
-
-	for level in $levels
-	do
-		tst_resm TINFO "Doing level: $level..."
-
-		case "$CONFIG_FILE" in
-		/etc/syslog.conf)
-			# Create the configuration file specific to this level
-			echo "mail.$level	$MAILLOG" >> $CONFIG_FILE
-			;;
-
-		/etc/rsyslog.conf)
-			# Create the configuration file specific to this level
-			echo "$RSYSLOG_CONFIG" > $CONFIG_FILE
-			echo "mail.$level	$MAILLOG" >> $CONFIG_FILE
-			;;
-
-		/etc/syslog-ng/syslog-ng.conf)
-			echo "source src{ internal(); unix-dgram(\"/dev/log\"); udp(ip(\"0.0.0.0\") port(514)); };" > $CONFIG_FILE
-			echo "filter f_syslog_$level { level($level) and facility(mail); };"  >> $CONFIG_FILE
-			echo "destination syslog-$level { file(\"$MAILLOG\"); };"  >> $CONFIG_FILE
-			echo "log { source(src); filter(f_syslog_$level); destination(syslog-$level); };"  >> $CONFIG_FILE;;
-		esac
-
-		restart_syslog_daemon
-
-		# Grepping pattern has to be changed whenever the executable name
-		# changes, ex: syslogtst executable.
-		# This check is neccessary for syslog-ng because $MAILLOG is
-		# only created after syslogtst
-		if [ -e "$MAILLOG" ]; then
-			oldvalue=`grep -c "syslogtst: mail $level test\." $MAILLOG`
-		else
-			oldvalue=0
-		fi
-
-		# syslogtst has to be called with additional level argument(0-7)
-		if ! syslogtst 2 $level_no 2>/dev/null; then
-			cleanup 1
-		fi
-		sleep 2
-
-		# check if $MAILLOG script exists
-		if [ ! -e "$MAILLOG" ]; then
-			tst_resm TBROK "$MAILLOG no such log file"
-			cleanup 1
-		fi
-
-		newvalue=`grep -c "syslogtst: mail $level test" $MAILLOG`
-		diff=$(( $newvalue - $oldvalue ))
-		if [ $diff -eq 0 ]; then
-			tst_resm TFAIL "***** Level $level failed *****"
-			status_flag=1
-		elif [ $diff -ge 1 ]; then
-			tst_resm TPASS "***** Level $level passed *****"
-		fi
-		# Increment the level_no for next level...
-		: $(( level_no += 1 ))
-
-		incr_tst_count
-	done
-}
-
-tst_resm TINFO "Test if messages of all levels are logged."
-tst_resm TINFO "For each level, a separate configuration file is"
-tst_resm TINFO "created and that will be used as syslog.conf file."
-
-setup
-syslog_case2
-cleanup ${status_flag:=0}
diff --git a/testcases/kernel/syscalls/syslog/syslog03 b/testcases/kernel/syscalls/syslog/syslog03
deleted file mode 100755
index 31b7fd66d2..0000000000
--- a/testcases/kernel/syscalls/syslog/syslog03
+++ /dev/null
@@ -1,87 +0,0 @@
-#! /bin/sh
-
-#  Copyright (c) International Business Machines  Corp., 2002
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-
-# 12/05/02  Port to bash -Robbie Williamson <robbiew@us.ibm.com>
-# 02/05/03  Modified - Manoj Iyer <manjo@mail.utexas.edu> use USCTEST macros
-#			fixed bugs.
-# 07/27/05  Michael Reed  <mreedltp@vnet.ibm.com>
-#		Made changes to account for the replacement of syslogd
-#		with syslog-ng on SLES
-#
-##################################################################
-# case 3: Do openlog(), log the messages and see whether			#
-# ident string is prepended to the message.			 #
-#								 #
-# syslog.conf should contain:					 #
-# *.crit		/usr/adm/critical			 #
-# daemon.info		/usr/spool/adm/syslog			 #
-##################################################################
-
-. syslog-lib.sh || exit 1
-
-syslog_case3()
-{
-	# Create the configuration file specific to this test case.
-	case "$CONFIG_FILE" in
-	/etc/syslog.conf|/etc/rsyslog.conf)
-		echo "$RSYSLOG_CONFIG" > $CONFIG_FILE
-		echo "daemon.info	/var/log/messages" >> $CONFIG_FILE
-		;;
-
-	/etc/syslog-ng/syslog-ng.conf)
-		echo "source src{ internal(); unix-dgram(\"/dev/log\"); udp(ip(\"0.0.0.0\") port(514)); };" > $CONFIG_FILE
-		echo " " >> $CONFIG_FILE
-		echo "# Added for syslog testcase"  >> $CONFIG_FILE
-		echo "filter f_syslog_daemon { level(info) and facility(daemon); }; " >> $CONFIG_FILE
-		echo "destination syslog-messages { file(\"/var/log/messages\");};" >> $CONFIG_FILE
-		echo "log { source(src); filter(f_syslog_daemon); destination(syslog-messages);};"  >> $CONFIG_FILE
-		;;
-	esac
-
-	restart_syslog_daemon
-
-	# Grep for the ident prefix: SYSLOG_CASE3 in the log file.
-	if [ -e /var/log/messages ]; then
-		oldvalue4=`grep -c "SYSLOG_CASE3" /var/log/messages`
-	else
-		oldvalue4=0
-	fi
-
-	if ! syslogtst 3 2>/dev/null; then
-		cleanup 1
-	fi
-	sleep 2
-
-	# check if /var/log/messages exists
-	if [ ! -e /var/log/messages ]; then
-		tst_resm TBROK "/var/log/messages no such log file"
-		cleanup 1
-	fi
-
-	newvalue4=`grep -c "SYSLOG_CASE3" /var/log/messages`
-	if [ "x$(( $newvalue4 - $oldvalue4 ))" != x1 ]; then
-		status_flag=1
-	fi
-}
-
-tst_resm TINFO "Do openlog(), log the messages and see whether"
-tst_resm TINFO "ident string is prepended to the message."
-
-setup
-syslog_case3
-cleanup ${status_flag:=0}
diff --git a/testcases/kernel/syscalls/syslog/syslog04 b/testcases/kernel/syscalls/syslog/syslog04
deleted file mode 100755
index d1739d32a4..0000000000
--- a/testcases/kernel/syscalls/syslog/syslog04
+++ /dev/null
@@ -1,84 +0,0 @@
-#! /bin/sh
-
-#  Copyright (c) International Business Machines  Corp., 2002
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-
-# 12/05/02  Port to bash -Robbie Williamson <robbiew@us.ibm.com>
-# 02/05/03  Modified - Manoj Iyer <manjo@mail.utexas.edu> use USCTEST macros
-#           fixed bugs.
-# 07/27/05  Michael Reed  <mreedltp@vnet.ibm.com>
-#            Made changes to account for the replacement of syslogd
-#            with syslog-ng
-#
-##################################################################
-# case4: Test the logging option: LOG_PID                        #
-#                                                                #
-#        Do openlog() with LOG_PID option and see whether pid    #
-#        is logged with message.                                 #
-##################################################################
-
-. syslog-lib.sh || exit 1
-
-syslog_case4()
-{
-	tst_resm TINFO "Testing the log option: LOG_PID..."
-
-	# Create the configuration file specific to this test case.
-	case "$CONFIG_FILE" in
-	/etc/syslog.conf|/etc/rsyslog.conf)
-		echo "$RSYSLOG_CONFIG" > $CONFIG_FILE
-		echo "user.info        /var/log/messages" >> $CONFIG_FILE
-		;;
-
-	/etc/syslog-ng/syslog-ng.conf)
-		echo "source src{ internal(); unix-dgram(\"/dev/log\"); udp(ip(\"0.0.0.0\") port(514)); };" > $CONFIG_FILE
-		echo " " >> $CONFIG_FILE
-		echo "filter f_syslog_user { level(info) and facility(user); };" >> $CONFIG_FILE
-		echo "destination syslog_messages { file(\"/var/log/messages\");};" >> $CONFIG_FILE
-		echo "log { source(src); filter(f_syslog_user); destination(syslog_messages);};"  >> $CONFIG_FILE
-		;;
-	esac
-
-	restart_syslog_daemon
-
-	# Run syslogtst in the background and get the process id.
-	syslogtst 4 2>/dev/null &
-	log_pid=$!
-	if ! wait $log_pid; then
-		cleanup 1
-	fi
-
-	sleep 2
-
-	# check if /var/log/messages script exists
-	if [ ! -e /var/log/messages ]; then
-		tst_resm TBROK "/var/log/messages no such log file"
-		cleanup 1
-	fi
-
-	found=`grep -c "\[$log_pid\]: syslogtst: user info test." /var/log/messages`
-	if [ $found -ne 1 ]; then
-		status_flag=1
-	fi
-}
-
-tst_resm TINFO "case4: Test the logging option: LOG_PID"
-tst_resm TINFO "Do openlog() with LOG_PID option and see whether pid"
-tst_resm TINFO "is logged with message."
-
-setup
-syslog_case4
-cleanup ${status_flag:=0}
diff --git a/testcases/kernel/syscalls/syslog/syslog05 b/testcases/kernel/syscalls/syslog/syslog05
deleted file mode 100755
index 40dd1fa1a2..0000000000
--- a/testcases/kernel/syscalls/syslog/syslog05
+++ /dev/null
@@ -1,96 +0,0 @@
-#! /bin/sh
-
-#  Copyright (c) International Business Machines  Corp., 2002
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-
-# 12/05/02  Port to bash -Robbie Williamson <robbiew@us.ibm.com>
-# 02/05/03  Modified - Manoj Iyer <manjo@mail.utexas.edu> use USCTEST macros
-#	  fixed bugs.
-# 07/27/05  Michael Reed  <mreedltp@vnet.ibm.com>
-#	   Made changes to account for the replacement of syslogd
-#	   with syslog-ng
-#
-##################################################################
-# case5: Test the logging option: LOG_CONS			 #
-#	o Do openlog() with LOG_CONS option.		  	 #
-#	o Disable /dev/syslog by moving it to a temporary file	 #
-#	  name.							 #
-#	o Send the syslog message.				 #
-#	o Check whether this is written to the console i.e to	 #
-#	  the file /usr/adm/ktlog/<this year>/<this month>/	 #
-#	  <to_day>						 #
-##################################################################
-
-. syslog-lib.sh || exit 1
-
-syslog_case5()
-{
-	tst_resm TINFO "syslog: Testing the log option: LOG_CONS..."
-
-	# Create the configuration file specific to this test case.
-
-	case "$CONFIG_FILE" in
-	/etc/syslog.conf|/etc/rsyslog.conf)
-		echo "$RSYSLOG_CONFIG" > $CONFIG_FILE
-		echo "user.info	/var/log/messages" >> $CONFIG_FILE
-		;;
-
-	/etc/syslog-ng/syslog-ng.conf)
-		echo "source src{ internal(); unix-dgram(\"/dev/log\"); udp(ip(\"0.0.0.0\") port(514)); };" > $CONFIG_FILE
-		echo "filter f_syslog_user { level(info)      and facility(user); };" >> $CONFIG_FILE
-		echo "destination syslog-messages { file(\"/var/log/messages\");};" >> $CONFIG_FILE
-		echo "log { source(src); filter(f_syslog_user); destination(syslog-messages);};" >> $CONFIG_FILE
-		;;
-	esac
-
-	restart_syslog_daemon
-
-	# check if /var/log/messages script exists
-	if [ -e /var/log/messages ]; then
-		oldvalue=`grep -c "syslogtst: info to console test." /var/log/messages`
-	else
-		oldvalue=0
-	fi
-
-	# syslogtst does the disabling of /dev/syslog, sends the message and
-	# enables /dev/syslog.
-	if ! syslogtst 5 2>/dev/null; then
-		cleanup 1
-	fi
-	sleep 2
-
-	# check if /var/log/messages script exists
-	if [ ! -e /var/log/messages ]; then
-		tst_resm TBROK "/var/log/messages no such log file"
-		cleanup 1
-	fi
-	newvalue=`grep -c "syslogtst: info to console test." /var/log/messages`
-
-	if [ "x$(( $newvalue - $oldvalue ))" != "x1" ]; then
-		status_flag=1
-	fi
-}
-
-tst_resm TINFO " case5: Test the logging option: LOG_CONS"
-tst_resm TINFO " o Do openlog() with LOG_CONS option."
-tst_resm TINFO " o Disable /dev/syslog by moving it to a temporary file name."
-tst_resm TINFO " o Send the syslog message."
-tst_resm TINFO " o Check whether this is written to the console i.e to"
-tst_resm TINFO "   the file /usr/adm/ktlog/<this year>/<this month>/<to_day>"
-
-setup
-syslog_case5
-cleanup ${status_flag:=0}
diff --git a/testcases/kernel/syscalls/syslog/syslog06 b/testcases/kernel/syscalls/syslog/syslog06
deleted file mode 100755
index 7050fd2645..0000000000
--- a/testcases/kernel/syscalls/syslog/syslog06
+++ /dev/null
@@ -1,76 +0,0 @@
-#! /bin/sh
-
-#  Copyright (c) International Business Machines  Corp., 2002
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-
-# 12/05/02  Port to bash -Robbie Williamson <robbiew@us.ibm.com>
-# 02/05/03  Modified - Manoj Iyer <manjo@mail.utexas.edu> use USCTEST macros
-#           fixed bugs.
-# 07/27/05  Michael Reed  <mreedltp@vnet.ibm.com>
-#           Made changes to account for the replacement of syslogd
-#           with syslog-ng on SLES
-#
-##################################################################
-# case 6: Test the logging option: LOG_NDELAY                    #
-#                                                                #
-#         o Do openlog() without LOG_NDELAY option.              #
-#         o open a file and check the returned file descriptor   #
-#           It should be 3.                                      #
-#         o Now do openlog() with LOG_NDELAY option.             #
-#         o open a file and check the returned file descriptor.  #
-#           It should be greater than 3.                         #
-##################################################################
-
-. syslog-lib.sh || exit 1
-
-syslog_case6()
-{
-	tst_resm TINFO "syslog: Testing the log option: LOG_NDELAY..."
-
-	# Create the configuration file specific to this test case.
-	# For this case, it's a dummy one. No use of it.
-	case "$CONFIG_FILE" in
-	/etc/syslog.conf|/etc/rsyslog.conf)
-		echo "$RSYSLOG_CONFIG" > $CONFIG_FILE
-		echo "user.info        /var/log/messages" >> $CONFIG_FILE
-		;;
-
-	/etc/syslog-ng/syslog-ng.conf)
-		echo "source src{ internal(); unix-dgram(\"/dev/log\"); udp(ip(\"0.0.0.0\") port(514)); };" > $CONFIG_FILE
-		echo "filter f_syslog_user { level(info) and facility(user); };">> $CONFIG_FILE
-		echo "destination syslog-messages { file(\"/var/log/messages\");};" >> $CONFIG_FILE
-		echo "log { source(src); filter(f_syslog_user); destination(syslog-messages);};" >> $CONFIG_FILE
-		;;
-	esac
-
-	restart_syslog_daemon
-
-	if ! syslogtst 6 2>/dev/null; then
-		status_flag=1
-	fi
-}
-
-tst_resm TINFO " Test the logging option: LOG_NDELAY"
-tst_resm TINFO " o Do openlog() without LOG_NDELAY option."
-tst_resm TINFO " o open a file and check the returned file descriptor"
-tst_resm TINFO "   It should be 3."
-tst_resm TINFO " o Now do openlog() with LOG_NDELAY option."
-tst_resm TINFO " o open a file and check the returned file descriptor."
-tst_resm TINFO "   It should be greater than 3."
-
-setup
-syslog_case6
-cleanup ${status_flag:=0}
diff --git a/testcases/kernel/syscalls/syslog/syslog07 b/testcases/kernel/syscalls/syslog/syslog07
deleted file mode 100755
index a24c3e2077..0000000000
--- a/testcases/kernel/syscalls/syslog/syslog07
+++ /dev/null
@@ -1,128 +0,0 @@
-#! /bin/sh
-
-#  Copyright (c) International Business Machines  Corp., 2002
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-
-# 12/05/02  Port to bash -Robbie Williamson <robbiew@us.ibm.com>
-# 02/05/03  Modified - Manoj Iyer <manjo@mail.utexas.edu> use USCTEST macros
-#           fixed bugs.
-# 07/26/05  Michael Reed  <mreedltp@vnet.ibm.com>
-#           Made changes to account for the replacement of syslogd
-#           with syslog-ng
-#
-##################################################################
-# case 7: Test the priorities....                                #
-#                                                                #
-#         o Add lowest prority level i.e debug level entry to    #
-#           configuration file.                                  #
-#           o For syslog-ng the priority is set to all           #
-#             because of the format of syslog-ng.conf            #
-#             The format of the tests is the same, all levels of #
-#             debug and above are logged                         #
-#         o Send syslog messages at all levels and see whether   #
-#           higher level messages are logged.                    #
-##################################################################
-
-. syslog-lib.sh || exit 1
-
-syslog_case7()
-{
-	tst_resm TINFO "testing syslog priorities ..."
-
-	# Adds some clarification of log message when syslog-ng is used
-	if [ $CONFIG_FILE = /etc/syslog.conf ]; then
-		explanation="Higher"
-	else
-		explanation="All"
-	fi
-
-	tst_resm TINFO " o Send syslog messages at all levels and see whether"
-	tst_resm TINFO "   $explanation level messages are logged."
-
-	# Create the configuration file specific to this test case.
-	case "$CONFIG_FILE" in
-	/etc/syslog.conf|/etc/rsyslog.conf)
-	        echo "$RSYSLOG_CONFIG" > $CONFIG_FILE
-	        echo "user.debug /var/log/messages" >> $CONFIG_FILE
-		;;
-
-	/etc/syslog-ng/syslog-ng.conf)
-		echo "source src{ internal(); unix-dgram(\"/dev/log\"); udp(ip(\"0.0.0.0\") port(514)); };" > $CONFIG_FILE
-		echo " " >> $CONFIG_FILE
-		echo " " >> $CONFIG_FILE
-		echo "# Added for syslog testcase" >> $CONFIG_FILE
-		echo "filter f_syslog_messages {facility(user); };" >> $CONFIG_FILE
-		echo "destination syslog-messages { file(\"/var/log/messages\");};" >> $CONFIG_FILE
-		echo "log { source(src); filter(f_syslog_messages); destination(syslog-messages); };" >> $CONFIG_FILE
-		;;
-	esac
-
-	restart_syslog_daemon
-
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
-
-	# Call syslogtst. It will send the messages of all levels.
-	if ! syslogtst 7 2>/dev/null; then
-		cleanup 1
-	fi
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
-
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
-}
-
-setup
-syslog_case7
-cleanup ${status_flag:=0}
diff --git a/testcases/kernel/syscalls/syslog/syslog08 b/testcases/kernel/syscalls/syslog/syslog08
deleted file mode 100755
index 5388620fa3..0000000000
--- a/testcases/kernel/syscalls/syslog/syslog08
+++ /dev/null
@@ -1,132 +0,0 @@
-#! /bin/sh
-
-#  Copyright (c) International Business Machines  Corp., 2002
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-
-# 12/05/02  Port to bash -Robbie Williamson <robbiew@us.ibm.com>
-# 02/05/03  Modified - Manoj Iyer <manjo@mail.utexas.edu> use USCTEST macros
-#		   fixed bugs.
-# 07/26/05  Michael Reed  <mreedltp@vnet.ibm.com>
-#		   Made changes to account for the replacement of syslogd
-#		   with syslog-ng
-#
-##################################################################
-# case 8: Test all the facilities at a particular level.	 #
-#								 #
-# Facilities available are: LOG_KERN, LOG_USER, LOG_MAIL	 #
-# LOG_DAEMON, LOG_AUTH, LOG_LPR.				 #
-# Don't know how to send kernel messages from syslog()   	 #
-#								 #
-# o Create seperate entries in config file for each facility.	 #
-# o Send the message and grep for the entry in log file.	 #
-##################################################################
-
-. syslog-lib.sh || exit 1
-
-syslog_case8()
-{
-	local facility_no=1
-	local facilities="user mail daemon auth lpr"
-
-	tst_resm TINFO "testing all the facilities"
-
-	for facility in $facilities; do
-
-		tst_resm TINFO "Doing facility: $facility..."
-
-		# Create the configuration file specific to this facility
-		# Level is fixed at info.
-		case "$CONFIG_FILE" in
-		/etc/syslog.conf|/etc/rsyslog.conf)
-			echo "$RSYSLOG_CONFIG" > $CONFIG_FILE
-			echo "$facility.info	/var/log/messages" >> $CONFIG_FILE
-			echo "$facility.info	/var/log/maillog" >> $CONFIG_FILE
-			;;
-
-		/etc/syslog-ng/syslog-ng.conf)
-			echo "source src{ internal(); unix-dgram(\"/dev/log\"); udp(ip(\"0.0.0.0\") port(514)); };" > $CONFIG_FILE
-			echo "filter f_syslog-$facility { level(info) and facility($facility); };" >> $CONFIG_FILE
-			echo "destination syslog-messages { file(\"/var/log/messages\"); };" >> $CONFIG_FILE
-			echo "destination syslog-mail { file(\"/var/log/maillog\");};" >> $CONFIG_FILE
-			echo "log { source(src); filter(f_syslog-$facility); destination(syslog-mail); };"  >> $CONFIG_FILE
-			echo "log { source(src); filter(f_syslog-$facility); destination(syslog-messages); };"  >> $CONFIG_FILE
-			;;
-
-		esac
-
-		restart_syslog_daemon
-
-		if [ -e /var/log/messages ]; then
-			oldvalue=`grep -c "syslogtst: $facility info test." /var/log/messages`
-		else
-			oldvalue=0
-		fi
-
-		if [ -e /var/log/maillog ]; then
-			old_mail_check=`grep -c "syslogtst: $facility info test." /var/log/maillog`
-		else
-			old_mail_check=0
-		fi
-
-		# syslogtst has to be called with one more
-				# additional facility argument(1-6)
-		if ! syslogtst 8 $facility_no 2>/dev/null; then
-			status_flag=1
-			return
-		fi
-		sleep 2
-		# check if /var/log/maillog script exists
-		for logf in messages maillog
-		do
-			if [ ! -e /var/log/$logf ]; then
-				tst_resm TBROK "/var/log/$logf no such log file"
-				cleanup 1
-			fi
-		done
-
-		new_mail_check=`grep -c "syslogtst: $facility info test." /var/log/maillog`
-		newvalue=`grep -c "syslogtst: $facility info test." /var/log/messages`
-		diff=$(( $newvalue - $oldvalue ))
-		mail_check=$(( $new_mail_check - $old_mail_check ))
-
-		if [ $facility = "mail" ]; then
-			if [ $mail_check -ne 1 ]; then
-				tst_resm TFAIL " Facility $facility failed"
-				status_flag=1
-			elif [ $mail_check -eq 1 ]; then
-				tst_resm TPASS " Facility $facility passed"
-			fi
-		elif [ $diff -ne 1 ]; then
-			tst_resm TFAIL " Facility $facility failed"
-			status_flag=1
-		else
-			tst_resm TPASS " Facility $facility passed"
-		fi
-		# Increment the facility_no for next...
-		: $(( facility_no += 1 ))
-	done
-}
-
-tst_resm TINFO " Test all the facilities at a particular level."
-tst_resm TINFO " Facilities available are: LOG_KERN, LOG_USER, LOG_MAIL"
-tst_resm TINFO " LOG_DAEMON, LOG_AUTH, LOG_LPR."
-tst_resm TINFO " Don't know how to send kernel messages from syslog()"
-tst_resm TINFO " o Create seperate entries in config file for each facility."
-tst_resm TINFO " o Send the message and grep for the entry in log file."
-
-setup
-syslog_case8
-cleanup ${status_flag:=0}
diff --git a/testcases/kernel/syscalls/syslog/syslog09 b/testcases/kernel/syscalls/syslog/syslog09
deleted file mode 100755
index 9cfafa840a..0000000000
--- a/testcases/kernel/syscalls/syslog/syslog09
+++ /dev/null
@@ -1,103 +0,0 @@
-#! /bin/sh
-
-#  Copyright (c) International Business Machines  Corp., 2002
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-
-# 12/05/02  Port to bash -Robbie Williamson <robbiew@us.ibm.com>
-# 02/05/03  Modified - Manoj Iyer <manjo@mail.utexas.edu> use USCTEST macros
-#	   fixed bugs.
-# 07/27/05  Michael Reed  <mreedltp@vnet.ibm.com>
-#	   Made changes to account for the replacement of syslogd
-#	   with syslog-ng
-#
-##################################################################
-# case 9: Test setlogmask() with LOG_UPTO macro.		 #
-#								#
-#	 o Use setlogmask() with LOG_UPTO macro to set some     #
-#	    priority level.				     #
-#	 o Send message which is lower priority than the one    #
-#	   set above, which should not be logged.	       #
-##################################################################
-
-. syslog-lib.sh || exit 1
-
-syslog_case9()
-{
-	tst_resm TINFO "syslog: Testing setlogmask() with LOG_UPTO macro"
-
-	# Create the configuration file specific to this test case.
-	case "$CONFIG_FILE" in
-	/etc/syslog.conf|/etc/rsyslog.conf)
-		echo "$RSYSLOG_CONFIG" > $CONFIG_FILE
-		echo "user.debug       /var/log/messages" >> $CONFIG_FILE
-		;;
-
-	/etc/syslog-ng/syslog-ng.conf)
-		echo "source src{ internal(); unix-dgram(\"/dev/log\"); udp(ip(\"0.0.0.0\") port(514)); };" > $CONFIG_FILE
-		#echo "filter f_syslog_debug { level(debug) and facility(user); };" >> $CONFIG_FILE
-		echo "filter f_syslog_debug { facility(user); };" >> $CONFIG_FILE
-		echo "destination syslog-messages { file(\"/var/log/messages\");};" >> $CONFIG_FILE
-		echo "log { source(src); filter(f_syslog_debug); destination(syslog-messages);};" >> $CONFIG_FILE
-		;;
-	esac
-
-	restart_syslog_daemon
-
-	if [ -e /var/log/messages ]; then
-		allow1=`grep -c "syslogtst: error level is logged" /var/log/messages`
-		donot_allow1=`grep -c "syslogtst: warning level not to be logged" /var/log/messages`
-	else
-		allow1=0
-		donot_allow1=0
-	fi
-
-	if ! syslogtst 9 2>/dev/null; then
-		cleanup 1
-	fi
-	sleep 2
-
-	# check if /var/log/messages script exists
-	if [ ! -e /var/log/messages ]; then
-		tst_resm TBROK "/var/log/messages no such log file"
-		cleanup 1
-	fi
-
-	allow2=`grep -c "syslogtst: error level is logged" /var/log/messages`
-	donot_allow2=`grep -c "syslogtst: warning level not to be logged" /var/log/messages`
-
-	diff1=$(( $allow2 - $allow1 ))
-	if [ $diff1 -ne 1 ]; then
-		tst_resm TFAIL "Expected message was not logged...."
-		status_flag=1
-		return
-	fi
-
-	diff2=$(( $donot_allow2 - $donot_allow1 ))
-	if [ $diff2 -ne 0 ]; then
-		tst_resm TFAIL "Unexpected message was logged..."
-		status_flag=1
-	fi
-}
-
-tst_resm TINFO " Test setlogmask() with LOG_UPTO macro."
-tst_resm TINFO " o Use setlogmask() with LOG_UPTO macro to set some priority"
-tst_resm TINFO "   level."
-tst_resm TINFO " o Send message which is lower priority than the one"
-tst_resm TINFO "   set above, which should not be logged"
-
-setup
-syslog_case9
-cleanup ${status_flag:=0}
diff --git a/testcases/kernel/syscalls/syslog/syslog10 b/testcases/kernel/syscalls/syslog/syslog10
deleted file mode 100755
index 573ab755e8..0000000000
--- a/testcases/kernel/syscalls/syslog/syslog10
+++ /dev/null
@@ -1,108 +0,0 @@
-#!/bin/sh
-#  Copyright (c) International Business Machines  Corp., 2002
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-# 12/05/02  Port to bash -Robbie Williamson <robbiew@us.ibm.com>
-# 02/05/03  Modified - Manoj Iyer <manjo@mail.utexas.edu> use USCTEST macros
-#	   fixed bugs.
-# 07/26/05  Michael Reed  <mreedltp@vnet.ibm.com>
-#	   Made changes to account for the replacement of syslogd
-#	   with syslog-ng
-#
-##################################################################
-# case 10: Test setlogmask() with LOG_MASK macro.		#
-#								#
-#	 o Use setlogmask() with LOG_MASK macro to set an       #
-#		individual priority level.			  #
-#	 o Send the message of above prority and expect it to   #
-#	   be logged.					   #
-#	 o Send message which is below the priority level to    #
-#	   the one set above, which should not be logged.       #
-##################################################################
-
-. syslog-lib.sh || exit 1
-
-syslog_case10()
-{
-	tst_resm TINFO "syslog: Testing setlogmask() with LOG_MASK macro..."
-
-	# Create the configuration file specific to this test case.
-	case "$CONFIG_FILE" in
-	/etc/syslog.conf|/etc/rsyslog.conf)
-		echo "$RSYSLOG_CONFIG" > $CONFIG_FILE
-		echo "user.debug       /var/log/messages" >> $CONFIG_FILE
-		;;
-
-	/etc/syslog-ng/syslog-ng.conf)
-		echo "source src{ internal(); unix-dgram(\"/dev/log\"); udp(ip(\"0.0.0.0\") port(514)); };" > $CONFIG_FILE
-		echo "filter f_syslog_debug{ facility(user); };" >> $CONFIG_FILE
-		echo "destination syslog_messages { file(\"/var/log/messages\");};" >> $CONFIG_FILE
-		echo "log { source(src); filter(f_syslog_debug); destination(syslog_messages); };" >> $CONFIG_FILE
-		;;
-
-	esac
-
-	restart_syslog_daemon
-
-	if [ -e /var/log/messages ]; then
-		allow1=`grep -c "syslogtst:10 error level is logged" /var/log/messages`
-		donot_allow1=`grep -c "syslogtst:10 warning level not to be logged" /var/log/messages`
-	else
-		allow1=0
-		donot_allow1=0
-	fi
-
-	if ! syslogtst 10 2>/dev/null; then
-		status_flag=1
-		return
-	fi
-	sleep 2
-
-	# check if /var/log/messages script exists
-	if [ ! -e /var/log/messages ]; then
-		tst_resm TBROK "/var/log/messages no such log file"
-		cleanup 1
-	fi
-
-	allow2=`grep -c "syslogtst:10 error level is logged" /var/log/messages`
-	donot_allow2=`grep -c "syslogtst:10 warning level not to be logged" /var/log/messages`
-
-	diff1=$(( $allow2 - $allow1 ))
-	if [ $diff1 -ne 1 ]; then
-		tst_resm TFAIL "Expected message was not logged...."
-		status_flag=1
-		return
-	fi
-
-	diff2=$(( $donot_allow2 - $donot_allow1 ))
-	if [ $diff2 -ne 0 ]; then
-		tst_resm TFAIL "Unexpected message was logged..."
-		status_flag=1
-	fi
-
-}
-
-tst_resm TINFO " Test setlogmask() with LOG_MASK macro."
-tst_resm TINFO " o Use setlogmask() with LOG_MASK macro to set an"
-tst_resm TINFO "   individual priority level."
-tst_resm TINFO " o Send the message of above prority and expect it to be"
-tst_resm TINFO "   logged."
-tst_resm TINFO " o Send message which is at other priority level to"
-tst_resm TINFO "   the one set above, which should not be logged."
-
-setup
-syslog_case10
-cleanup ${status_flag:=0}
diff --git a/testcases/kernel/syscalls/syslog/syslogtst.c b/testcases/kernel/syscalls/syslog/syslogtst.c
deleted file mode 100644
index 6950419cec..0000000000
--- a/testcases/kernel/syscalls/syslog/syslogtst.c
+++ /dev/null
@@ -1,341 +0,0 @@
-/*
- *
- *   Copyright (c) International Business Machines  Corp., 2002
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-/* 06/30/2001	Port to Linux	nsharoff@us.ibm.com */
-/* 11/22/2002	Port to Linux	dbarrera@us.ibm.com */
-
-#include <sys/types.h>
-#include <assert.h>
-#include <fcntl.h>
-#include <signal.h>
-#include <stdio.h>
-#include <syslog.h>
-#include <time.h>
-#include <unistd.h>
-#include "test.h"
-
-char *TCID = "syslogtst";
-int TST_TOTAL = 1;
-
-void sig_handler(int signal);
-
-int main(int argc, char *argv[])
-{
-	int status, flag3, fd, ch, ch1;
-	int exit_flag = 0;	/* used for syslog test case 6. */
-	time_t t;
-
-	ch1 = -1;
-
-	signal(SIGINT, sig_handler);
-	signal(SIGTERM, sig_handler);
-	signal(SIGHUP, sig_handler);
-	signal(SIGABRT, sig_handler);
-	signal(SIGSEGV, sig_handler);
-	signal(SIGQUIT, sig_handler);
-
-	time(&t);
-	srandom((unsigned int)getpid() ^
-		(((unsigned int)t << 16) | (unsigned int)t >> 16));
-
-	if (argc < 2) {
-		ch = (random() % 10) + 1;
-		if (ch == 2)
-			ch1 = random() % 8;
-		if (ch == 8)
-			ch1 = (random() % 5) + 1;
-		tst_resm(TINFO,
-			 "\nrandom numbers were generated for the case numbers : %d, %d\n",
-			 ch, ch1);
-	}
-
-	else if (argc == 2) {
-		ch = atoi(argv[1]);
-		if (ch == 2 || ch == 8) {
-			if (ch == 2)
-				ch1 = random() % 8;
-			if (ch == 8)
-				ch1 = (random() % 5) + 1;
-			tst_resm(TINFO,
-				 "\nrandom number was generated for case %d : %d\n",
-				 ch, ch1);
-		}
-	}
-
-	else {
-		ch = atoi(argv[1]);
-		if (argc > 2)
-			ch1 = atoi(argv[2]);
-	}
-
-	/* Ensure ch1 is properly allocated when ch == 2 or ch == 8. */
-	assert(!((ch == 2 || ch == 8) && ch1 == -1));
-
-	/*
-	 * Send syslog messages according to the case number, which
-	 * we will know from command line.
-	 */
-	switch (ch) {
-	case 1:
-		syslog(LOG_MAIL | LOG_INFO, "syslogtst: mail info test.");
-		break;
-	case 2:
-		switch (ch1) {
-		case 0:
-			syslog(LOG_MAIL | LOG_EMERG,
-			       "syslogtst: mail emerg test.");
-			break;
-		case 1:
-			syslog(LOG_MAIL | LOG_ALERT,
-			       "syslogtst: mail alert test.");
-			break;
-		case 2:
-			syslog(LOG_MAIL | LOG_CRIT,
-			       "syslogtst: mail crit test.");
-			break;
-		case 3:
-			syslog(LOG_MAIL | LOG_ERR, "syslogtst: mail err test.");
-			break;
-		case 4:
-			syslog(LOG_MAIL | LOG_WARNING,
-			       "syslogtst: mail warning test.");
-			break;
-		case 5:
-			syslog(LOG_MAIL | LOG_NOTICE,
-			       "syslogtst: mail notice test.");
-			break;
-		case 6:
-			syslog(LOG_MAIL | LOG_INFO,
-			       "syslogtst: mail info test.");
-			break;
-		case 7:
-			syslog(LOG_MAIL | LOG_DEBUG,
-			       "syslogtst: mail debug test.");
-			break;
-
-		}
-		break;
-	case 3:
-		openlog("SYSLOG_CASE3", LOG_PID, LOG_DAEMON);
-		syslog(LOG_DAEMON | LOG_INFO, "syslogtst: daemon info test.");
-		closelog();
-		break;
-	case 4:
-		openlog("log_pid_test", LOG_PID, LOG_USER);
-		syslog(LOG_USER | LOG_INFO, "syslogtst: user info test.");
-		closelog();
-		break;
-	case 5:
-		openlog("log_cons_test", LOG_CONS, LOG_USER);
-
-		/*
-		 * Move the /dev/syslog to /dev/syslog.tmp
-		 * This way we are forcing syslog to write messages to
-		 * console.
-		 */
-#ifdef DEBUG2
-		status =
-		    system
-		    ("/bin/mv -f /var/log/messages /var/log/messages.tmp");
-#else
-		status = 0;
-#endif
-		if (status == 0) {
-#ifdef DEBUG
-			tst_resm(TINFO,
-				 "/var/log/messages is moved to /var/log/messages.tmp...");
-#endif
-			flag3 = 1;
-		} else {
-			tst_brkm(TFAIL,
-				 NULL,
-				 "Cannot move /var/log/messages. Setup failed...exiting...");
-		}
-		sleep(10);
-
-		syslog(LOG_USER | LOG_INFO, "syslogtst: info to console test.");
-
-		sleep(10);
-		/*
-		 * Restore /dev/syslog file.
-		 */
-		if (flag3 == 1) {
-#ifdef DEBUG2
-			status =
-			    system
-			    ("/bin/mv -f /var/log/messages.tmp /var/log/messages");
-#else
-			status = 0;
-#endif
-			if (status != 0) {
-				tst_brkm(TFAIL,
-					 NULL,
-				         "Restoring /var/log/messages failed...");
-			}
-#ifdef DEBUG
-			else
-				tst_resm(TINFO, "/var/log/messages restored..");
-#endif
-		}
-		closelog();
-		break;
-	case 6:
-		openlog("without log_ndelay", LOG_PID, LOG_USER);
-		fd = open("/dev/null", O_RDONLY);
-#ifdef DEBUG
-		tst_resm(TINFO, "openlog() without LOG_NDELAY option...");
-#endif
-		if (fd >= 3) {
-#ifdef DEBUG
-			tst_resm(TINFO,
-				 "open() has returned the expected fd: %d", fd);
-#endif
-		} else {
-			tst_resm(TFAIL, "open() has returned unexpected fd: %d",
-				 fd);
-			exit_flag = 1;
-			close(fd);
-			closelog();
-			break;
-		}
-		close(fd);
-		closelog();
-
-		openlog("with log_ndelay", LOG_NDELAY, LOG_USER);
-		fd = open("/dev/null", O_RDONLY);
-#ifdef DEBUG
-		tst_resm(TINFO, "openlog() with LOG_NDELAY option...");
-#endif
-		if (fd <= 3) {
-			tst_resm(TFAIL, "open() returned unexpected fd: %d",
-				 fd);
-			exit_flag = 1;
-			close(fd);
-			closelog();
-			break;
-		}
-#ifdef DEBUG
-		else
-			tst_resm(TINFO, "open() has returned expected fd: %d",
-				 fd);
-#endif
-		close(fd);
-		closelog();
-		break;
-	case 7:
-		syslog(LOG_USER | LOG_EMERG, "syslogtst: emergency log");
-		syslog(LOG_USER | LOG_ALERT, "syslogtst: alert log");
-		syslog(LOG_USER | LOG_CRIT, "syslogtst: critical log");
-		syslog(LOG_USER | LOG_ERR, "syslogtst: error log");
-		syslog(LOG_USER | LOG_WARNING, "syslogtst: warning log");
-		syslog(LOG_USER | LOG_NOTICE, "syslogtst: notice log");
-		syslog(LOG_USER | LOG_INFO, "syslogtst: info log");
-		syslog(LOG_USER | LOG_DEBUG, "syslogtst: debug log");
-		break;
-	case 8:
-		switch (ch1) {
-			/*
-			 * Kernel messages cannot be send by user, so skipping the
-			 * LOG_KERN facility.
-			 */
-		case 1:
-			syslog(LOG_USER | LOG_INFO,
-			       "syslogtst: user info test.");
-			break;
-		case 2:
-			syslog(LOG_MAIL | LOG_INFO,
-			       "syslogtst: mail info test.");
-			break;
-		case 3:
-			syslog(LOG_DAEMON | LOG_INFO,
-			       "syslogtst: daemon info test.");
-			break;
-		case 4:
-			syslog(LOG_AUTH | LOG_INFO,
-			       "syslogtst: auth info test.");
-			break;
-		case 5:
-			syslog(LOG_LPR | LOG_INFO, "syslogtst: lpr info test.");
-			break;
-		}
-		break;
-	case 9:
-		setlogmask(LOG_UPTO(LOG_ERR));
-		syslog(LOG_USER | LOG_ERR, "syslogtst: error level is logged");
-		syslog(LOG_USER | LOG_WARNING,
-		       "syslogtst: warning level not to be logged");
-		break;
-	case 10:
-		setlogmask(LOG_MASK(LOG_ERR));
-		syslog(LOG_USER | LOG_ERR,
-		       "syslogtst:10 error level is logged");
-		syslog(LOG_USER | LOG_WARNING,
-		       "syslogtst:10 warning level not to be logged");
-		break;
-	}
-
-	/*
-	 * Check the exit_flag and if it is set,
-	 * exit with status 1, indicating failure.
-	 */
-	if (exit_flag == 1)
-		exit(1);
-	else
-		exit(0);
-
-}
-
-void sig_handler(int signal)
-{
-
-	switch (signal) {
-	case SIGINT:
-#ifdef DEBUG
-		tst_resm(TINFO, "SIGINT is received.");
-#endif
-		break;
-	case SIGTERM:
-#ifdef DEBUG
-		tst_resm(TINFO, "SIGTERM is received.");
-#endif
-		break;
-	case SIGHUP:
-#ifdef DEBUG
-		tst_resm(TINFO, "SIGHUP is received.");
-#endif
-		break;
-	case SIGABRT:
-#ifdef DEBUG
-		tst_resm(TINFO, "SIGABRT is received.");
-#endif
-		break;
-	case SIGSEGV:
-#ifdef DEBUG
-		tst_resm(TINFO, "SIGSEGV is received.");
-#endif
-		break;
-	case SIGQUIT:
-#ifdef DEBUG
-		tst_resm(TINFO, "SIGQUIT is received.");
-#endif
-		break;
-	}
-
-	exit(signal);
-}
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
