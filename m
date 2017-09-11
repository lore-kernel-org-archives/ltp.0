From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 11 Sep 2017 13:11:41 +0200
Subject: [LTP] [PATCH COMMITTED] commands/gdb01: replace stdin with /dev/null
Message-ID: <2f6ab8f694b26b7f2566624f6d1f23788d6ab8a0.1505128066.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If this testcase runs as background process, gdb can receive
SIGTTOU and then testcase gets stuck.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/commands/gdb/gdb01.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/commands/gdb/gdb01.sh b/testcases/commands/gdb/gdb01.sh
index 07ae36fcb5ee..e3a5b519385c 100755
--- a/testcases/commands/gdb/gdb01.sh
+++ b/testcases/commands/gdb/gdb01.sh
@@ -29,7 +29,7 @@ TST_NEEDS_CMDS="gdb /bin/cat"
 
 simple_test()
 {
-	gdb /bin/cat -ex "run /etc/passwd" -ex quit
+	gdb /bin/cat -ex "run /etc/passwd" -ex quit < /dev/null
 	RC=$?
 	if [ $RC -eq 0 ] ; then
 		tst_res TPASS "gdb attached to process and completed run"
-- 
1.8.3.1

