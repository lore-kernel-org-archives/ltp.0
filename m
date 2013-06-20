Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Upfbk-0007rE-Oo
	for ltp-list@lists.sourceforge.net; Thu, 20 Jun 2013 14:13:04 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Upfbi-0006O7-Re
	for ltp-list@lists.sourceforge.net; Thu, 20 Jun 2013 14:13:04 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r5KECukC000769
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Jun 2013 10:12:56 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 20 Jun 2013 16:12:47 +0200
Message-Id: <016bca5a3f28e308234e5b1028a831e5fa50fda6.1371736603.git.jstancek@redhat.com>
Subject: [LTP] [PATCH v2] new testcase: kmsg01
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

Test /dev/kmsg based on kernel doc: Documentation/ABI/testing/dev-kmsg
 - read() blocks
 - non-blocking read() fails with EAGAIN
 - partial read fails (buffer smaller than message)
 - can write to /dev/kmsg and message seqno grows
 - first read() after open() returns same message
 - if messages get overwritten, read() returns -EPIPE
 - device supports SEEK_SET, SEEK_END, SEEK_DATA

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---

Changes in v2:
  message prefix changed to "LTP kmsg01 "
  removed unnecessary malloc
  close -> SAFE_CLOSE
  fix comment in single line if
  use ltp_syscall
  handle EPIPE (message overwritten) in all testcases
  add check, that subsequent read after EPIPE returns next valid record

 runtest/kernel_misc                    |    1 +
 testcases/kernel/logging/.gitignore    |    1 +
 testcases/kernel/logging/Makefile      |   22 ++
 testcases/kernel/logging/kmsg/Makefile |   22 ++
 testcases/kernel/logging/kmsg/kmsg01.c |  595 ++++++++++++++++++++++++++++++++
 5 files changed, 641 insertions(+), 0 deletions(-)
 create mode 100644 runtest/kernel_misc
 create mode 100644 testcases/kernel/logging/.gitignore
 create mode 100644 testcases/kernel/logging/Makefile
 create mode 100644 testcases/kernel/logging/kmsg/Makefile
 create mode 100644 testcases/kernel/logging/kmsg/kmsg01.c

