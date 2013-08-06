Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1V6gmz-0008Do-Vj
	for ltp-list@lists.sourceforge.net; Tue, 06 Aug 2013 12:55:02 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1V6gmy-0004CI-7b
	for ltp-list@lists.sourceforge.net; Tue, 06 Aug 2013 12:55:01 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r76CsrNF030232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 6 Aug 2013 12:54:54 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r76Csqdt000049
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 6 Aug 2013 12:54:53 GMT
Received: from abhmt113.oracle.com (abhmt113.oracle.com [141.146.116.65])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r76Csq3x000044
	for <ltp-list@lists.sourceforge.net>; Tue, 6 Aug 2013 12:54:52 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue,  6 Aug 2013 16:54:37 +0400
Message-Id: <1375793678-26497-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <20130806111355.GB24437@rei>
References: <20130806111355.GB24437@rei>
Subject: [LTP] [PATCH 1/2 V4] tst_run_cmd: added support for stdout and
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

Added function tst_run_cmd_fds which allows redirection of
stdout/stderr to file descriptors.

Now function tst_run_cmd is a wrapper to tst_run_cmd_fds.

Signed-off-by: Stanislav kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 include/test.h    |   20 +++++++++++++++-
 lib/tst_run_cmd.c |   66 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/include/test.h b/include/test.h
index a76fafc..1957148 100644
--- a/include/test.h
+++ b/include/test.h
@@ -219,8 +219,26 @@ long tst_ncpus_max(void);
  * @argv: a list of two (at least program name + NULL) or more pointers that
  * represent the argument list to the new program. The array of pointers
  * must be terminated by a NULL pointer.
+ * @stdout_fd: file descriptor where to redirect stdout. Set -1 if
+ * redirection is not needed.
+ * @stderr_fd: file descriptor where to redirect stderr. Set -1 if
+ * redirection is not needed.
  */
-void tst_run_cmd(void (cleanup_fn)(void), char *const argv[]);
+void tst_run_cmd_fds(void (cleanup_fn)(void),
+			char *const argv[],
+			int stdout_fd,
+			int stderr_fd);
+
+/* Executes tst_run_cmd_fds() and redirects its output to a file
+ * @stdout_path: path where to redirect stdout. Set NULL if redirection is
+ * not needed.
+ * @stderr_path: path where to redirect stderr. Set NULL if redirection is
+ * not needed.
+ */
+void tst_run_cmd(void (cleanup_fn)(void),
+		char *const argv[],
+		const char *stdout_path,
+		const char *stderr_path);
 
 #ifdef TST_USE_COMPAT16_SYSCALL
 #define TCID_BIT_SUFFIX "_16"
diff --git a/lib/tst_run_cmd.c b/lib/tst_run_cmd.c
index 93fe2d6..714b508 100644
--- a/lib/tst_run_cmd.c
+++ b/lib/tst_run_cmd.c
@@ -19,12 +19,21 @@
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
+void tst_run_cmd_fds(void (cleanup_fn)(void),
+		char *const argv[],
+		int stdout_fd,
+		int stderr_fd)
 {
 	if (argv == NULL || argv[0] == NULL) {
 		tst_brkm(TBROK, cleanup_fn,
@@ -36,8 +45,20 @@ void tst_run_cmd(void (cleanup_fn)(void), char *const argv[])
 		tst_brkm(TBROK | TERRNO, cleanup_fn, "vfork failed at %s:%d",
 			__FILE__, __LINE__);
 	}
-	if (!pid)
+	if (!pid) {
+		/* redirecting stdout and stderr if needed */
+		if (stdout_fd != -1) {
+			close(STDOUT_FILENO);
+			dup2(stdout_fd, STDOUT_FILENO);
+		}
+
+		if (stderr_fd != -1) {
+			close(STDERR_FILENO);
+			dup2(stderr_fd, STDERR_FILENO);
+		}
+
 		_exit(execvp(argv[0], argv));
+	}
 
 	int ret = -1;
 	if (waitpid(pid, &ret, 0) != pid) {
@@ -50,3 +71,44 @@ void tst_run_cmd(void (cleanup_fn)(void), char *const argv[])
 			argv[0], __FILE__, __LINE__);
 	}
 }
+
+void tst_run_cmd(void (cleanup_fn)(void),
+		char *const argv[],
+		const char *stdout_path,
+		const char *stderr_path)
+{
+	int stdout_fd = -1;
+	int stderr_fd = -1;
+
+	if (stdout_path != NULL) {
+		stdout_fd = open(stdout_path,
+				OPEN_FLAGS, OPEN_MODE);
+
+		if (stdout_fd == -1)
+			tst_resm(TWARN | TERRNO,
+				"open() on %s failed at %s:%d",
+				stdout_path, __FILE__, __LINE__);
+	}
+
+	if (stderr_path != NULL) {
+		stderr_fd = open(stderr_path,
+				OPEN_FLAGS, OPEN_MODE);
+
+		if (stderr_fd == -1)
+			tst_resm(TWARN | TERRNO,
+				"open() on %s failed at %s:%d",
+				stderr_path, __FILE__, __LINE__);
+	}
+
+	tst_run_cmd_fds(cleanup_fn, argv, stdout_fd, stderr_fd);
+
+	if ((stdout_fd != -1) && (close(stdout_fd) == -1))
+		tst_resm(TWARN | TERRNO,
+			"close() on %s failed at %s:%d",
+			stdout_path, __FILE__, __LINE__);
+
+	if ((stderr_fd != -1) && (close(stderr_fd) == -1))
+		tst_resm(TWARN | TERRNO,
+			"close() on %s failed at %s:%d",
+			stderr_path, __FILE__, __LINE__);
+}
-- 
1.7.1


------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
