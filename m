Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1X2F0d-0006aT-1M
	for ltp-list@lists.sourceforge.net; Wed, 02 Jul 2014 07:31:15 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1X2F0b-0003Uv-3M
	for ltp-list@lists.sourceforge.net; Wed, 02 Jul 2014 07:31:14 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s627V6AU011168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 2 Jul 2014 07:31:07 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s627V5bB017592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 2 Jul 2014 07:31:06 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	s627V4oV001092
	for <ltp-list@lists.sourceforge.net>; Wed, 2 Jul 2014 07:31:04 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed,  2 Jul 2014 11:30:58 +0400
Message-Id: <1404286258-2053-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <53A12D27.8030205@oracle.com>
References: <53A12D27.8030205@oracle.com>
Subject: [LTP] [PATCH V4] syscalls: implemented a test for
	sched_setaffinity() error values
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
Cc: vasily.isaenko@oracle.com

This test verifies sched_setaffinity(2) for all error conditions
to occur correctly.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
Changes since V3:
 * use tst_fork() instead of fork() for privileged_pid
 * use tst_get_unused_pid() for free_pid

 runtest/syscalls                                   |    1 +
 testcases/kernel/syscalls/.gitignore               |    1 +
 .../kernel/syscalls/sched_setaffinity/Makefile     |   23 +++
 .../syscalls/sched_setaffinity/sched_setaffinity.h |   60 +++++++
 .../sched_setaffinity/sched_setaffinity01.c        |  177 ++++++++++++++++++++
 5 files changed, 262 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/sched_setaffinity/Makefile
 create mode 100644 testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity.h
 create mode 100644 testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 66d6a65..52556bc 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -895,6 +895,7 @@ sched_setscheduler02 sched_setscheduler02
 
 sched_yield01 sched_yield01
 
+sched_setaffinity01 sched_setaffinity01
 sched_getaffinity01 sched_getaffinity01
 
 select01 select01
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 975c150..0c31582 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -724,6 +724,7 @@
 /sched_rr_get_interval/sched_rr_get_interval01
 /sched_rr_get_interval/sched_rr_get_interval02
 /sched_rr_get_interval/sched_rr_get_interval03
+/sched_setaffinity/sched_setaffinity01
 /sched_setparam/sched_setparam01
 /sched_setparam/sched_setparam02
 /sched_setparam/sched_setparam03
