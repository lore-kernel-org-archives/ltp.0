From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 22 Nov 2018 19:39:43 +0800
Subject: [LTP] [PATCH] commands/logrotate_tests.sh: Fix two issues
Message-ID: <1542886783-30763-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) Pass correct arguments when calling tst_res command in logrotate_tests.sh
2) If syslog group doesn't exist on system, su option with it triggers a
   an 'unknow group' error in config file and then skips the config file.
   e.g.  Running logrotate_sh gets either of the following errors, because
   logrotate command with above error returns non-zero exit status since
   commit e547b94 in logrotate:
   ---------------------------------------------------------
   logrotate01    1  TFAIL  :  ltpapicmd.c:154: Test #1: logrotate command failed. Reason:
   ...
   logrotate01    1  TFAIL  :  ltpapicmd.c:154: Test #1: logrotate command exited with 1 return code. Output:
   ---------------------------------------------------------
   We just use syslog group if it actually exists.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/commands/logrotate/logrotate_tests.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/testcases/commands/logrotate/logrotate_tests.sh b/testcases/commands/logrotate/logrotate_tests.sh
index ce12c7f..c9ffc41 100755
--- a/testcases/commands/logrotate/logrotate_tests.sh
+++ b/testcases/commands/logrotate/logrotate_tests.sh
@@ -154,6 +154,10 @@ test01()
 	tst_resm TINFO "Test #1: 1. rotate /var/log/tst_logfile file."
 	tst_resm TINFO "Test #1: 2. compresses it."
 
+	# Check if syslog group exists
+	local set_group="root"
+	grep -q syslog /etc/group && set_group="syslog"
+
 	# create config file.
 	cat >$LTPTMP/tst_logrotate.conf <<-EOF
 	#****** Begin Config file *******
@@ -164,7 +168,7 @@ test01()
 	compress
 
 	/var/log/tst_logfile {
-		su root syslog
+		su root ${set_group}
 		rotate 5
 		weekly
 	}
@@ -208,7 +212,7 @@ test01()
 			$LTPTMP/tst_logrotate.out   > $LTPTMP/tst_logrotate.err 2>&1 || RC=$?
 		if [ $RC -ne 0 ]
 		then
-			tst_res TFAIL > $LTPTMP/tst_logrotate.err 2>&1 \
+			tst_res TFAIL $LTPTMP/tst_logrotate.err \
 				"Test #1: logrotate command failed. Reason:"
 		else
 			# Check if compressed log file is created.
-- 
1.8.3.1



