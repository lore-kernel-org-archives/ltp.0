Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1U2ku9-0000Uj-Ji
	for ltp-list@lists.sourceforge.net; Tue, 05 Feb 2013 15:57:53 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1U2ku8-0008L2-Ee
	for ltp-list@lists.sourceforge.net; Tue, 05 Feb 2013 15:57:53 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r15FvkIY031591
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 5 Feb 2013 10:57:46 -0500
From: Jan Stancek <jstancek@redhat.com>
Date: Tue,  5 Feb 2013 16:57:30 +0100
Message-Id: <4452e231891155599a67963415d3828e20947f54.1360079418.git.jstancek@redhat.com>
In-Reply-To: <cover.1360079418.git.jstancek@redhat.com>
References: <cover.1360079418.git.jstancek@redhat.com>
Subject: [LTP] [PATCH 2/3] setns: add new syscall test setns01
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
 testcases/kernel/syscalls/setns/setns.h   |   41 +++++
 testcases/kernel/syscalls/setns/setns01.c |  245 +++++++++++++++++++++++++++++
 4 files changed, 289 insertions(+), 0 deletions(-)
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
index 003c5d0..d3bf8b7 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -763,6 +763,7 @@
 /setitimer/setitimer01
 /setitimer/setitimer02
 /setitimer/setitimer03
+/setns/setns01
 /setpgid/setpgid01
 /setpgid/setpgid02
 /setpgid/setpgid03
diff --git a/testcases/kernel/syscalls/setns/setns.h b/testcases/kernel/syscalls/setns/setns.h
new file mode 100644
index 0000000..1613e6c
--- /dev/null
+++ b/testcases/kernel/syscalls/setns/setns.h
@@ -0,0 +1,41 @@
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
+static int get_ns_fd(int pid, const char *ns)
+{
+	char tmp[PATH_MAX];
+	struct stat st;
+	int fd = -1;
+
+	sprintf(tmp, "/proc/%d/%s", pid, ns);
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
diff --git a/testcases/kernel/syscalls/setns/setns01.c b/testcases/kernel/syscalls/setns/setns01.c
new file mode 100644
index 0000000..6469266
--- /dev/null
+++ b/testcases/kernel/syscalls/setns/setns01.c
@@ -0,0 +1,245 @@
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
+#define NS_TOTAL 3
+char *TCID = "setns01";
+
+#if defined(__NR_setns) && defined(CLONE_NEWIPC) && defined(CLONE_NEWUTS) \
+	&& defined(CLONE_NEWNET)
+#include "setns.h"
+
+struct testcase_t {
+	const char *msg;
+	int fd;
+	int ns_type;
+	int exp_ret;
+	int exp_errno;
+	int skip;
+	void (*setup) (struct testcase_t *);
+	void (*cleanup) (struct testcase_t *);
+};
+
+static void setup(void);
+static void cleanup(void);
+static void setup1(struct testcase_t *);
+static void setup2(struct testcase_t *);
+static void setup3(struct testcase_t *);
+static void setup4(struct testcase_t *);
+static void cleanup1(struct testcase_t *);
+static void cleanup4(struct testcase_t *);
+
+struct testcase_t tdat[] = {
+	{
+		.msg = "invalid fd",
+		.fd = -1,
+		.ns_type = CLONE_NEWIPC,
+		.exp_ret = -1,
+		.exp_errno = EBADF,
+	},
+	{
+		.msg = "regular file fd",
+		.ns_type = CLONE_NEWIPC,
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
+static const char *ns_names[NS_TOTAL] = {"ns/ipc", "ns/net", "ns/uts"};
+static int ns_types[NS_TOTAL] = { CLONE_NEWIPC, CLONE_NEWNET, CLONE_NEWUTS };
+static int ns_fds[NS_TOTAL];
+static int TST_TOTAL = sizeof(tdat) / sizeof(tdat[0]);
+static const char nobody_uid[] = "nobody";
+static struct passwd *ltpuser;
+
+static void setup1(struct testcase_t *t)
+{
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
+static void setup2(struct testcase_t *t)
+{
+	int i;
+	for (i = 0; i < NS_TOTAL; i++)
+		if (ns_fds[i] != -1) {
+			t->fd = ns_fds[i];
+			return;
+		}
+	t->skip = 1;
+}
+
+static void setup3(struct testcase_t *t)
+{
+	int i;
+	for (i = 0; i < NS_TOTAL; i++)
+		if (ns_fds[i] != -1) {
+			t->fd = ns_fds[i];
+			t->ns_type = ns_types[(i+1) % NS_TOTAL];
+			return;
+		}
+	t->skip = 1;
+}
+
+static void setup4(struct testcase_t *t)
+{
+	if (seteuid(ltpuser->pw_uid) == -1)
+		tst_brkm(TBROK | TERRNO, NULL, "seteuid failed");
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
+	int ret;
+
+	if (t->setup)
+		t->setup(t);
+
+	if (t->skip) {
+		tst_resm(TINFO, "skip %s", tdat->msg);
+		return;
+	}
+
+	ret = syscall(__NR_setns, t->fd, t->ns_type);
+	if (ret == t->exp_ret) {
+		if (ret == -1 && errno == t->exp_errno)
+			tst_resm(TPASS, "%s exp_errno=%d", t->msg,
+				t->exp_errno);
+		else
+			tst_resm(TFAIL|TERRNO, "%s exp_errno=%d", t->msg,
+				t->exp_errno);
+	} else {
+		tst_resm(TFAIL, "%s ret=%d expected=%d", t->msg,
+			ret, t->exp_ret);
+	}
+
+	if (t->cleanup)
+		t->cleanup(t);
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
+	int i;
+
+	tst_require_root(NULL);
+
+	/* runtime check if syscall is supported */
+	syscall(__NR_setns, -1, 0);
+
+	ltpuser = getpwnam(nobody_uid);
+	if (ltpuser == NULL)
+		tst_brkm(TBROK | TERRNO, NULL, "getpwnam failed");
+
+	for (i = 0; i < NS_TOTAL; i++)
+		ns_fds[i] = get_ns_fd(getpid(), ns_names[i]);
+
+	tst_tmpdir();
+	TEST_PAUSE;
+}
+
+static void cleanup(void)
+{
+	int i;
+
+	for (i = 0; i < NS_TOTAL; i++)
+		if (ns_fds[i] != -1)
+			close(ns_fds[i]);
+	tst_rmdir();
+	TEST_CLEANUP;
+}
+#else
+int main(int argc, char *argv[])
+{
+	tst_brkm(TCONF, NULL, "__NR_setns, CLONE_NEWIPC, CLONE_NEWNET or "
+		"CLONE_NEWUTS is not defined on your system.");
+
+}
+#endif
-- 
1.7.1


------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
