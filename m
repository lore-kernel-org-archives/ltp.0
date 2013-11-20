Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jack@suse.cz>) id 1Vj4Z0-0002Zu-Cu
	for ltp-list@lists.sourceforge.net; Wed, 20 Nov 2013 09:59:14 +0000
Received: from relay1.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id CCB98A7AA5
	for <ltp-list@lists.sourceforge.net>;
	Wed, 20 Nov 2013 10:59:03 +0100 (CET)
Date: Wed, 20 Nov 2013 10:59:02 +0100
From: Jan Kara <jack@suse.cz>
Message-ID: <20131120095902.GB30274@quack.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
Subject: [LTP] fanotify tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

  since I have been doing some changes to in-kernel fanotify
implementation, I wrote a set of tests to excercise fanotify system calls.
Can they be merged into LTP? The patch is attached.

								Honza
-- 
Jan Kara <jack@suse.cz>
SUSE Labs, CR

--pWyiEgJYm5f9v55/
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-fanotify-Add-tests-verifying-fanotify-syscalls.patch"

From 98982b848c2e5bf86443750b726e4a0fef6f0a49 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Wed, 20 Nov 2013 00:06:47 +0100
Subject: [PATCH] fanotify: Add tests verifying fanotify syscalls

Signed-off-by: Jan Kara <jack@suse.cz>
---
 configure.ac                                    |   1 +
 testcases/kernel/syscalls/fanotify/Makefile     |  23 ++
 testcases/kernel/syscalls/fanotify/fanotify.h   |  39 ++
 testcases/kernel/syscalls/fanotify/fanotify01.c | 459 ++++++++++++++++++++++++
 testcases/kernel/syscalls/fanotify/fanotify02.c | 306 ++++++++++++++++
 testcases/kernel/syscalls/fanotify/fanotify03.c | 334 +++++++++++++++++
 testcases/kernel/syscalls/fanotify/fanotify04.c | 328 +++++++++++++++++
 7 files changed, 1490 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fanotify/Makefile
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify.h
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify01.c
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify02.c
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify03.c
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify04.c

diff --git a/configure.ac b/configure.ac
index 940f4f7bd757..4846afd35d93 100644
--- a/configure.ac
+++ b/configure.ac
@@ -43,6 +43,7 @@ AC_CHECK_HEADERS([ \
     linux/netlink.h \
     sys/epoll.h \
     sys/inotify.h \
+    sys/fanotify.h \
     sys/jfsdmapi.h \
     sys/prctl.h \
 ])
