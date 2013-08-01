Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1V4scc-0006AP-OK
	for ltp-list@lists.sourceforge.net; Thu, 01 Aug 2013 13:08:50 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1V4sca-0002g1-V2
	for ltp-list@lists.sourceforge.net; Thu, 01 Aug 2013 13:08:50 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r71D8fZD018814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Aug 2013 13:08:42 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r71D8flq015100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Aug 2013 13:08:41 GMT
Received: from abhmt114.oracle.com (abhmt114.oracle.com [141.146.116.66])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r71D8eKO029457
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Aug 2013 13:08:40 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu,  1 Aug 2013 17:08:09 +0400
Message-Id: <1375362489-27214-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <20130731141915.GA2698@rei.scz.novell.com>
References: <20130731141915.GA2698@rei.scz.novell.com>
Subject: [LTP] [PATCH 1/2 V2] tst_run_cmd: added support for stdout and
	stderr redirection
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com, alexey.kodanev@oracle.com

From: Stanislav kholmanskikh <stanislav.kholmanskikh@oracle.com>

Signed-off-by: Stanislav kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 include/test.h    |    9 ++++++++-
 lib/tst_run_cmd.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/include/test.h b/include/test.h
index a76fafc..f294b16 100644
--- a/include/test.h
+++ b/include/test.h
@@ -219,8 +219,15 @@ long tst_ncpus_max(void);
  * @argv: a list of two (at least program name + NULL) or more pointers that
  * represent the argument list to the new program. The array of pointers
  * must be terminated by a NULL pointer.
+ * @stdout_path: path where to redirect stdout. Set NULL if redirection is
+ * not needed.
+ * @stderr_path: path where to redirect stderr. Set NULL if redirection is
+ * not needed.
  */
-void tst_run_cmd(void (cleanup_fn)(void), char *const argv[]);
+void tst_run_cmd(void (cleanup_fn)(void),
+		char *const argv[],
+		const char *stdout_path,
+		const char *stderr_path);
 
 #ifdef TST_USE_COMPAT16_SYSCALL
 #define TCID_BIT_SUFFIX "_16"
diff --git a/lib/tst_run_cmd.c b/lib/tst_run_cmd.c
index 93fe2d6..044adc7 100644
--- a/lib/tst_run_cmd.c
+++ b/lib/tst_run_cmd.c
@@ -19,25 +19,71 @@
  *
  */
 
+#include <errno.h>
 #include <sys/types.h>
+#include <sys/stat.h>
 #include <sys/wait.h>
+#include <fcntl.h>
 #include <unistd.h>
 #include "test.h"
 
-void tst_run_cmd(void (cleanup_fn)(void), char *const argv[])
+#define OPEN_MODE	(S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH)
+#define OPEN_FLAGS	(O_WRONLY | O_APPEND | O_CREAT)
+
+void tst_run_cmd(void (cleanup_fn)(void),
+		char *const argv[],
+		const char *stdout_path,
+		const char *stderr_path)
 {
 	if (argv == NULL || argv[0] == NULL) {
 		tst_brkm(TBROK, cleanup_fn,
 			"argument list is empty at %s:%d", __FILE__, __LINE__);
 	}
 
+	/* descriptors for child (if needed) */
+	int child_stdout;
+	int child_stderr;
+
 	pid_t pid = vfork();
 	if (pid == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn, "vfork failed at %s:%d",
 			__FILE__, __LINE__);
 	}
-	if (!pid)
+	if (!pid) {
+		/* redirecting stdout and stderr if needed */
+		if (stdout_path != NULL) {
+			child_stdout = open(stdout_path,
+					OPEN_FLAGS, OPEN_MODE);
+
+			if (child_stdout == -1) {
+				tst_resm(TWARN | TERRNO,
+					"open() on %s failed at %s:%d: %s",
+					stdout_path, __FILE__, __LINE__,
+					strerror(errno));
+			} else {
+				close(STDOUT_FILENO);
+				dup2(child_stdout, STDOUT_FILENO);
+			}
+
+		}
+
+		if (stderr_path != NULL) {
+			child_stderr = open(stderr_path,
+					OPEN_FLAGS, OPEN_MODE);
+
+			if (child_stderr == -1) {
+				tst_resm(TWARN | TERRNO,
+					"open() on %s failed at %s:%d: %s",
+					stderr_path, __FILE__, __LINE__,
+					strerror(errno));
+			} else {
+				close(STDERR_FILENO);
+				dup2(child_stderr, STDERR_FILENO);
+			}
+		}
+
 		_exit(execvp(argv[0], argv));
+	}
 
 	int ret = -1;
 	if (waitpid(pid, &ret, 0) != pid) {
-- 
1.7.1


------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
