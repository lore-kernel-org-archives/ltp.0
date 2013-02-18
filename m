Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1U7RLi-0007GR-5x
	for ltp-list@lists.sourceforge.net; Mon, 18 Feb 2013 14:05:42 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1U7RLf-0006CB-UG
	for ltp-list@lists.sourceforge.net; Mon, 18 Feb 2013 14:05:42 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r1IE5Y9C029821
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 18 Feb 2013 09:05:34 -0500
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 18 Feb 2013 15:05:16 +0100
Message-Id: <a5da91845477cb0ddbd59d37eb328175dac90698.1361196214.git.jstancek@redhat.com>
In-Reply-To: <cover.1361196214.git.jstancek@redhat.com>
References: <cover.1361196214.git.jstancek@redhat.com>
Subject: [LTP] [PATCH v3 2/3] setns: add new syscall test setns01
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

errno tests for setns(2) - reassociate thread with a namespace

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 runtest/syscalls                          |    2 +
 testcases/kernel/syscalls/.gitignore      |    1 +
 testcases/kernel/syscalls/setns/setns.h   |   88 +++++++++++
 testcases/kernel/syscalls/setns/setns01.c |  240 +++++++++++++++++++++++++++++
 4 files changed, 331 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/setns/setns.h
 create mode 100644 testcases/kernel/syscalls/setns/setns01.c

diff --git a/runtest/syscalls b/runtest/syscalls
index db5a075..a881479 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -962,6 +962,8 @@ setitimer01 setitimer01
 setitimer02 setitimer02
 setitimer03 setitimer03
 
+setns01 setns01
+
 setpgid01 setpgid01
 setpgid02 setpgid02
 setpgid03 setpgid03
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index d661159..4b8bb94 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -764,6 +764,7 @@
 /setitimer/setitimer01
 /setitimer/setitimer02
 /setitimer/setitimer03
+/setns/setns01
 /setpgid/setpgid01
 /setpgid/setpgid02
 /setpgid/setpgid03