diff --git a/testcases/kernel/syscalls/fanotify/Makefile b/testcases/kernel/syscalls/fanotify/Makefile
new file mode 100644
index 000000000000..91da9ff96d11
--- /dev/null
+++ b/testcases/kernel/syscalls/fanotify/Makefile
@@ -0,0 +1,23 @@
+#
+#  Copyright (c) SWSoft, 2007
+#
+#  This program is free software;  you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  the GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program;  if not, write to the Free Software
+#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
new file mode 100644
index 000000000000..436e67da8945
--- /dev/null
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -0,0 +1,39 @@
+/*
+ * fanotify testcase common definitions.
+ *
+ * Copyright (c) 2012 Linux Test Project.  All Rights Reserved.
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
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ * Jan Kara, November 2013
+ */
+
+#ifndef	_FANOTIFY_H
+#define	_FANOTIFY_H
+
+/* fanotify(7) wrappers */
+
+#define	myfanotify_init(flags, event_f_flags) \
+	syscall(__NR_fanotify_init, flags, event_f_flags)
+
+#define	myfanotify_mark(fd, flags, mask, dfd, pathname)	\
+	syscall(__NR_fanotify_mark, fd, flags, mask, dfd, pathname)
+
+#endif /* _FANOTIFY_H */
diff --git a/testcases/kernel/syscalls/fanotify/fanotify01.c b/testcases/kernel/syscalls/fanotify/fanotify01.c
new file mode 100644
index 000000000000..f4229ec8dbca
--- /dev/null
+++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
@@ -0,0 +1,459 @@
+/*
+ * Copyright (c) 2013 SUSE.  All Rights Reserved.
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
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ * Started by Jan Kara <jack@suse.cz>
+ *
+ * DESCRIPTION
+ *     Check that fanotify work for a file
+ */
+#include "config.h"
+
+#include <stdio.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/fcntl.h>
+#include <errno.h>
+#include <string.h>
+#include <sys/syscall.h>
+#include "test.h"
+#include "usctest.h"
+#include "linux_syscall_numbers.h"
+#include "fanotify.h"
+
+#if defined(HAVE_SYS_FANOTIFY_H)
+#include <sys/fanotify.h>
+
+#define EVENT_MAX 1024
+/* size of the event structure, not counting name */
+#define EVENT_SIZE  (sizeof (struct fanotify_event_metadata))
+/* reasonable guess as to size of 1024 events */
+#define EVENT_BUF_LEN        (EVENT_MAX * EVENT_SIZE)
+
+char *TCID = "fanotify01";
+int TST_TOTAL = 12;
+
+static void setup(void);
+static void cleanup(void);
+
+#define BUF_SIZE 256
+static char fname[BUF_SIZE];
+static char buf[BUF_SIZE];
+static int fd, fd_notify;
+
+static unsigned long long event_set[EVENT_MAX];
+
+static char event_buf[EVENT_BUF_LEN];
+
+int main(int ac, char **av)
+{
+	int lc;
+	char *msg;
+
+	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		int ret, len, i = 0, test_num = 0;
+
+		tst_count = 0;
+
+		if (myfanotify_mark(fd_notify, FAN_MARK_ADD, FAN_ACCESS | FAN_MODIFY |
+				    FAN_CLOSE | FAN_OPEN, AT_FDCWD, fname) < 0) {
+			tst_brkm(TBROK | TERRNO, cleanup,
+			    "fanotify_mark (%d, FAN_MARK_ADD, FAN_ACCESS | "
+			    "FAN_MODIFY | FAN_CLOSE | FAN_OPEN, AT_FDCWD, %s) "
+			    "failed", fd_notify, fname);
+		}
+
+		/*
+		 * generate sequence of events
+		 */
+		if ((fd = open(fname, O_RDONLY)) == -1) {
+			tst_brkm(TBROK | TERRNO, cleanup,
+				 "open(%s, O_RDONLY) failed", fname);
+		}
+		event_set[tst_count] = FAN_OPEN;
+		tst_count++;
+
+		if (read(fd, buf, BUF_SIZE) == -1) {
+			tst_brkm(TBROK | TERRNO, cleanup,
+				 "read(%d, buf, %d) failed", fd, BUF_SIZE);
+		}
+		event_set[tst_count] = FAN_ACCESS;
+		tst_count++;
+
+		if (close(fd) == -1) {
+			tst_brkm(TBROK, cleanup, "close(%s) failed", fname);
+		}
+		event_set[tst_count] = FAN_CLOSE_NOWRITE;
+		tst_count++;
+
+		/*
+		 * Get list of events so far. We get events here to avoid
+		 * merging of following events with the previous ones.
+		 */
+		if ((ret = read(fd_notify, event_buf, EVENT_BUF_LEN)) < 0) {
+			tst_brkm(TBROK, cleanup,
+				 "read(%d, buf, %zu) failed",
+				 fd_notify, EVENT_BUF_LEN);
+
+		}
+		len = ret;
+
+		if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1) {
+			tst_brkm(TBROK, cleanup,
+				 "open(%s, O_RDWR|O_CREAT,0700) failed", fname);
+		}
+		event_set[tst_count] = FAN_OPEN;
+		tst_count++;
+
+		if (write(fd, fname, strlen(fname)) == -1) {
+			tst_brkm(TBROK, cleanup,
+				 "write(%d, %s, %d) failed", fd, fname,
+				 (int)strlen(fname));
+		}
+		event_set[tst_count] = FAN_MODIFY;
+		tst_count++;
+
+		if (close(fd) == -1) {
+			tst_brkm(TBROK, cleanup, "close(%s) failed", fname);
+		}
+		event_set[tst_count] = FAN_CLOSE_WRITE;
+		tst_count++;
+
+		/*
+		 * get another list of events
+		 */
+		ret = read(fd_notify, event_buf + len, EVENT_BUF_LEN - len);
+		if (ret < 0) {
+			tst_brkm(TBROK, cleanup,
+				 "read(%d, buf, %zu) failed",
+				 fd_notify, EVENT_BUF_LEN);
+
+		}
+		len += ret;
+
+		/*
+		 * Ignore mask testing
+		 */
+
+		/* Ignore access events */
+		if (myfanotify_mark(fd_notify,
+				    FAN_MARK_ADD | FAN_MARK_IGNORED_MASK,
+				    FAN_ACCESS, AT_FDCWD, fname) < 0) {
+			tst_brkm(TBROK | TERRNO, cleanup,
+			     "fanotify_mark (%d, FAN_MARK_ADD | "
+			     "FAN_MARK_IGNORED_MASK, FAN_ACCESS, "
+			     "AT_FDCWD, %s) failed", fd_notify, fname);
+		}
+
+		if ((fd = open(fname, O_RDWR)) == -1) {
+			tst_brkm(TBROK, cleanup,
+				 "open(%s, O_RDWR) failed", fname);
+		}
+		event_set[tst_count] = FAN_OPEN;
+		tst_count++;
+
+		/* This event should be ignored */
+		if (read(fd, buf, BUF_SIZE) == -1) {
+			tst_brkm(TBROK | TERRNO, cleanup,
+				 "read(%d, buf, %d) failed", fd, BUF_SIZE);
+		}
+
+		/*
+		 * get another list of events to verify the last one got ignored
+		 */
+		ret = read(fd_notify, event_buf + len, EVENT_BUF_LEN - len);
+		if (ret < 0) {
+			tst_brkm(TBROK, cleanup,
+				 "read(%d, buf, %zu) failed",
+				 fd_notify, EVENT_BUF_LEN);
+
+		}
+		len += ret;
+
+		lseek(fd, 0, SEEK_SET);
+		/* Generate modify event to clear ignore mask */
+		if (write(fd, fname, 1) == -1) {
+			tst_brkm(TBROK, cleanup,
+				 "write(%d, %s, 1) failed", fd, fname);
+		}
+		event_set[tst_count] = FAN_MODIFY;
+		tst_count++;
+
+		/*
+		 * This event shouldn't be ignored because previous modification
+		 * should have removed the ignore mask
+		 */
+		if (read(fd, buf, BUF_SIZE) == -1) {
+			tst_brkm(TBROK | TERRNO, cleanup,
+				 "read(%d, buf, %d) failed", fd, BUF_SIZE);
+		}
+		event_set[tst_count] = FAN_ACCESS;
+		tst_count++;
+
+		if (close(fd) == -1) {
+			tst_brkm(TBROK, cleanup, "close(%s) failed", fname);
+		}
+		event_set[tst_count] = FAN_CLOSE_WRITE;
+		tst_count++;
+
+		/* Read events to verify previous access was properly generated */
+		ret = read(fd_notify, event_buf + len, EVENT_BUF_LEN - len);
+		if (ret < 0) {
+			tst_brkm(TBROK, cleanup,
+				 "read(%d, buf, %zu) failed",
+				 fd_notify, EVENT_BUF_LEN);
+
+		}
+		len += ret;
+
+		/*
+		 * Now ignore open & close events regardless of file
+		 * modifications
+		 */
+		if (myfanotify_mark(fd_notify,
+				    FAN_MARK_ADD | FAN_MARK_IGNORED_MASK | FAN_MARK_IGNORED_SURV_MODIFY,
+				    FAN_OPEN | FAN_CLOSE, AT_FDCWD, fname) < 0) {
+			tst_brkm(TBROK | TERRNO, cleanup,
+			     "fanotify_mark (%d, FAN_MARK_ADD | "
+			     "FAN_MARK_IGNORED_MASK | "
+			     "FAN_MARK_IGNORED_SURV_MODIFY, FAN_OPEN | "
+			     "FAN_CLOSE, AT_FDCWD, %s) failed", fd_notify,
+			     fname);
+		}
+
+		/* This event should be ignored */
+		if ((fd = open(fname, O_RDWR)) == -1) {
+			tst_brkm(TBROK, cleanup,
+				 "open(%s, O_RDWR) failed", fname);
+		}
+
+		if (write(fd, fname, 1) == -1) {
+			tst_brkm(TBROK, cleanup,
+				 "write(%d, %s, 1) failed", fd, fname);
+		}
+		event_set[tst_count] = FAN_MODIFY;
+		tst_count++;
+
+		/* This event should be still ignored */
+		if (close(fd) == -1) {
+			tst_brkm(TBROK, cleanup, "close(%s) failed", fname);
+		}
+
+		/* This event should still be ignored */
+		if ((fd = open(fname, O_RDWR)) == -1) {
+			tst_brkm(TBROK, cleanup,
+				 "open(%s, O_RDWR) failed", fname);
+		}
+
+		/* Read events to verify open & close were ignored */
+		ret = read(fd_notify, event_buf + len, EVENT_BUF_LEN - len);
+		if (ret < 0) {
+			tst_brkm(TBROK, cleanup,
+				 "read(%d, buf, %zu) failed",
+				 fd_notify, EVENT_BUF_LEN);
+
+		}
+		len += ret;
+
+		/* Now remove open and close from ignored mask */
+		if (myfanotify_mark(fd_notify,
+				    FAN_MARK_REMOVE | FAN_MARK_IGNORED_MASK,
+				    FAN_OPEN | FAN_CLOSE, AT_FDCWD, fname) < 0) {
+			tst_brkm(TBROK | TERRNO, cleanup,
+			     "fanotify_mark (%d, FAN_MARK_REMOVE | "
+			     "FAN_MARK_IGNORED_MASK, FAN_OPEN | "
+			     "FAN_CLOSE, AT_FDCWD, %s) failed", fd_notify,
+			     fname);
+		}
+
+		if (close(fd) == -1) {
+			tst_brkm(TBROK, cleanup, "close(%s) failed", fname);
+		}
+		event_set[tst_count] = FAN_CLOSE_WRITE;
+		tst_count++;
+
+		/* Read events to verify close was generated */
+		ret = read(fd_notify, event_buf + len, EVENT_BUF_LEN - len);
+		if (ret < 0) {
+			tst_brkm(TBROK, cleanup,
+				 "read(%d, buf, %zu) failed",
+				 fd_notify, EVENT_BUF_LEN);
+
+		}
+		len += ret;
+
+		if (TST_TOTAL != tst_count) {
+			tst_brkm(TBROK, cleanup,
+				 "TST_TOTAL (%d) and tst_count (%d) are not "
+				 "equal", TST_TOTAL, tst_count);
+		}
+		tst_count = 0;
+
+
+		/*
+		 * check events
+		 */
+		while (i < len) {
+			struct fanotify_event_metadata *event;
+
+			event = (struct fanotify_event_metadata *)&event_buf[i];
+			if (test_num >= TST_TOTAL) {
+				tst_resm(TFAIL,
+					 "get unnecessary event: mask=%llx "
+					 "pid=%u fd=%u",
+					 (unsigned long long)event->mask,
+					 (unsigned)event->pid, event->fd);
+			} else if (!(event->mask & event_set[test_num])) {
+				tst_resm(TFAIL,
+					 "get event: mask=%llx (expected %llx) "
+					 "pid=%u fd=%u",
+					 (unsigned long long)event->mask,
+					 event_set[test_num],
+					 (unsigned)event->pid, event->fd);
+			} else if (event->pid != getpid()) {
+				tst_resm(TFAIL,
+					 "get event: mask=%llx pid=%u "
+					 "(expected %u) fd=%u",
+					 (unsigned long long)event->mask,
+					 (unsigned)event->pid,
+					 (unsigned)getpid(),
+					 event->fd);
+			} else {
+				if (event->fd == -2)
+					goto pass;
+				ret = read(event->fd, buf, BUF_SIZE);
+				if (ret != strlen(fname)) {
+					tst_resm(TFAIL,
+						 "cannot read from returned fd "
+						 "of event: mask=%llx pid=%u "
+						 "fd=%u ret=%d (errno=%d)",
+						 (unsigned long long)event->mask,
+						 (unsigned)event->pid,
+						 event->fd, ret, errno);
+				} else if (memcmp(buf, fname, strlen(fname))) {
+					tst_resm(TFAIL,
+						 "wrong data read from returned fd "
+						 "of event: mask=%llx pid=%u "
+						 "fd=%u",
+						 (unsigned long long)event->mask,
+						 (unsigned)event->pid,
+						 event->fd);
+				} else {
+pass:
+					tst_resm(TPASS,
+					    "get event: mask=%llx pid=%u fd=%u",
+					    (unsigned long long)event->mask,
+					    (unsigned)event->pid, event->fd);
+				}
+			}
+			/*
+			 * We have verified the data now so close fd and
+			 * invalidate it so that we don't check it again
+			 * unnecessarily
+			 */
+			close(event->fd);
+			event->fd = -2;
+			event->mask &= ~event_set[test_num];
+			/* No events left in current mask? Go for next event */
+			if (event->mask == 0) {
+				i += event->event_len;
+			}
+			test_num++;
+		}
+		for (; test_num < TST_TOTAL; test_num++) {
+			tst_resm(TFAIL, "didn't get event: mask=%llx",
+				 event_set[test_num]);
+
+		}
+		/* Remove mark to clear FAN_MARK_IGNORED_SURV_MODIFY */
+		if (myfanotify_mark(fd_notify, FAN_MARK_REMOVE, FAN_ACCESS | FAN_MODIFY |
+				    FAN_CLOSE | FAN_OPEN, AT_FDCWD, fname) < 0) {
+			tst_brkm(TBROK | TERRNO, cleanup,
+			    "fanotify_mark (%d, FAN_MARK_REMOVE, FAN_ACCESS | "
+			    "FAN_MODIFY | FAN_CLOSE | FAN_OPEN, AT_FDCWD, %s) "
+			    "failed", fd_notify, fname);
+		}
+
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+
+	tst_tmpdir();
+
+	sprintf(fname, "tfile_%d", getpid());
+	if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "open(%s, O_RDWR|O_CREAT,0700) failed", fname);
+	}
+	if ((write(fd, fname, 1)) == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup, "write(%d, %s, 1) failed",
+			 fd, fname);
+	}
+
+	/* close the file we have open */
+	if (close(fd) == -1) {
+		tst_brkm(TBROK, cleanup, "close(%s) failed", fname);
+	}
+	if ((fd_notify = myfanotify_init(FAN_CLASS_NOTIF, O_RDONLY)) < 0) {
+		if (errno == ENOSYS) {
+			tst_brkm(TCONF, cleanup,
+				 "fanotify is not configured in this kernel.");
+		} else {
+			tst_brkm(TBROK | TERRNO, cleanup,
+				 "fanotify_init failed");
+		}
+	}
+}
+
+static void cleanup(void)
+{
+	if (close(fd_notify) == -1) {
+		tst_resm(TWARN, "close(%d) failed", fd_notify);
+	}
+
+	TEST_CLEANUP;
+	tst_rmdir();
+}
+
+#else
+
+char *TCID = "fanotify01";
+int TST_TOTAL = 0;
+
+int main(void)
+{
+	tst_brkm(TCONF, NULL, "system doesn't have required fanotify support");
+}
+
+#endif
diff --git a/testcases/kernel/syscalls/fanotify/fanotify02.c b/testcases/kernel/syscalls/fanotify/fanotify02.c
new file mode 100644
index 000000000000..9e0b0bbd8b6f
--- /dev/null
+++ b/testcases/kernel/syscalls/fanotify/fanotify02.c
@@ -0,0 +1,306 @@
+/*
+ * Copyright (c) 2013 SUSE.  All Rights Reserved.
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
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ * Started by Jan Kara <jack@suse.cz>
+ *
+ * DESCRIPTION
+ *     Check that fanotify work for children of a directory
+ */
+#include "config.h"
+
+#include <stdio.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/fcntl.h>
+#include <errno.h>
+#include <string.h>
+#include <sys/syscall.h>
+#include "test.h"
+#include "usctest.h"
+#include "linux_syscall_numbers.h"
+#include "fanotify.h"
+
+#if defined(HAVE_SYS_FANOTIFY_H)
+#include <sys/fanotify.h>
+
+#define EVENT_MAX 1024
+/* size of the event structure, not counting name */
+#define EVENT_SIZE  (sizeof (struct fanotify_event_metadata))
+/* reasonable guess as to size of 1024 events */
+#define EVENT_BUF_LEN        (EVENT_MAX * EVENT_SIZE)
+
+char *TCID = "fanotify02";
+int TST_TOTAL = 8;
+
+static void setup(void);
+static void cleanup(void);
+
+#define BUF_SIZE 256
+static char fname[BUF_SIZE];
+static char buf[BUF_SIZE];
+static int fd, fd_notify;
+
+static unsigned long long event_set[EVENT_MAX];
+
+static char event_buf[EVENT_BUF_LEN];
+
+int main(int ac, char **av)
+{
+	int lc;
+	char *msg;
+
+	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		int ret, len, i = 0, test_num = 0;
+
+		tst_count = 0;
+
+		if (myfanotify_mark(fd_notify, FAN_MARK_ADD, FAN_ACCESS |
+				    FAN_MODIFY | FAN_CLOSE | FAN_OPEN |
+				    FAN_EVENT_ON_CHILD, AT_FDCWD, ".") < 0) {
+			tst_brkm(TBROK | TERRNO, cleanup,
+			    "fanotify_mark (%d, FAN_MARK_ADD, FAN_ACCESS | "
+			    "FAN_MODIFY | FAN_CLOSE | FAN_OPEN | "
+			    "FAN_EVENT_ON_CHILD, AT_FDCWD, \".\") failed",	
+			    fd_notify);
+		}
+
+		/*
+		 * generate sequence of events
+		 */
+		if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1) {
+			tst_brkm(TBROK | TERRNO, cleanup,
+				 "open(%s, O_RDWR|O_CREAT,0700) failed", fname);
+		}
+		event_set[tst_count] = FAN_OPEN;
+		tst_count++;
+
+		if (write(fd, fname, strlen(fname)) == -1) {
+			tst_brkm(TBROK, cleanup,
+				 "write(%d, %s, %zd) failed", fd, fname,
+				 strlen(fname));
+		}
+		event_set[tst_count] = FAN_MODIFY;
+		tst_count++;
+
+		if (close(fd) == -1) {
+			tst_brkm(TBROK, cleanup, "close(%s) failed", fname);
+		}
+		event_set[tst_count] = FAN_CLOSE_WRITE;
+		tst_count++;
+
+		/*
+		 * Get list of events so far. We get events here to avoid
+		 * merging of following events with the previous ones.
+		 */
+		if ((ret = read(fd_notify, event_buf, EVENT_BUF_LEN)) < 0) {
+			tst_brkm(TBROK, cleanup,
+				 "read(%d, buf, %zu) failed",
+				 fd_notify, EVENT_BUF_LEN);
+
+		}
+		len = ret;
+
+		if ((fd = open(fname, O_RDONLY)) == -1) {
+			tst_brkm(TBROK | TERRNO, cleanup,
+				 "open(%s, O_RDONLY) failed", fname);
+		}
+		event_set[tst_count] = FAN_OPEN;
+		tst_count++;
+
+		if (read(fd, buf, BUF_SIZE) == -1) {
+			tst_brkm(TBROK | TERRNO, cleanup,
+				 "read(%d, buf, %d) failed", fd, BUF_SIZE);
+		}
+		event_set[tst_count] = FAN_ACCESS;
+		tst_count++;
+
+		if (close(fd) == -1) {
+			tst_brkm(TBROK, cleanup, "close(%s) failed", fname);
+		}
+		event_set[tst_count] = FAN_CLOSE_NOWRITE;
+		tst_count++;
+
+		/*
+		 * get next events
+		 */
+		ret = read(fd_notify, event_buf + len, EVENT_BUF_LEN - len);
+		if (ret < 0) {
+			tst_brkm(TBROK, cleanup,
+				 "read(%d, buf, %zu) failed",
+				 fd_notify, EVENT_BUF_LEN);
+
+		}
+		len += ret;
+
+		/*
+		 * now remove child mark
+		 */
+		if (myfanotify_mark(fd_notify, FAN_MARK_REMOVE,
+				    FAN_EVENT_ON_CHILD, AT_FDCWD, ".") < 0) {
+			tst_brkm(TBROK | TERRNO, cleanup,
+			    "fanotify_mark (%d, FAN_MARK REMOVE, "
+			    "FAN_EVENT_ON_CHILD, AT_FDCWD, \".\") failed",
+			    fd_notify);
+		}
+
+		/*
+		 * Do something to verify events didn't get generated
+		 */
+		if ((fd = open(fname, O_RDONLY)) == -1) {
+			tst_brkm(TBROK | TERRNO, cleanup,
+				 "open(%s, O_RDONLY) failed", fname);
+		}
+
+		if (close(fd) == -1) {
+			tst_brkm(TBROK, cleanup, "close(%s) failed", fname);
+		}
+
+		if ((fd = open(".", O_RDONLY | O_DIRECTORY)) == -1) {
+			tst_brkm(TBROK | TERRNO, cleanup,
+				 "open(\".\", O_RDONLY | O_DIRECTORY) failed");
+		}
+		event_set[tst_count] = FAN_OPEN;
+		tst_count++;
+
+		if (close(fd) == -1) {
+			tst_brkm(TBROK, cleanup, "close(\".\") failed");
+		}
+		event_set[tst_count] = FAN_CLOSE_NOWRITE;
+		tst_count++;
+
+		/*
+		 * Check events got generated only for the directory
+		 */
+		ret = read(fd_notify, event_buf + len, EVENT_BUF_LEN - len);
+		if (ret < 0) {
+			tst_brkm(TBROK, cleanup,
+				 "read(%d, buf, %zu) failed",
+				 fd_notify, EVENT_BUF_LEN);
+
+		}
+		len += ret;
+
+		if (TST_TOTAL != tst_count) {
+			tst_brkm(TBROK, cleanup,
+				 "TST_TOTAL and tst_count are not equal");
+		}
+		tst_count = 0;
+
+		/*
+		 * check events
+		 */
+		while (i < len) {
+			struct fanotify_event_metadata *event;
+
+			event = (struct fanotify_event_metadata *)&event_buf[i];
+			if (test_num >= TST_TOTAL) {
+				tst_resm(TFAIL,
+					 "get unnecessary event: mask=%llx "
+					 "pid=%u fd=%u",
+					 (unsigned long long)event->mask,
+					 (unsigned)event->pid, event->fd);
+			} else if (!(event->mask & event_set[test_num])) {
+				tst_resm(TFAIL,
+					 "get event: mask=%llx (expected %llx) "
+					 "pid=%u fd=%u",
+					 (unsigned long long)event->mask,
+					 event_set[test_num],
+					 (unsigned)event->pid, event->fd);
+			} else if (event->pid != getpid()) {
+				tst_resm(TFAIL,
+					 "get event: mask=%llx pid=%u "
+					 "(expected %u) fd=%u",
+					 (unsigned long long)event->mask,
+					 (unsigned)event->pid,
+					 (unsigned)getpid(),
+					 event->fd);
+			} else {
+				tst_resm(TPASS,
+					    "get event: mask=%llx pid=%u fd=%u",
+					    (unsigned long long)event->mask,
+					    (unsigned)event->pid, event->fd);
+			}
+			event->mask &= ~event_set[test_num];
+			/* No events left in current mask? Go for next event */
+			if (event->mask == 0) {
+				i += event->event_len;
+				close(event->fd);
+			}
+			test_num++;
+		}
+		for (; test_num < TST_TOTAL; test_num++) {
+			tst_resm(TFAIL, "didn't get event: mask=%llx",
+				 event_set[test_num]);
+
+		}
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+
+	tst_tmpdir();
+	sprintf(fname, "fname_%d", getpid());
+
+	if ((fd_notify = myfanotify_init(FAN_CLASS_NOTIF, O_RDONLY)) < 0) {
+		if (errno == ENOSYS) {
+			tst_brkm(TCONF, cleanup,
+				 "fanotify is not configured in this kernel.");
+		} else {
+			tst_brkm(TBROK | TERRNO, cleanup,
+				 "fanotify_init failed");
+		}
+	}
+}
+
+static void cleanup(void)
+{
+	if (close(fd_notify) == -1) {
+		tst_resm(TWARN, "close(%d) failed", fd_notify);
+	}
+
+	TEST_CLEANUP;
+	tst_rmdir();
+}
+
+#else
+
+char *TCID = "fanotify02";
+int TST_TOTAL = 0;
+
+int main(void)
+{
+	tst_brkm(TCONF, NULL, "system doesn't have required fanotify support");
+}
+
+#endif
diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
new file mode 100644
index 000000000000..68e57b2e1f88
--- /dev/null
+++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
@@ -0,0 +1,334 @@
+/*
+ * Copyright (c) 2013 SUSE.  All Rights Reserved.
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
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ * Started by Jan Kara <jack@suse.cz>
+ *
+ * DESCRIPTION
+ *     Check that fanotify permission events work
+ */
+#include "config.h"
+
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/fcntl.h>
+#include <sys/wait.h>
+#include <errno.h>
+#include <string.h>
+#include <signal.h>
+#include <sys/syscall.h>
+#include "test.h"
+#include "usctest.h"
+#include "linux_syscall_numbers.h"
+#include "fanotify.h"
+
+#if defined(HAVE_SYS_FANOTIFY_H)
+#include <sys/fanotify.h>
+
+#define EVENT_MAX 1024
+/* size of the event structure, not counting name */
+#define EVENT_SIZE  (sizeof (struct fanotify_event_metadata))
+/* reasonable guess as to size of 1024 events */
+#define EVENT_BUF_LEN        (EVENT_MAX * EVENT_SIZE)
+
+char *TCID = "fanotify03";
+int TST_TOTAL = 3;
+
+static void setup(void);
+static void cleanup(void);
+
+#define BUF_SIZE 256
+static char fname[BUF_SIZE];
+static char buf[BUF_SIZE];
+static int fd_notify, fd_notify_backup;
+
+static pid_t child_pid;
+static int child_ret = -1;
+
+static unsigned long long event_set[EVENT_MAX];
+static unsigned int event_resp[EVENT_MAX];
+
+static char event_buf[EVENT_BUF_LEN];
+
+static void generate_events(void)
+{
+	int fd;
+
+	/*
+	 * generate sequence of events
+	 */
+	if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1)
+		exit(1);
+	if (write(fd, fname, 1) == -1)
+		exit(2);
+
+	lseek(fd, 0, SEEK_SET);
+	if (read(fd, buf, BUF_SIZE) != -1)
+		exit(3);
+
+	if (close(fd) == -1)
+		exit(4);
+}
+
+static void child_handler(int tmp)
+{
+	/*
+	 * Close notification fd so that we cannot block while reading
+	 * from it
+	 */
+	fd_notify_backup = dup(fd_notify);
+	if (fd_notify_backup < 0)
+		tst_brkm(TBROK | TERRNO, cleanup, "dup(%d) failed", fd_notify);
+	close(fd_notify);
+	fd_notify = -1;
+	if (waitpid(-1, &child_ret, 0) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+				 "waitpid(-1, &child_ret, 0) failed");
+	}
+}
+
+static void run_child(void)
+{
+	struct sigaction child_action;
+
+	child_ret = -1;
+
+	child_action.sa_handler = child_handler;
+	sigemptyset(&child_action.sa_mask);
+	child_action.sa_flags = SA_NOCLDSTOP;
+	
+	if (sigaction(SIGCHLD, &child_action, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "sigaction(SIGCHLD, &child_action, NULL) failed");
+	}
+
+	switch (child_pid = fork()) {
+	case 0:
+		/* Child will generate events now */
+		close(fd_notify);
+		generate_events();
+		exit(0);
+	case -1:
+		tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
+	}
+}
+
+static void check_child(void)
+{
+	struct sigaction child_action;
+
+	child_action.sa_handler = SIG_IGN;
+	sigemptyset(&child_action.sa_mask);
+	child_action.sa_flags = SA_NOCLDSTOP;
+	if (sigaction(SIGCHLD, &child_action, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "sigaction(SIGCHLD, &child_action, NULL) failed");
+	}
+	if (child_ret == -1 && waitpid(-1, &child_ret, 0) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+				 "waitpid(-1, &child_ret, 0) failed");
+	}
+
+	if (WIFSIGNALED(child_ret)) {
+		tst_resm(TFAIL, "child exited due to signal %d",
+			 WTERMSIG(child_ret));
+	} else if (WIFEXITED(child_ret)) {
+		if (WEXITSTATUS(child_ret) == 0)
+			tst_resm(TPASS, "child exited correctly");
+		else
+			tst_resm(TFAIL, "child exited with status %d",
+				 WEXITSTATUS(child_ret));
+	} else
+		tst_resm(TFAIL, "child exited for unknown reason (status %d)",
+			 child_ret);
+}
+
+int main(int ac, char **av)
+{
+	int lc;
+	char *msg;
+
+	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		int ret, len = 0, i = 0, test_num = 0;
+
+		run_child();
+
+		tst_count = 0;
+
+		event_set[tst_count] = FAN_OPEN_PERM;
+		event_resp[tst_count++] = FAN_ALLOW;
+		event_set[tst_count] = FAN_ACCESS_PERM;
+		event_resp[tst_count++] = FAN_DENY;
+
+		/* tst_count + 1 is for checking child return value */
+		if (TST_TOTAL != tst_count + 1) {
+			tst_brkm(TBROK, cleanup,
+				 "TST_TOTAL and tst_count do not match");
+		}
+		tst_count = 0;
+
+		/*
+		 * check events
+		 */
+		while (test_num < TST_TOTAL && child_ret == -1) {
+			struct fanotify_event_metadata *event;
+
+			if (i == len) {
+				/* Get more events */
+				ret = read(fd_notify, event_buf + len,
+					   EVENT_BUF_LEN - len);
+				if (child_ret != -1)
+					break;
+				if (ret < 0) {
+					tst_brkm(TBROK, cleanup,
+						 "read(%d, buf, %zu) failed",
+						 fd_notify, EVENT_BUF_LEN);
+				}
+				len += ret;
+			}
+
+			event = (struct fanotify_event_metadata *)&event_buf[i];
+			if (!(event->mask & event_set[test_num])) {
+				tst_resm(TFAIL,
+					 "get event: mask=%llx (expected %llx) "
+					 "pid=%u fd=%u",
+					 (unsigned long long)event->mask,
+					 event_set[test_num],
+					 (unsigned)event->pid, event->fd);
+			} else if (event->pid != child_pid) {
+				tst_resm(TFAIL,
+					 "get event: mask=%llx pid=%u "
+					 "(expected %u) fd=%u",
+					 (unsigned long long)event->mask,
+					 (unsigned)event->pid,
+					 (unsigned)child_pid,
+					 event->fd);
+			} else {
+				tst_resm(TPASS,
+					    "get event: mask=%llx pid=%u fd=%u",
+					    (unsigned long long)event->mask,
+					    (unsigned)event->pid, event->fd);
+			}
+			/* Write response to permission event */
+			if (event_set[test_num] & FAN_ALL_PERM_EVENTS) {
+				struct fanotify_response resp;
+
+				resp.fd = event->fd;
+				resp.response = event_resp[test_num];
+				if (write(fd_notify, &resp, sizeof(resp)) == -1) {
+					tst_brkm(TBROK, cleanup,
+						 "write(%d, resp, %zu) failed",
+						 fd_notify, sizeof(resp));
+				}
+			}
+			event->mask &= ~event_set[test_num];
+			/* No events left in current mask? Go for next event */
+			if (event->mask == 0) {
+				i += event->event_len;
+				close(event->fd);
+			}
+			test_num++;
+		}
+		for (; test_num < TST_TOTAL - 1; test_num++) {
+			tst_resm(TFAIL, "didn't get event: mask=%llx",
+				 event_set[test_num]);
+
+		}
+		check_child();
+		/* We got SIGCHLD while running, resetup fd_notify */
+		if (fd_notify == -1)
+			fd_notify = fd_notify_backup;
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	int fd;
+
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+
+	tst_tmpdir();
+	sprintf(fname, "fname_%d", getpid());
+	if ((fd = open(fname, O_CREAT | O_RDWR, 0644)) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "open(%s, O_CREAT | O_RDWR, 0644) failed", fname);
+	}
+	if (write(fd, fname, 1) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "write(%d, fname, 1) failed", fd);
+	}
+	if (close(fd) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "close(%d) failed", fd);
+	}
+
+	if ((fd_notify = myfanotify_init(FAN_CLASS_CONTENT, O_RDONLY)) < 0) {
+		if (errno == ENOSYS) {
+			tst_brkm(TCONF, cleanup,
+				 "fanotify is not configured in this kernel.");
+		} else {
+			tst_brkm(TBROK | TERRNO, cleanup,
+				 "fanotify_init failed");
+		}
+	}
+
+	if (myfanotify_mark(fd_notify, FAN_MARK_ADD, FAN_ACCESS_PERM |
+			    FAN_OPEN_PERM, AT_FDCWD, fname) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "fanotify_mark (%d, FAN_MARK_ADD, FAN_ACCESS_PERM | "
+			 "FAN_OPEN_PERM, AT_FDCWD, %s) failed", fd_notify, fname);
+	}
+
+}
+
+static void cleanup(void)
+{
+	if (fd_notify != -1 && close(fd_notify) == -1) {
+		tst_resm(TWARN, "close(%d) failed", fd_notify);
+	}
+
+	TEST_CLEANUP;
+	tst_rmdir();
+}
+
+#else
+
+char *TCID = "fanotify03";
+int TST_TOTAL = 0;
+
+int main(void)
+{
+	tst_brkm(TCONF, NULL, "system doesn't have required fanotify support");
+}
+
+#endif
diff --git a/testcases/kernel/syscalls/fanotify/fanotify04.c b/testcases/kernel/syscalls/fanotify/fanotify04.c
new file mode 100644
index 000000000000..aa8219b5cc7c
--- /dev/null
+++ b/testcases/kernel/syscalls/fanotify/fanotify04.c
@@ -0,0 +1,328 @@
+/*
+ * Copyright (c) 2013 SUSE.  All Rights Reserved.
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
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ * Started by Jan Kara <jack@suse.cz>
+ *
+ * DESCRIPTION
+ *     Check various fanotify special flags
+ */
+#include "config.h"
+
+#include <stdio.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/fcntl.h>
+#include <errno.h>
+#include <string.h>
+#include <sys/syscall.h>
+#include "test.h"
+#include "usctest.h"
+#include "linux_syscall_numbers.h"
+#include "fanotify.h"
+
+#if defined(HAVE_SYS_FANOTIFY_H)
+#include <sys/fanotify.h>
+
+#define EVENT_MAX 1024
+/* size of the event structure, not counting name */
+#define EVENT_SIZE  (sizeof (struct fanotify_event_metadata))
+/* reasonable guess as to size of 1024 events */
+#define EVENT_BUF_LEN        (EVENT_MAX * EVENT_SIZE)
+
+char *TCID = "fanotify04";
+int TST_TOTAL = 9;
+
+static void setup(void);
+static void cleanup(void);
+
+#define BUF_SIZE 256
+static char fname[BUF_SIZE];
+static char sname[BUF_SIZE];
+static char dir[BUF_SIZE];
+static int fd_notify;
+
+static int len;
+static char event_buf[EVENT_BUF_LEN];
+
+static char *expect_str_fail(int expect)
+{
+	if (expect == 0)
+		return "failed";
+	return "unexpectedly succeeded";
+}
+
+static char *expect_str_pass(int expect)
+{
+	if (expect == 0)
+		return "succeeded";
+	return "failed";
+}
+
+static void __check_mark(char *file, unsigned long long flag, char *flagstr,
+			 int expect, void (*test_event)(char *))
+{
+	if (myfanotify_mark(fd_notify, FAN_MARK_ADD | flag, FAN_OPEN, AT_FDCWD,
+			    file) != expect) {
+		tst_resm(TFAIL,
+		    "fanotify_mark (%d, FAN_MARK_ADD | %s, FAN_OPEN, AT_FDCWD, "
+		    "\"%s\") %s", fd_notify, flagstr, file, expect_str_fail(expect));
+	} else {
+		tst_resm(TPASS,
+		    "fanotify_mark (%d, FAN_MARK_ADD | %s, FAN_OPEN, AT_FDCWD, "
+		    "\"%s\") %s", fd_notify, flagstr, file, expect_str_pass(expect));
+
+		/* If we expected failure there's nothing to clean up */
+		if (expect == -1)
+			return;
+
+		if (test_event)
+			test_event(file);
+
+		if (myfanotify_mark(fd_notify, FAN_MARK_REMOVE | flag,
+				    FAN_OPEN, AT_FDCWD, file) < 0) {
+			tst_brkm(TBROK | TERRNO, cleanup,
+		    	    "fanotify_mark (%d, FAN_MARK_REMOVE | %s, "
+			    "FAN_OPEN, AT_FDCWD, \"%s\") failed",
+			    fd_notify, flagstr, file);
+		}
+	}
+}
+
+#define check_mark(file, flag, expect, func) __check_mark(file, flag, #flag, expect, func)
+
+static void __do_open(char *file, int flag, char *flagstr)
+{
+	int fd;
+
+	if ((fd = open(file, O_RDONLY | flag)) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+		    "open(%s, O_RDONLY | %s) failed", file, flagstr);
+	}
+	if (close(fd) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+		    "close(%s) failed", file);
+	}
+}
+
+#define do_open(file, flag) __do_open(file, flag, #flag)
+
+static void open_file(char *file)
+{
+	do_open(file, 0);
+}
+
+static void open_dir(char *file)
+{
+	do_open(file, O_DIRECTORY);
+}
+
+static void verify_event(int mask)
+{
+	int ret;
+	struct fanotify_event_metadata *event;
+	struct stat st;
+
+	/* Read the event */
+	ret = read(fd_notify, event_buf + len, EVENT_BUF_LEN - len);
+	if (ret < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup, "read(%d, buf, %zu) failed",
+			 fd_notify, EVENT_BUF_LEN);
+	}
+	event = (struct fanotify_event_metadata *)&event_buf[len];
+	len += ret;
+
+	if (event->mask != FAN_OPEN) {
+		tst_resm(TFAIL, "got unexpected event %llx",
+			 (unsigned long long)event->mask);
+	} else if (fstat(event->fd, &st) < 0) {
+		tst_resm(TFAIL, "failed to stat event->fd (%s)",
+			 strerror(errno));
+	} else if ((st.st_mode & S_IFMT) != mask) {
+		tst_resm(TFAIL, "event->fd points to object of different type "
+			 "(%o != %o)", st.st_mode & S_IFMT, mask);
+	} else {
+		tst_resm(TPASS, "event generated properly for type %o", mask);
+	}
+	close(event->fd);
+}
+
+static void __do_open_test(char *file, int flag, char *flagstr, int mask)
+{
+	__do_open(file, flag, flagstr);
+
+	verify_event(mask);
+}
+
+#define do_open_test(file, flag, mask) __do_open_test(file, flag, #flag, mask)
+
+static void test_open_file(char *file)
+{
+	do_open_test(file, 0, S_IFREG);
+}
+
+static void verify_no_event(void)
+{
+	int ret; 
+
+	ret = read(fd_notify, event_buf + len, EVENT_BUF_LEN - len);
+	if (ret != -1) {
+		struct fanotify_event_metadata *event;
+
+		event = (struct fanotify_event_metadata *)&event_buf[len];
+		tst_resm(TFAIL, "seen unexpected event (mask %llx)",
+			 (unsigned long long)event->mask);
+		/* Cleanup fd from the event */
+		close(event->fd);
+	} else if (errno != EAGAIN) {
+		tst_resm(TFAIL | TERRNO, "read(%d, buf, %zu) failed", fd_notify,
+			 EVENT_BUF_LEN);
+	} else {
+		tst_resm(TPASS, "No event as expected");
+	}
+}
+
+static void test_open_symlink(char *file)
+{
+	/* Since mark is on a symlink, no event should be generated by opening a file */
+	do_open(file, 0);
+	verify_no_event();
+}
+
+int main(int ac, char **av)
+{
+	int lc;
+	char *msg;
+
+	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		/* Check ONLYDIR on a directory */
+		check_mark(".", FAN_MARK_ONLYDIR, 0, NULL);
+
+		/* Check ONLYDIR without a directory */
+		check_mark(fname, FAN_MARK_ONLYDIR, -1, NULL);
+
+		/* Check DONT_FOLLOW for a symlink */
+		check_mark(sname, FAN_MARK_DONT_FOLLOW, 0, test_open_symlink);
+
+		/* Check without DONT_FOLLOW for a symlink */
+		check_mark(sname, 0, 0, test_open_file);
+
+		/* Verify FAN_MARK_FLUSH destroys all inode marks */
+		if (myfanotify_mark(fd_notify, FAN_MARK_ADD,
+		    		    FAN_OPEN, AT_FDCWD, fname) < 0) {
+			tst_brkm(TBROK | TERRNO, cleanup,
+			    "fanotify_mark (%d, FAN_MARK_ADD, FAN_OPEN, "
+			    "AT_FDCWD, \"%s\") failed", fd_notify, fname);
+		}
+		if (myfanotify_mark(fd_notify, FAN_MARK_ADD,
+		    		    FAN_OPEN | FAN_ONDIR, AT_FDCWD, dir) < 0) {
+			tst_brkm(TBROK | TERRNO, cleanup,
+			    "fanotify_mark (%d, FAN_MARK_ADD, FAN_OPEN | "
+			    "FAN_ONDIR, AT_FDCWD, \"%s\") failed", fd_notify,
+			    dir);
+		}
+		open_file(fname);
+		verify_event(S_IFREG);
+		open_dir(dir);
+		verify_event(S_IFDIR);
+		if (myfanotify_mark(fd_notify, FAN_MARK_FLUSH,
+		    		    0, AT_FDCWD, ".") < 0) {
+			tst_brkm(TBROK | TERRNO, cleanup,
+			    "fanotify_mark (%d, FAN_MARK_FLUSH, 0, "
+			    "AT_FDCWD, \".\") failed", fd_notify);
+		}
+
+		open_dir(dir);
+		verify_no_event();
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	int fd;
+
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+
+	tst_tmpdir();
+	sprintf(fname, "fname_%d", getpid());
+	if ((fd = open(fname, O_RDWR | O_CREAT, 0644)) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "open(%s, O_RDWR | O_CREAT, 0644) failed", fname);
+	}
+	if (close(fd) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "close(%d) failed", fd);
+	}
+
+	sprintf(sname, "symlink_%d", getpid());
+	if (symlink(fname, sname) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "symlink(%s, %s) failed", fname, sname);
+	}
+
+	sprintf(dir, "dir_%d", getpid());
+	if (mkdir(dir, 0755) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup, "mkdir(%s) failed", dir);
+	}
+
+	if ((fd_notify = myfanotify_init(FAN_CLASS_NOTIF | FAN_NONBLOCK,
+					 O_RDONLY)) < 0) {
+		if (errno == ENOSYS) {
+			tst_brkm(TCONF, cleanup,
+				 "fanotify is not configured in this kernel.");
+		} else {
+			tst_brkm(TBROK | TERRNO, cleanup,
+				 "fanotify_init failed");
+		}
+	}
+}
+
+static void cleanup(void)
+{
+	if (close(fd_notify) == -1) {
+		tst_resm(TWARN, "close(%d) failed", fd_notify);
+	}
+
+	TEST_CLEANUP;
+	tst_rmdir();
+}
+
+#else
+
+char *TCID = "fanotify04";
+int TST_TOTAL = 0;
+
+int main(void)
+{
+	tst_brkm(TCONF, NULL, "system doesn't have required fanotify support");
+}
+
+#endif
-- 
1.8.1.4


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--pWyiEgJYm5f9v55/--

