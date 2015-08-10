Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jack@suse.cz>) id 1ZOngt-00051N-CV
	for ltp-list@lists.sourceforge.net; Mon, 10 Aug 2015 14:04:39 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZOngq-0002m5-TD
	for ltp-list@lists.sourceforge.net; Mon, 10 Aug 2015 14:04:39 +0000
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id BC9D8AAC2
	for <ltp-list@lists.sourceforge.net>;
	Mon, 10 Aug 2015 14:04:29 +0000 (UTC)
From: Jan Kara <jack@suse.com>
Date: Mon, 10 Aug 2015 16:04:20 +0200
Message-Id: <1439215460-15670-1-git-send-email-jack@suse.com>
Subject: [LTP] [PATCH v2] inotify: Add test for inotify mark destruction race
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
Cc: Jan Kara <jack@suse.com>

Kernels prior to 4.2 have a race when inode is being deleted while
inotify group watching that inode is being torn down. When the race is
hit, the kernel crashes or loops. Test for that race.

The problem has been fixed by commit 8f2f3eb59dff "fsnotify: fix oops in
fsnotify_clear_marks_by_group_flags()".

Signed-off-by: Jan Kara <jack@suse.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/inotify/inotify06.c | 121 ++++++++++++++++++++++++++
 2 files changed, 122 insertions(+)
 create mode 100644 testcases/kernel/syscalls/inotify/inotify06.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 70d4945706ea..c532fe307df9 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -449,6 +449,7 @@ inotify02 inotify02
 inotify03 inotify03
 inotify04 inotify04
 inotify05 inotify05
+inotify06 inotify06
 
 fanotify01 fanotify01
 fanotify02 fanotify02
diff --git a/testcases/kernel/syscalls/inotify/inotify06.c b/testcases/kernel/syscalls/inotify/inotify06.c
new file mode 100644
index 000000000000..373f5bd19217
--- /dev/null
+++ b/testcases/kernel/syscalls/inotify/inotify06.c
@@ -0,0 +1,121 @@
+#include "config.h"
+
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <time.h>
+#include <signal.h>
+#include <sys/inotify.h>
+#include <sys/time.h>
+#include <sys/wait.h>
+#include <sys/syscall.h>
+
+#include "test.h"
+#include "linux_syscall_numbers.h"
+#include "inotify.h"
+#include "safe_macros.h"
+
+char *TCID = "inotify06";
+int TST_TOTAL = 1;
+
+#if defined(HAVE_SYS_INOTIFY_H)
+#include <sys/inotify.h>
+
+/* Number of test loops to run the test for */
+#define TEARDOWNS 100000
+
+/* Number of files to test (must be > 1) */
+#define FILES 5
+
+char names[FILES][PATH_MAX];
+
+static void cleanup(void)
+{
+	tst_rmdir();
+}
+
+static void setup(void)
+{
+	int i;
+
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+
+	tst_tmpdir();
+
+	for (i = 0; i < FILES; i++)
+		sprintf(names[i], "fname_%d", i);
+}
+
+int main(int ac, char **av)
+{
+	int inotify_fd, fd;
+	pid_t pid;
+	int i, lc;
+	int tests;
+
+	tst_parse_opts(ac, av, NULL, NULL);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		pid = fork();
+		if (pid == 0) {
+			while (1) {
+				for (i = 0; i < FILES; i++) {
+					fd = SAFE_OPEN(cleanup, names[i],
+						       O_CREAT | O_RDWR, 0600);
+					SAFE_CLOSE(cleanup, fd);
+				}
+				for (i = 0; i < FILES; i++)
+					SAFE_UNLINK(cleanup, names[i]);
+			}
+		} else if (pid == -1)
+			tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
+
+		for (tests = 0; tests < TEARDOWNS; tests++) {
+			inotify_fd = syscall(__NR_inotify_init1, O_NONBLOCK);
+			if (inotify_fd < 0) {
+				if (errno == ENOSYS) {
+					tst_brkm(TCONF, cleanup,
+					 	 "inotify is not configured in this "
+						 "kernel.");
+				} else {
+					tst_brkm(TBROK | TERRNO, cleanup,
+						 "inotify_init failed");
+				}
+			}
+			for (i = 0; i < FILES; i++) {
+				/*
+				 * Both failure and success are fine since
+				 * files are being deleted in parallel - this
+				 * is what provokes the race we want to test
+				 * for...
+				 */
+				myinotify_add_watch(inotify_fd, names[i],
+						    IN_MODIFY);
+			}
+			SAFE_CLOSE(cleanup, inotify_fd);
+		}
+		/* We survived for given time - test succeeded */
+		tst_resm(TPASS, "kernel survived inotify beating");
+
+		/* Kill the child creating / deleting files and wait for it */
+		kill(pid, SIGKILL);
+		wait(NULL);
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+#else
+
+int main(void)
+{
+	tst_brkm(TCONF, NULL, "system doesn't have required inotify support");
+}
+
+#endif
-- 
2.1.4


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
