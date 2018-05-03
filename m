Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jack@suse.cz>) id 1fECdj-0000EY-KW
 for ltp-list@lists.sourceforge.net; Thu, 03 May 2018 11:43:11 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1:ECDHE-RSA-AES256-SHA:256) (Exim 4.90_1) id 1fECdf-003mNm-W8
 for ltp-list@lists.sourceforge.net; Thu, 03 May 2018 11:43:11 +0000
From: Jan Kara <jack@suse.cz>
Date: Thu,  3 May 2018 13:42:52 +0200
Message-Id: <20180503114252.12548-1-jack@suse.cz>
Subject: [LTP] [PATCH] inotify07: Add test for kernel crash during event
 notification
List-Id: Linux Test Project General Discussions
 <ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/ltp-list>,
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
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>

When a removal of the last mark on inode / vfsmount races with a
notification about new event on that object, the kernel can crash. Test
for this failure. The problem was fixed by kernel commit d90a10e2444b
"fsnotify: Fix fsnotify_mark_connector race".

Signed-off-by: Jan Kara <jack@suse.cz>
---
 testcases/kernel/syscalls/inotify/inotify07.c | 104 ++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 testcases/kernel/syscalls/inotify/inotify07.c

diff --git a/testcases/kernel/syscalls/inotify/inotify07.c b/testcases/kernel/syscalls/inotify/inotify07.c
new file mode 100644
index 000000000000..d20a824f0e8d
--- /dev/null
+++ b/testcases/kernel/syscalls/inotify/inotify07.c
@@ -0,0 +1,104 @@
+/*
+ * Copyright (c) 2015 SUSE Linux.  All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it is
+ * free of the rightful claim of any third person regarding infringement
+ * or the like.  Any license provided herein, whether implied or
+ * otherwise, applies only to this software file.  Patent licenses, if
+ * any, provided herein do not apply to combinations of this program with
+ * other software, or any other product whatsoever.
+ *
+ * Started by Jan Kara <jack@suse.cz>
+ *
+ * DESCRIPTION
+ * Test for inotify mark connector destruction race.
+ *
+ * Kernels prior to 4.17 have a race when the last fsnotify mark on the inode
+ * is being deleted while another process reports event happening on that
+ * inode. When the race is hit, the kernel crashes or loops.
+ *
+ * The problem has been fixed by commit:
+ * d90a10e2444b "fsnotify: Fix fsnotify_mark_connector race"
+ */
+
+#include "config.h"
+
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <time.h>
+#include <signal.h>
+#include <sys/time.h>
+#include <sys/wait.h>
+#include <sys/syscall.h>
+
+#include "tst_test.h"
+#include "inotify.h"
+
+#if defined(HAVE_SYS_INOTIFY_H)
+#include <sys/inotify.h>
+
+/* Number of test loops to run the test for */
+#define TEARDOWNS 1000000
+
+static void verify_inotify(void)
+{
+	int inotify_fd, fd;
+	int wd;
+	pid_t pid;
+	int tests;
+	char *name = "stress_fname";
+
+	fd = SAFE_OPEN(name, O_CREAT | O_RDWR, 0600);
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		char buf[64];
+
+		memset(buf, 'a', sizeof(buf));
+		while (1) {
+			SAFE_WRITE(0, fd, buf, sizeof(buf));
+			SAFE_LSEEK(fd, 0, SEEK_SET);
+		}
+		/* Never reached */
+	}
+	SAFE_CLOSE(fd);
+
+	inotify_fd = myinotify_init1(0);
+	if (inotify_fd < 0)
+		tst_brk(TBROK | TERRNO, "inotify_init failed");
+	for (tests = 0; tests < TEARDOWNS; tests++) {
+		wd = myinotify_add_watch(inotify_fd, name, IN_MODIFY);
+		if (wd < 0)
+			tst_brk(TBROK | TERRNO, "inotify_add_watch() failed.");
+		wd = myinotify_rm_watch(inotify_fd, wd);
+		if (wd < 0)
+			tst_brk(TBROK | TERRNO, "inotify_rm_watch() failed.");
+	}
+	SAFE_CLOSE(inotify_fd);
+	/* We survived for given time - test succeeded */
+	tst_res(TPASS, "kernel survived inotify beating");
+
+	/* Kill the child writing to file and wait for it */
+	SAFE_KILL(pid, SIGKILL);
+	SAFE_WAIT(NULL);
+}
+
+static struct tst_test test = {
+	.timeout = 600,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.test_all = verify_inotify,
+};
+
+#else
+	TST_TEST_TCONF("system doesn't have required inotify support");
+#endif
-- 
2.13.6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
