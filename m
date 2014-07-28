Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1XBjTz-0003uN-IS
	for ltp-list@lists.sourceforge.net; Mon, 28 Jul 2014 11:52:47 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XBjTy-0001Gt-E5
	for ltp-list@lists.sourceforge.net; Mon, 28 Jul 2014 11:52:47 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s6SBqYWN016764
	for <ltp-list@lists.sourceforge.net>; Mon, 28 Jul 2014 19:52:34 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Mon, 28 Jul 2014 19:51:39 +0800
Message-ID: <1406548301-21888-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <20140722143000.GA22955@rei>
References: <20140722143000.GA22955@rei>
MIME-Version: 1.0
Subject: [LTP] [PATCH v3 1/3] lib/tst_res.c: introduce
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
index 2013a36..b49ae22 100644
--- a/include/test.h
+++ b/include/test.h
@@ -161,9 +161,19 @@ void tst_flush(void);
 
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
index c584265..57f2d07 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -72,6 +72,9 @@
 #include <stdarg.h>
 #include <string.h>
 #include <unistd.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+
 #include "test.h"
 #include "usctest.h"
 #include "ltp_priv.h"
@@ -542,8 +545,32 @@ void tst_exit(void)
 
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
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