diff --git a/testcases/kernel/syscalls/sched_setaffinity/Makefile b/testcases/kernel/syscalls/sched_setaffinity/Makefile
new file mode 100644
index 0000000..2d825f1
--- /dev/null
+++ b/testcases/kernel/syscalls/sched_setaffinity/Makefile
@@ -0,0 +1,23 @@
+#
+#  Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
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
diff --git a/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity.h b/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity.h
new file mode 100644
index 0000000..8083894
--- /dev/null
+++ b/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity.h
@@ -0,0 +1,60 @@
+/*
+ * Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+/*
+ * Some old libcs (like glibc < 2.7) do not provide interfaces for
+ * dynamically sized cpu sets, but provide only static cpu_set_t type
+ * with no more than CPU_SETSIZE cpus in it.
+ *
+ * This file is a wrapper of the dynamic interfaces using the static ones.
+ *
+ * If the number of cpus available on the system is greater than
+ * CPU_SETSIZE, this interface will not work. Update libc in this case :)
+ */
+
+#define _GNU_SOURCE
+#include <sched.h>
+
+#ifndef LTP_SCHED_SETAFFINITY_H
+#define LTP_SCHED_SETAFFINITY_H
+
+#ifndef CPU_ALLOC
+#define CPU_ALLOC(ncpus) malloc(sizeof(cpu_set_t)); \
+if (ncpus > CPU_SETSIZE) { \
+	tst_brkm(TCONF, cleanup, \
+		"Your libc does not support masks with %ld cpus", ncpus); \
+}
+#endif
+
+#ifndef CPU_FREE
+#define CPU_FREE(ptr) free(ptr);
+#endif
+
+#ifndef CPU_ALLOC_SIZE
+#define CPU_ALLOC_SIZE(size) sizeof(cpu_set_t);
+#endif
+
+#ifndef CPU_ZERO_S
+#define CPU_ZERO_S(size, mask) CPU_ZERO(mask);
+#endif
+
+#ifndef CPU_SET_S
+#define CPU_SET_S(cpu, size, mask) CPU_SET(cpu, mask);
+#endif
+
+#endif /* LTP_SCHED_SETAFFINITY_H */
diff --git a/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01.c b/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01.c
new file mode 100644
index 0000000..d1b2abe
--- /dev/null
+++ b/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01.c
@@ -0,0 +1,177 @@
+/*
+ * Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+/*
+ * This test verifies sched_setaffinity(2) for all error conditions
+ * to occur correctly.
+ *
+ * sched_setaffinity() returns -1 and sets the error code to:
+ *
+ * 1) EFAULT, if the supplied memory address is invalid
+ * 2) EINVAL, if the mask doesn't contain at least one
+ *    permitted cpu
+ * 3) ESRCH, if the process whose id is pid could not
+ *    be found
+ * 4) EPERM, if the calling process doesn't have appropriate
+ *    privileges
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <pwd.h>
+#include <sched.h>
+#include <signal.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+#include "sched_setaffinity.h"
+
+char *TCID = "sched_setaffinity01";
+
+#define PID_MAX_PATH "/proc/sys/kernel/pid_max"
+
+static cpu_set_t *mask, *emask;
+static cpu_set_t *fmask = (void *)-1;
+static size_t mask_size, emask_size;
+static pid_t self_pid, privileged_pid, free_pid;
+static uid_t uid;
+static const char nobody_uid[] = "nobody";
+static struct passwd *ltpuser;
+static long ncpus;
+
+static struct test_case_t {
+	pid_t *pid;
+	size_t *mask_size;
+	cpu_set_t **mask;
+	int exp_errno;
+} test_cases[] = {
+	{&self_pid, &mask_size, &fmask, EFAULT},
+	{&self_pid, &emask_size, &emask, EINVAL},
+	{&free_pid, &mask_size, &mask, ESRCH},
+	{&privileged_pid, &mask_size, &mask, EPERM},
+};
+
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+
+static void cleanup(void)
+{
+	if (mask != NULL) {
+		CPU_FREE(mask);
+		mask = NULL;
+	}
+
+	if (emask != NULL) {
+		CPU_FREE(emask);
+		emask = NULL;
+	}
+
+	SAFE_SETEUID(NULL, uid);
+
+	if (privileged_pid != 0) {
+		kill(privileged_pid, SIGKILL);
+		waitpid(privileged_pid, NULL, 0);
+		privileged_pid = 0;
+	}
+}
+
+static void setup(void)
+{
+	tst_require_root(NULL);
+	uid = geteuid();
+	ncpus = tst_ncpus_max();
+
+	/* Current mask */
+	mask = CPU_ALLOC(ncpus);
+	if (mask == NULL)
+		tst_brkm(TBROK | TERRNO, cleanup, "CPU_ALLOC(%ld) failed",
+			ncpus);
+	mask_size = CPU_ALLOC_SIZE(ncpus);
+	if (sched_getaffinity(0, mask_size, mask) < 0)
+		tst_brkm(TBROK | TERRNO, cleanup, "sched_getaffinity() failed");
+
+	/* Mask with one more cpu than available on the system */
+	emask = CPU_ALLOC(ncpus + 1);
+	if (emask == NULL)
+		tst_brkm(TBROK | TERRNO, cleanup, "CPU_ALLOC(%ld) failed",
+			ncpus + 1);
+	emask_size = CPU_ALLOC_SIZE(ncpus + 1);
+	CPU_ZERO_S(emask_size, emask);
+	CPU_SET_S(ncpus, emask_size, emask);
+
+	privileged_pid = tst_fork();
+	if (privileged_pid == 0) {
+		pause();
+
+		exit(0);
+	} else if (privileged_pid < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
+	}
+
+	/* Dropping the root privileges */
+	ltpuser = getpwnam(nobody_uid);
+	if (ltpuser == NULL)
+		tst_brkm(TBROK | TERRNO, cleanup,
+			"getpwnam failed for user id %s", nobody_uid);
+
+	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
+
+	/* this pid is not used by the OS */
+	free_pid = tst_get_unused_pid(cleanup);
+}
+
+int main(int argc, char *argv[])
+{
+	const char *msg;
+	int lc;
+	int i;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+		for (i = 0; i < TST_TOTAL; i++) {
+			TEST(sched_setaffinity(*(test_cases[i].pid),
+						*(test_cases[i].mask_size),
+						*(test_cases[i].mask)));
+
+			if (TEST_RETURN != -1)
+				tst_resm(TFAIL,
+					"sched_setaffinity() unexpectedly succeded");
+
+			if (TEST_ERRNO == test_cases[i].exp_errno) {
+				tst_resm(TPASS, "expected failure with '%s'",
+					strerror(test_cases[i].exp_errno));
+			} else {
+				tst_resm(TFAIL,
+					"call returned '%s', expected - '%s'",
+					strerror(TEST_ERRNO),
+					strerror(test_cases[i].exp_errno));
+			}
+		}
+	}
+
+	cleanup();
+	tst_exit();
+}
-- 
1.7.1


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
