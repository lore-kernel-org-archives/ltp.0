From: Jakub Racek <jracek@redhat.com>
Date: Fri, 31 Mar 2017 12:03:05 +0200
Subject: [LTP] [PATCH] syscalls/syslog02: fix typo (bug)
Message-ID: <1490954585-16384-1-git-send-email-jracek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If for whatever reason $MAILLOG file doesn't exist, then test of
arbitrary log level may fail, since number of grepped messages
(oldvalue) isn't set to 0 because of typo.

Signed-off-by: Jakub Racek <jracek@redhat.com>
---
 testcases/kernel/syscalls/syslog/syslog02 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/syslog/syslog02 b/testcases/kernel/syscalls/syslog/syslog02
index 7a55a84..2213ce3 100755
--- a/testcases/kernel/syscalls/syslog/syslog02
+++ b/testcases/kernel/syscalls/syslog/syslog02
@@ -72,7 +72,7 @@ syslog_case2()
 		if [ -e "$MAILLOG" ]; then
 			oldvalue=`grep -c "syslogtst: mail $level test\." $MAILLOG`
 		else
-			oldvalue1=0
+			oldvalue=0
 		fi
 
 		# syslogtst has to be called with additional level argument(0-7)
-- 
1.8.3.1