diff --git a/testcases/kernel/syscalls/setns/setns.h b/testcases/kernel/syscalls/setns/setns.h
new file mode 100644
index 0000000..23bdb2e
--- /dev/null
+++ b/testcases/kernel/syscalls/setns/setns.h
@@ -0,0 +1,88 @@
+/*
+ * Copyright (C) 2013 Linux Test Project, Inc.
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
+
+#define NS_MAX 5
+static int ns_types[NS_MAX];
+static int ns_fds[NS_MAX];
+static int ns_total;
+
+static int get_ns_fd(int pid, const char *ns)
+{
+	char tmp[PATH_MAX];
+	struct stat st;
+	int fd = -1;
+
+	sprintf(tmp, "/proc/%d/ns/%s", pid, ns);
+	if (stat(tmp, &st) == 0) {
+		fd = open(tmp, O_RDONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, NULL, "failed to open %s", tmp);
+	} else {
+		if (errno != ENOENT)
+			tst_brkm(TBROK|TERRNO, NULL, "failed to stat %s", tmp);
+	}
+	return fd;
+}
+
+static void init_ns_type(int clone_type, const char *proc_name)
+{
+	int fd;
+
+	fd = get_ns_fd(getpid(), proc_name);
+	if (fd != -1) {
+		ns_types[ns_total] = clone_type;
+		ns_fds[ns_total] = fd;
+		tst_resm(TINFO, "ns_fds[%d]=%d, ns_types[%d]=0x%x", ns_total,
+			fd, ns_total, clone_type);
+		ns_total++;
+	}
+}
+
+static void init_available_ns(void)
+{
+#if defined(CLONE_NEWIPC)
+	init_ns_type(CLONE_NEWIPC, "ipc");
+#endif
+#if defined(CLONE_NEWNS)
+	init_ns_type(CLONE_NEWNS, "mnt");
+#endif
+#if defined(CLONE_NEWNET)
+	init_ns_type(CLONE_NEWNET, "net");
+#endif
+#if defined(CLONE_NEWPID)
+	init_ns_type(CLONE_NEWPID, "pid");
+#endif
+#if defined(CLONE_NEWUTS)
+	init_ns_type(CLONE_NEWUTS, "uts");
+#endif
+}
+
+static void close_ns_fds(void)
+{
+	int i;
+
+	for (i = 0; i < ns_total; i++)
+		if (ns_fds[i] != -1)
+			close(ns_fds[i]);
+}
diff --git a/testcases/kernel/syscalls/setns/setns01.c b/testcases/kernel/syscalls/setns/setns01.c
new file mode 100644
index 0000000..710ce9b
--- /dev/null
+++ b/testcases/kernel/syscalls/setns/setns01.c
@@ -0,0 +1,240 @@
+/*
+ * Copyright (C) 2013 Linux Test Project, Inc.
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
+ * errno tests for setns(2) - reassociate thread with a namespace
+ */
+#define _GNU_SOURCE
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <errno.h>
+#include <sched.h>
+#include <pwd.h>
+#include <string.h>
+#include "config.h"
+#include "test.h"
+#include "usctest.h"
+#include "linux_syscall_numbers.h"
+#include "safe_macros.h"
+
+char *TCID = "setns01";
+
+#if defined(__NR_setns)
+#include "setns.h"
+
+struct testcase_t {
+	const char *msg;
+	int fd;
+	int ns_type;
+	int exp_ret;
+	int exp_errno;
+	int skip;
+	void (*setup) (struct testcase_t *, int i);
+	void (*cleanup) (struct testcase_t *);
+};
+
+static void setup(void);
+static void cleanup(void);
+static void setup0(struct testcase_t *, int);
+static void setup1(struct testcase_t *, int);
+static void setup2(struct testcase_t *, int);
+static void setup3(struct testcase_t *, int);
+static void setup4(struct testcase_t *, int);
+static void cleanup1(struct testcase_t *);
+static void cleanup4(struct testcase_t *);
+
+struct testcase_t tdat[] = {
+	{
+		.msg = "invalid fd",
+		.fd = -1,
+		.exp_ret = -1,
+		.exp_errno = EBADF,
+		.setup = setup0,
+	},
+	{
+		.msg = "regular file fd",
+		.exp_ret = -1,
+		.exp_errno = EINVAL,
+		.setup = setup1,
+		.cleanup = cleanup1
+	},
+	{
+		.msg = "invalid ns_type",
+		.ns_type = -1,
+		.exp_ret = -1,
+		.exp_errno = EINVAL,
+		.setup = setup2,
+	},
+	{
+		.msg = "mismatch ns_type/fd",
+		.exp_ret = -1,
+		.exp_errno = EINVAL,
+		.setup = setup3,
+	},
+	{
+		.msg = "without CAP_SYS_ADMIN",
+		.exp_ret = -1,
+		.exp_errno = EPERM,
+		.setup = setup4,
+		.cleanup = cleanup4,
+	}
+};
+
+static int TST_TOTAL = sizeof(tdat) / sizeof(tdat[0]);
+static const char nobody_uid[] = "nobody";
+static struct passwd *ltpuser;
+
+static void setup0(struct testcase_t *t, int i)
+{
+	t->ns_type = ns_types[i];
+}
+
+static void setup1(struct testcase_t *t, int i)
+{
+	t->ns_type = ns_types[i];
+	t->fd = open("dummy", O_CREAT);
+	if (t->fd == -1)
+		tst_brkm(TFAIL|TERRNO, cleanup, "setup1:open failed");
+	unlink("dummy");
+}
+
+static void cleanup1(struct testcase_t *t)
+{
+	close(t->fd);
+}
+
+static void setup2(struct testcase_t *t, int i)
+{
+	t->fd = ns_fds[i];
+}
+
+static void setup3(struct testcase_t *t, int i)
+{
+	if (ns_total < 2) {
+		t->skip = 1;
+		return;
+	}
+
+	t->fd = ns_fds[i];
+	t->ns_type = ns_types[(i+1) % ns_total];
+}
+
+static void setup4(struct testcase_t *t, int i)
+{
+	if (seteuid(ltpuser->pw_uid) == -1)
+		tst_brkm(TBROK | TERRNO, NULL, "seteuid failed");
+
+	t->fd = ns_fds[i];
+	t->ns_type = ns_types[i];
+}
+
+static void cleanup4(struct testcase_t *t)
+{
+	if (seteuid(0) == -1)
+		tst_brkm(TBROK | TERRNO, NULL, "seteuid restore failed");
+}
+
+static void test_setns(struct testcase_t *t)
+{
+	int ret, i;
+
+	for (i = 0; i < ns_total; i++) {
+		if (t->setup)
+			t->setup(t, i);
+
+		if (t->skip) {
+			tst_resm(TINFO, "skip %s", tdat->msg);
+			continue;
+		}
+
+		tst_resm(TINFO, "setns(%d, 0x%x)", t->fd, t->ns_type);
+		ret = syscall(__NR_setns, t->fd, t->ns_type);
+		if (ret == t->exp_ret) {
+			if (ret == -1 && errno == t->exp_errno)
+				tst_resm(TPASS, "%s exp_errno=%d", t->msg,
+						t->exp_errno);
+			else
+				tst_resm(TFAIL|TERRNO, "%s exp_errno=%d",
+					t->msg, t->exp_errno);
+		} else {
+			tst_resm(TFAIL, "%s ret=%d expected=%d", t->msg,
+					ret, t->exp_ret);
+		}
+
+		if (t->cleanup)
+			t->cleanup(t);
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	int lc, testno;
+	char *msg;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		for (testno = 0; testno < TST_TOTAL; testno++)
+			test_setns(&tdat[testno]);
+	}
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	tst_require_root(NULL);
+
+	/* runtime check if syscall is supported */
+	ltp_syscall(__NR_setns, -1, 0);
+
+	init_available_ns();
+	if (ns_total == 0)
+		tst_brkm(TCONF, NULL, "no ns types/proc entries");
+
+	ltpuser = getpwnam(nobody_uid);
+	if (ltpuser == NULL)
+		tst_brkm(TBROK | TERRNO, NULL, "getpwnam failed");
+
+
+	tst_tmpdir();
+	TEST_PAUSE;
+}
+
+static void cleanup(void)
+{
+	close_ns_fds();
+	tst_rmdir();
+	TEST_CLEANUP;
+}
+#else
+int main(int argc, char *argv[])
+{
+	tst_brkm(TCONF, NULL, "__NR_setns is not defined on your system.");
+
+}
+#endif
-- 
1.7.1


------------------------------------------------------------------------------
The Go Parallel Website, sponsored by Intel - in partnership with Geeknet, 
is your hub for all things parallel software development, from weekly thought 
leadership blogs to news, videos, case studies, tutorials, tech docs, 
whitepapers, evaluation guides, and opinion stories. Check out the most 
recent posts - join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
