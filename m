Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1X6Cgg-00065Z-4b
	for ltp-list@lists.sourceforge.net; Sun, 13 Jul 2014 05:51:02 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X6Cge-0007l0-9u
	for ltp-list@lists.sourceforge.net; Sun, 13 Jul 2014 05:51:02 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s6D5oM1g014707
	for <ltp-list@lists.sourceforge.net>; Sun, 13 Jul 2014 13:50:23 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Sun, 13 Jul 2014 13:49:50 +0800
Message-ID: <1405230591-19166-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 1/2] lib/tst_res.c: introduce
	tst_record_childstatus()
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

In case we need do real test work in child porcess, it is OK for child process
to use tst_resm(), tst_brkm() or tst_exit(). Parent process can use
tst_record_childstatus() to make child process's test results propagated to parent
process correctly.

Meanwhile we reset T_exitval to 0 for child process in tst_fork(), which will
make child process can record test results with tst_resm() or tst_brkm() correctly.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 include/test.h | 10 ++++++++++
 lib/tst_res.c  | 29 ++++++++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/include/test.h b/include/test.h
index 011866d..3672a8c 100644
--- a/include/test.h
+++ b/include/test.h
@@ -135,9 +135,19 @@ void tst_flush(void);
 
 /*
  * tst_flush() + fork
+ * NOTE: tst_fork() will reset T_exitval to 0 for child process.
  */
 pid_t tst_fork(void);
 
+/* lib/tst_res.c */
+/*
+ * In case we need do real test work in child porcess, it is OK for
+ * child process to use tst_resm(), tst_brkm() or tst_exit(). Parent
+ * process can use tst_record_childstatus() to make child process's
+ * test results propagated to parent process correctly.
+ */
+void tst_record_childstatus(void (*cleanup)(void), pid_t child);
+
 extern int tst_count;
 
 /* lib/tst_sig.c */
diff --git a/lib/tst_res.c b/lib/tst_res.c
index 31186e0..35eefa3 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -101,6 +101,9 @@
 #include <stdarg.h>
 #include <string.h>
 #include <unistd.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+
 #include "test.h"
 #include "usctest.h"
 #include "ltp_priv.h"
@@ -568,8 +571,32 @@ void tst_exit(void)
 
 pid_t tst_fork(void)
 {
+	pid_t child;
+
 	tst_flush();
-	return fork();
+
+	child = fork();
+	if (child == 0)
+		T_exitval = 0;
+
+	return child;
+}
+
+void tst_record_childstatus(void (*cleanup)(void), pid_t child)
+{
+	int status, ttype_result;
+
+	if (waitpid(child, &status, 0) < 0)
+		tst_brkm(TBROK | TERRNO, cleanup, "waitpid(%d) failed", child);
+
+	if (WIFEXITED(status)) {
+		ttype_result = WEXITSTATUS(status);
+		ttype_result = TTYPE_RESULT(ttype_result);
+		T_exitval |= ttype_result;
+	} else {
+		tst_brkm(TBROK, cleanup, "child process(%d) killed by "
+			 "unexpected signal", child);
+	}
 }
 
 pid_t tst_vfork(void)
-- 
1.8.2.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