diff --git a/runtest/kernel_misc b/runtest/kernel_misc
new file mode 100644
index 0000000..47a667e
--- /dev/null
+++ b/runtest/kernel_misc
@@ -0,0 +1 @@
+kmsg01 kmsg01
diff --git a/testcases/kernel/logging/.gitignore b/testcases/kernel/logging/.gitignore
new file mode 100644
index 0000000..4236df0
--- /dev/null
+++ b/testcases/kernel/logging/.gitignore
@@ -0,0 +1 @@
+/kmsg/kmsg01
diff --git a/testcases/kernel/logging/Makefile b/testcases/kernel/logging/Makefile
new file mode 100644
index 0000000..bd32f70
--- /dev/null
+++ b/testcases/kernel/logging/Makefile
@@ -0,0 +1,22 @@
+#
+#  Copyright (C) 2013 Linux Test Project
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
+top_srcdir		?= ../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/logging/kmsg/Makefile b/testcases/kernel/logging/kmsg/Makefile
new file mode 100644
index 0000000..67b29d6
--- /dev/null
+++ b/testcases/kernel/logging/kmsg/Makefile
@@ -0,0 +1,22 @@
+#
+#  Copyright (C) 2013 Linux Test Project
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
+top_srcdir              ?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/logging/kmsg/kmsg01.c b/testcases/kernel/logging/kmsg/kmsg01.c
new file mode 100644
index 0000000..8d1664f
--- /dev/null
+++ b/testcases/kernel/logging/kmsg/kmsg01.c
@@ -0,0 +1,595 @@
+/*
+ * Copyright (C) 2013 Linux Test Project
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it
+ * is free of the rightful claim of any third person regarding
+ * infringement or the like.  Any license provided herein, whether
+ * implied or otherwise, applies only to this software file.  Patent
+ * licenses, if any, provided herein do not apply to combinations of
+ * this program with other software, or any other product whatsoever.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA.
+ */
+/*
+ * Test /dev/kmsg based on kernel doc: Documentation/ABI/testing/dev-kmsg
+ * - read() blocks
+ * - non-blocking read() fails with EAGAIN
+ * - partial read fails (buffer smaller than message)
+ * - can write to /dev/kmsg and message seqno grows
+ * - first read() after open() returns same message
+ * - if messages get overwritten, read() returns -EPIPE
+ * - device supports SEEK_SET, SEEK_END, SEEK_DATA
+ */
+#define _GNU_SOURCE
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/wait.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include "config.h"
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+#include "linux_syscall_numbers.h"
+
+#define MSG_PREFIX "LTP kmsg01 "
+#define MAX_MSGSIZE 4096
+#define NUM_READ_MSGS 3
+#define NUM_READ_RETRY 10
+#define NUM_OVERWRITE_MSGS 1024
+#define READ_TIMEOUT 5
+
+char *TCID = "kmsg01";
+static void setup(void);
+static void cleanup(void);
+
+/*
+ * inject_msg - write message to /dev/kmsg
+ * @msg: null-terminated message to inject, should end with \n
+ *
+ * RETURNS:
+ *   0 on success
+ *  -1 on failure, errno reflects write() errno
+ */
+static int inject_msg(const char *msg)
+{
+	int f;
+	f = open("/dev/kmsg", O_WRONLY);
+	if (f < 0)
+		tst_brkm(TBROK | TERRNO, cleanup, "failed to open /dev/kmsg");
+	TEST(write(f, msg, strlen(msg)));
+	SAFE_CLOSE(cleanup, f);
+	errno = TEST_ERRNO;
+	return TEST_RETURN;
+}
+
+/*
+ * find_msg - find message in kernel ring buffer
+ * @fd:           fd to use, if < 0 function opens /dev/kmsg itself
+ * @text_to_find: substring to look for in messages
+ * @buf:          buf to store found message
+ * @bufsize:      size of 'buf'
+ * @first:        1 - return first matching message
+ *                0 - return last matching message
+ * RETURNS:
+ *   0 on success
+ *  -1 on failure
+ */
+static int find_msg(int fd, const char *text_to_find, char *buf, int bufsize,
+	int first)
+{
+	int f, msg_found = 0;
+	char msg[MAX_MSGSIZE + 1];
+
+	if (fd < 0) {
+		f = open("/dev/kmsg", O_RDONLY | O_NONBLOCK);
+		if (f < 0)
+			tst_brkm(TBROK, cleanup, "failed to open /dev/kmsg");
+	} else {
+		f = fd;
+	}
+
+	while (1) {
+		TEST(read(f, msg, sizeof(msg)));
+		if (TEST_RETURN < 0) {
+			if (TEST_ERRNO == EAGAIN)
+				/* there are no more messages */
+				break;
+			else if (TEST_ERRNO == EPIPE)
+				/* current message was overwritten */
+				continue;
+			else
+				tst_brkm(TBROK|TTERRNO, cleanup,
+					"failed to read /dev/kmsg");
+		} else if (TEST_RETURN < bufsize) {
+			/* lines from kmsg are not NULL terminated */
+			msg[TEST_RETURN] = '\0';
+			if (strstr(msg, text_to_find) != NULL) {
+				strncpy(buf, msg, bufsize);
+				msg_found = 1;
+				if (first)
+					break;
+			}
+		}
+	}
+	if (fd < 0)
+		SAFE_CLOSE(cleanup, f);
+
+	if (msg_found)
+		return 0;
+	else
+		return -1;
+}
+
+static int get_msg_fields(const char *msg, unsigned long *prio,
+	unsigned long *seqno)
+{
+	unsigned long s, p;
+	if (sscanf(msg, "%lu,%lu,", &p, &s) == 2) {
+		if (prio)
+			*prio = p;
+		if (seqno)
+			*seqno = s;
+		return 0;
+	} else {
+		return 1;
+	}
+}
+
+/*
+ * timed_read - if possible reads from fd or times out
+ * @fd:           fd to read from
+ * @timeout_sec:  timeout in seconds
+ *
+ * RETURNS:
+ *   read bytes on successful read
+ *  -1 on read() error, errno reflects read() errno
+ *  -2 on timeout
+ */
+static int timed_read(int fd, int timeout_sec)
+{
+	int ret, tmp;
+	struct timeval timeout;
+	fd_set read_fds;
+
+	FD_ZERO(&read_fds);
+	FD_SET(fd, &read_fds);
+	timeout.tv_sec = timeout_sec;
+	timeout.tv_usec = 0;
+
+	ret = select(fd + 1, &read_fds, 0, 0, &timeout);
+	switch (ret) {
+	case -1:
+		tst_brkm(TBROK|TERRNO, cleanup, "select failed");
+	case 0:
+		/* select timed out */
+		return -2;
+	}
+
+	return read(fd, &tmp, 1);
+}
+
+/*
+ * timed_read_kmsg - reads file until it reaches end of file,
+ *                   read fails or times out. This ignores any
+ *                   EPIPE errors.
+ * @fd:           fd to read from
+ * @timeout_sec:  timeout in seconds for every read attempt
+ *
+ * RETURNS:
+ *     0 on read reaching eof
+ *    -1 on read error, errno reflects read() errno
+ *    -2 on timeout
+ */
+static int timed_read_kmsg(int fd, int timeout_sec)
+{
+	int child, status, ret = 0;
+	int pipefd[2];
+	char msg[MAX_MSGSIZE];
+
+	if (pipe(pipefd) != 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "pipe failed");
+
+	child = fork();
+	switch (child) {
+	case -1:
+		tst_brkm(TBROK|TERRNO, cleanup, "failed to fork");
+	case 0:
+		/* child does all the reading and keeps writing to
+		 * pipe to let parent know that it didn't block */
+		SAFE_CLOSE(NULL, pipefd[0]);
+		while (1) {
+			write(pipefd[1], "", 1);
+			TEST(read(fd, msg, MAX_MSGSIZE));
+			if (TEST_RETURN == 0)
+				break;
+			if (TEST_RETURN == -1 && TEST_ERRNO != EPIPE) {
+				ret = TEST_ERRNO;
+				break;
+			}
+		}
+
+		SAFE_CLOSE(NULL, pipefd[1]);
+		exit(ret);
+	}
+	SAFE_CLOSE(cleanup, pipefd[1]);
+
+	/* parent reads pipe until it reaches eof or until read times out */
+	do {
+		TEST(timed_read(pipefd[0], timeout_sec));
+	} while (TEST_RETURN > 0);
+	SAFE_CLOSE(cleanup, pipefd[0]);
+
+	/* child is blocked, kill it */
+	if (TEST_RETURN == -2)
+		kill(child, SIGTERM);
+	if (waitpid(child, &status, 0) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
+	if (WIFEXITED(status)) {
+		if (WEXITSTATUS(status) == 0) {
+			return 0;
+		} else {
+			errno = WEXITSTATUS(status);
+			return -1;
+		}
+	}
+	return -2;
+}
+
+static void test_read_nonblock(void)
+{
+	int fd;
+
+	tst_resm(TINFO, "TEST: nonblock read");
+	fd = open("/dev/kmsg", O_RDONLY | O_NONBLOCK);
+	if (fd < 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "failed to open /dev/kmsg");
+
+	TEST(timed_read_kmsg(fd, READ_TIMEOUT));
+	if (TEST_RETURN == -1 && TEST_ERRNO == EAGAIN)
+		tst_resm(TPASS, "non-block read returned EAGAIN");
+	else
+		tst_resm(TFAIL|TTERRNO, "non-block read returned: %ld",
+			TEST_RETURN);
+	SAFE_CLOSE(cleanup, fd);
+}
+
+static void test_read_block(void)
+{
+	int fd;
+
+	tst_resm(TINFO, "TEST: blocking read");
+	fd = open("/dev/kmsg", O_RDONLY);
+	if (fd < 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "failed to open /dev/kmsg");
+
+	TEST(timed_read_kmsg(fd, READ_TIMEOUT));
+	if (TEST_RETURN == -2)
+		tst_resm(TPASS, "read blocked");
+	else
+		tst_resm(TFAIL|TTERRNO, "read returned: %ld", TEST_RETURN);
+	SAFE_CLOSE(cleanup, fd);
+}
+
+static void test_partial_read(void)
+{
+	char msg[MAX_MSGSIZE];
+	int fd;
+
+	tst_resm(TINFO, "TEST: partial read");
+	fd = open("/dev/kmsg", O_RDONLY | O_NONBLOCK);
+	if (fd < 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "failed to open /dev/kmsg");
+
+	TEST(read(fd, msg, 1));
+	if (TEST_RETURN < 0)
+		tst_resm(TPASS|TTERRNO, "read failed as expected");
+	else
+		tst_resm(TFAIL, "read returned: %ld", TEST_RETURN);
+	SAFE_CLOSE(cleanup, fd);
+}
+
+static void test_inject(void)
+{
+	char imsg[MAX_MSGSIZE], imsg_prefixed[MAX_MSGSIZE];
+	char tmp[MAX_MSGSIZE];
+	unsigned long prefix, seqno, seqno_last = 0;
+	int i, facility, prio;
+
+	tst_resm(TINFO, "TEST: injected messages appear in /dev/kmsg");
+
+	/* test all combinations of prio 0-7, facility 0-15 */
+	for (i = 0; i < 127; i++) {
+		prio = (i & 7);
+		facility = (i >> 3);
+		sprintf(imsg, MSG_PREFIX"TEST MESSAGE %ld prio: %d, "
+			"facility: %d\n", random(), prio, facility);
+		sprintf(imsg_prefixed, "<%d>%s", i, imsg);
+
+		if (inject_msg(imsg_prefixed) == -1) {
+			tst_resm(TFAIL|TERRNO, "inject failed");
+			return;
+		}
+
+		/* check that message appears in log */
+		if (find_msg(-1, imsg, tmp, sizeof(tmp), 0) == -1) {
+			tst_resm(TFAIL, "failed to find: %s", imsg);
+			return;
+		}
+
+		/* check that facility is not 0 (LOG_KERN). */
+		if (get_msg_fields(tmp, &prefix, &seqno) != 0) {
+			tst_resm(TFAIL, "failed to parse seqid: %s", tmp);
+			return;
+		}
+		if (prefix >> 3 == 0) {
+			tst_resm(TFAIL, "facility 0 found: %s", tmp);
+			return;
+		}
+
+		/* check that seq. number grows */
+		if (seqno > seqno_last) {
+			seqno_last = seqno;
+		} else {
+			tst_resm(TFAIL, "seqno doesn't grow: %lu, "
+				"last: %lu", seqno, seqno_last);
+			return;
+		}
+	}
+
+	tst_resm(TPASS, "injected messages found in log");
+	tst_resm(TPASS, "sequence numbers grow as expected");
+}
+
+static void test_read_returns_first_message(void)
+{
+	unsigned long seqno[NUM_READ_MSGS + 1];
+	char msg[MAX_MSGSIZE];
+	int msgs_match = 1;
+	int i, fd, j = NUM_READ_RETRY;
+
+	/* Open extra fd, which we try to read after reading NUM_READ_MSGS.
+	 * If this read fails with EPIPE, first message was overwritten and
+	 * we should retry the whole test. If it still fails after
+	 * NUM_READ_RETRY attempts, report TWARN */
+	tst_resm(TINFO, "TEST: mult. readers will get same first message");
+	while (j) {
+		fd = open("/dev/kmsg", O_RDONLY | O_NONBLOCK);
+		if (fd < 0)
+			tst_brkm(TBROK|TERRNO, cleanup,
+				"failed to open /dev/kmsg");
+
+		for (i = 0; i < NUM_READ_MSGS; i++) {
+			if (find_msg(-1, "", msg, sizeof(msg), 1) != 0)
+				tst_resm(TFAIL, "failed to find any message");
+			if (get_msg_fields(msg, NULL, &seqno[i]) != 0)
+				tst_resm(TFAIL, "failed to parse seqid: %s",
+					msg);
+		}
+
+		TEST(read(fd, msg, sizeof(msg)));
+		SAFE_CLOSE(cleanup, fd);
+		if (TEST_RETURN != -1)
+			break;
+
+		if (TEST_ERRNO == EPIPE)
+			tst_resm(TINFO, "msg overwritten, retrying");
+		else
+			tst_resm(TFAIL|TTERRNO, "read failed");
+
+		/* give a second to whoever overwrote first message to finish */
+		sleep(1);
+		j--;
+	}
+
+	if (!j) {
+		tst_resm(TWARN, "exceeded: %d attempts", NUM_READ_RETRY);
+		return;
+	}
+
+	for (i = 0; i < NUM_READ_MSGS - 1; i++)
+		if (seqno[i] != seqno[i + 1])
+			msgs_match = 0;
+	if (msgs_match) {
+		tst_resm(TPASS, "all readers got same message on first read");
+	} else {
+		tst_resm(TFAIL, "readers got different messages");
+		for (i = 0; i < NUM_READ_MSGS; i++)
+			tst_resm(TINFO, "msg%d: %lu\n", i, seqno[i]);
+	}
+}
+
+static void test_messages_overwritten(void)
+{
+	int i, fd;
+	char msg[MAX_MSGSIZE];
+	unsigned long first_seqno, seqno;
+	char filler_str[] = MSG_PREFIX"FILLER MESSAGE TO OVERWRITE OTHERS\n";
+
+	/* Keep injecting messages until we overwrite first one.
+	 * We know first message is overwritten when its seqno changes */
+	tst_resm(TINFO, "TEST: read returns EPIPE when messages get "
+		"overwritten");
+	fd = open("/dev/kmsg", O_RDONLY | O_NONBLOCK);
+	if (fd < 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "failed to open /dev/kmsg");
+
+	if (find_msg(-1, "", msg, sizeof(msg), 1) == 0
+		&& get_msg_fields(msg, NULL, &first_seqno) == 0) {
+		tst_resm(TINFO, "first seqno: %lu", first_seqno);
+	} else {
+		tst_brkm(TBROK, cleanup, "failed to get first seq. number");
+	}
+
+	while (1) {
+		if (find_msg(-1, "", msg, sizeof(msg), 1) != 0
+				|| get_msg_fields(msg, NULL, &seqno) != 0) {
+			tst_resm(TFAIL, "failed to get first seq. number");
+			break;
+		}
+		if (first_seqno != seqno) {
+			/* first message was overwritten */
+			tst_resm(TINFO, "first seqno now: %lu", seqno);
+			break;
+		}
+		for (i = 0; i < NUM_OVERWRITE_MSGS; i++) {
+			if (inject_msg(filler_str) == -1)
+				tst_brkm(TBROK|TERRNO, cleanup,
+					"failed write to /dev/kmsg");
+		}
+	}
+
+	/* first message is overwritten, so this next read should fail */
+	TEST(read(fd, msg, sizeof(msg)));
+	if (TEST_RETURN == -1 && TEST_ERRNO == EPIPE)
+		tst_resm(TPASS, "read failed with EPIPE as expected");
+	else
+		tst_resm(TFAIL|TTERRNO, "read returned: %ld", TEST_RETURN);
+
+	/* seek position is updated to the next available record */
+	tst_resm(TINFO, "TEST: Subsequent reads() will return available "
+		"records again");
+	if (find_msg(fd, "", msg, sizeof(msg), 1) != 0)
+		tst_resm(TFAIL|TTERRNO, "read returned: %ld", TEST_RETURN);
+	else
+		tst_resm(TPASS, "after EPIPE read returned next record");
+
+	SAFE_CLOSE(cleanup, fd);
+}
+
+static void test_seek(void)
+{
+	int k, j = NUM_READ_RETRY, fd;
+	char msg[MAX_MSGSIZE];
+	unsigned long seqno[2];
+
+	/* 1. read() after SEEK_SET 0 returns same (first) message */
+	tst_resm(TINFO, "TEST: seek SEEK_SET 0");
+
+	fd = open("/dev/kmsg", O_RDONLY | O_NONBLOCK);
+	if (fd < 0)
+		tst_brkm(TBROK|TERRNO, cleanup,	"failed to open /dev/kmsg");
+
+	while (j) {
+		for (k = 0; k < 2; k++) {
+			TEST(read(fd, msg, sizeof(msg)));
+			if (TEST_RETURN == -1) {
+				if (errno == EPIPE)
+					break;
+				else
+					tst_brkm(TBROK|TTERRNO, cleanup,
+						"failed to read /dev/kmsg");
+			}
+			if (get_msg_fields(msg, NULL, &seqno[k]) != 0)
+				tst_resm(TFAIL, "failed to parse seqid: %s",
+					msg);
+			if (k == 0)
+				if (lseek(fd, 0, SEEK_SET) == -1)
+					tst_resm(TFAIL|TERRNO,
+						"SEEK_SET 0 failed");
+		}
+
+		if (TEST_RETURN != -1)
+			break;
+
+		/* give a second to whoever overwrote first message to finish */
+		sleep(1);
+		j--;
+
+		/* read returned EPIPE, reopen fd and try again */
+		SAFE_CLOSE(cleanup, fd);
+		fd = open("/dev/kmsg", O_RDONLY | O_NONBLOCK);
+		if (fd < 0)
+			tst_brkm(TBROK|TERRNO, cleanup,
+				"failed to open /dev/kmsg");
+	}
+
+	if (!j) {
+		tst_resm(TWARN, "exceeded: %d attempts", NUM_READ_RETRY);
+	} else {
+		if (seqno[0] != seqno[1])
+			tst_resm(TFAIL, "SEEK_SET 0");
+		else
+			tst_resm(TPASS, "SEEK_SET 0");
+	}
+
+	/* 2. messages after SEEK_END 0 shouldn't contain MSG_PREFIX */
+	tst_resm(TINFO, "TEST: seek SEEK_END 0");
+	if (lseek(fd, 0, SEEK_END) == -1)
+		tst_resm(TFAIL|TERRNO, "lseek SEEK_END 0 failed");
+	if (find_msg(fd, MSG_PREFIX, msg, sizeof(msg), 0) != 0)
+		tst_resm(TPASS, "SEEK_END 0");
+	else
+		tst_resm(TFAIL, "SEEK_END 0 found: %s", msg);
+
+#ifdef SEEK_DATA
+	/* 3. messages after SEEK_DATA 0 shouldn't contain MSG_PREFIX */
+	tst_resm(TINFO, "TEST: seek SEEK_DATA 0");
+
+	/* clear ring buffer */
+	if (ltp_syscall(__NR_syslog, 5, NULL, 0) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "syslog clear failed");
+	if (lseek(fd, 0, SEEK_DATA) == -1)
+		tst_resm(TFAIL|TERRNO, "lseek SEEK_DATA 0 failed");
+	if (find_msg(fd, MSG_PREFIX, msg, sizeof(msg), 0) != 0)
+		tst_resm(TPASS, "SEEK_DATA 0");
+	else
+		tst_resm(TFAIL, "SEEK_DATA 0 found: %s", msg);
+#endif
+	SAFE_CLOSE(cleanup, fd);
+}
+
+int main(int argc, char *argv[])
+{
+	int lc;
+	char *msg;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		/* run test_inject first so log isn't empty for other tests */
+		test_inject();
+		test_read_nonblock();
+		test_read_block();
+		test_partial_read();
+		test_read_returns_first_message();
+		test_messages_overwritten();
+		test_seek();
+	}
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	tst_require_root(NULL);
+	if (tst_kvercmp(3, 5, 0) < 0)
+		tst_brkm(TCONF, NULL, "This test requires kernel"
+			" >= 3.5.0");
+	srand(getpid());
+	TEST_PAUSE;
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+}
-- 
1.7.1


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
