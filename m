From: Jia Zhang <zhang.jia@linux.alibaba.com>
Date: Tue, 15 Jan 2019 10:14:36 +0800
Subject: [LTP] [PATCH 6/6] ima/ima_violations: Temporarily remove the printk
	rate limit
In-Reply-To: <1547518476-34008-1-git-send-email-zhang.jia@linux.alibaba.com>
References: <1547518476-34008-1-git-send-email-zhang.jia@linux.alibaba.com>
Message-ID: <1547518476-34008-7-git-send-email-zhang.jia@linux.alibaba.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The output frequency of audit log is limited by printk_ratelimit()
in kernel if auditd not used. Thus, the test heavily depending on
searching keywords in log file may fail if the matching patterns
are exactly suppressed by printk_ratelimit().

In order to fix such a sort of failure, just temporarily remove
the limit, and recover its setting at the end of test.

Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
---
 .../kernel/security/integrity/ima/tests/ima_violations.sh  | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index f3f40d4..a1360b8 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -31,15 +31,27 @@ setup()
 	FILE="test.txt"
 	IMA_VIOLATIONS="$SECURITYFS/ima/violations"
 	LOG="/var/log/messages"
+	PRINTK_RATE_LIMIT="0"
 
 	if status_daemon auditd; then
 		LOG="/var/log/audit/audit.log"
+	else
+		tst_check_cmds sysctl
+
+		PRINTK_RATE_LIMIT=`sysctl -n kernel.printk_ratelimit`
+		sysctl -wq kernel.printk_ratelimit=0
 	fi
 	[ -f "$LOG" ] || \
 		tst_brk TBROK "log $LOG does not exist (bug in detection?)"
 	tst_res TINFO "using log $LOG"
 }
 
+reset_printk_ratelimit()
+{
+	[ "$PRINTK_RATE_LIMIT" != "0" ] && \
+		sysctl -wq kernel.printk_ratelimit=$PRINTK_RATE_LIMIT
+}
+
 open_file_read()
 {
 	exec 3< $FILE || exit 1
@@ -151,6 +163,8 @@ test3()
 
 	validate $num_violations $count $search
 
+	reset_printk_ratelimit
+
 	# wait for ima_mmap to exit, so we can umount
 	tst_sleep 2s
 }
-- 
1.8.3.1

