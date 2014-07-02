Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1X2H4u-0007GI-Lj
	for ltp-list@lists.sourceforge.net; Wed, 02 Jul 2014 09:43:48 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X2H4t-0006rX-Dt
	for ltp-list@lists.sourceforge.net; Wed, 02 Jul 2014 09:43:48 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s629hbNY012544
	for <ltp-list@lists.sourceforge.net>; Wed, 2 Jul 2014 17:43:37 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Wed, 2 Jul 2014 17:40:09 +0800
Message-ID: <1404294010-18698-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1404294010-18698-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <1404294010-18698-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 2/3] lib/tst_res.c: introduce function
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

If we do real test work in child process and use tst_resm(), tst_brkm()
or tst_exit() interfaces in child process, we should use tst_record_childstatus()
to record the test results returned by child process correctly.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 include/test.h          |  1 +
 include/tst_res_flags.h |  5 +++++
 lib/tst_res.c           | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/include/test.h b/include/test.h
index 3d8bb7c..df66763 100644
--- a/include/test.h
+++ b/include/test.h
@@ -119,6 +119,7 @@ extern int Forker_npids;
 /* lib/tst_res.c */
 const char *strttype(int ttype);
 void tst_reset_exitval(void);
+int tst_record_childstatus(int status, int *sig);
 void tst_res(int ttype, const char *fname, const char *arg_fmt, ...)
 	__attribute__ ((format (printf, 3, 4)));
 void tst_resm(int ttype, const char *arg_fmt, ...)
diff --git a/include/tst_res_flags.h b/include/tst_res_flags.h
index 5c5ab4c..03a3285 100644
--- a/include/tst_res_flags.h
+++ b/include/tst_res_flags.h
@@ -27,4 +27,9 @@
 #define TRERRNO	0x300	/* Capture errno information from TEST_RETURN to
 			   output; useful for pthread-like APIs :). */
 
+#define CHILD_EXIT_NORMALLY	0
+#define CHILD_EXIT_SIGNALED	1
+#define CHILD_STOPPED		2
+#define CHILD_RESUMED		4
+
 #endif /* TST_RES_FLAGS_H */
diff --git a/lib/tst_res.c b/lib/tst_res.c
index 079fc42..24fb4d9 100644
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
@@ -228,6 +231,40 @@ void tst_reset_exitval(void)
 {
 	T_exitval = 0;
 }
+
+int tst_record_childstatus(int status, int *sig)
+{
+	int ret = 0, ttype_result, s = 0;
+
+	if (WIFEXITED(status)) {
+		ret = WEXITSTATUS(status);
+		ttype_result = TTYPE_RESULT(ret);
+		T_exitval |= ttype_result;
+		s = 0;
+		ret = CHILD_EXIT_NORMALLY;
+	} else if (WIFSIGNALED(status)) {
+		s = WTERMSIG(status);
+		tst_resm(TINFO, "child process is killed by signal: %s(%d)",
+			 tst_strsig(s), s);
+		ret = CHILD_EXIT_SIGNALED;
+	} else if (WIFSTOPPED(status)) {
+		s = WSTOPSIG(status);
+		tst_resm(TINFO, "child process is stopped by signal:%s(%d)",
+			 tst_strsig(s), s);
+		ret = CHILD_STOPPED;
+	} else if (WIFCONTINUED(status)) {
+		s = SIGCONT;
+		tst_resm(TINFO, "child process is resumed by signal:%s(%d)",
+			 tst_strsig(s), s);
+		ret = CHILD_RESUMED;
+	}
+
+	if (sig)
+		*sig = s;
+
+	return ret;
+}
+
 /*
  * tst_res() - Main result reporting function.  Handle test information
  *             appropriately depending on output display mode.  Call
-- 
1.8.2.1


------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
