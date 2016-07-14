From: Chunyu Hu <chuhu@redhat.com>
Date: Thu, 14 Jul 2016 17:25:29 +0800
Subject: [LTP] [PATCH] syscallls/sched_setscheduler: add sched_setscheduler03
Message-ID: <1468488329-16878-1-git-send-email-chuhu@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test the scheduler behavior on fair processes without SYS_CAP_NICE
capability, it should allow process do this syscall if it's not growing
the priority.

Signed-off-by: Chunyu Hu <chuhu@redhat.com>
---
 runtest/ltplite                                    |   1 +
 runtest/syscalls                                   |   1 +
 testcases/kernel/syscalls/.gitignore               |   1 +
 .../sched_setscheduler/sched_setscheduler03.c      | 226 +++++++++++++++++++++
 4 files changed, 229 insertions(+)
 create mode 100644 testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler03.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 4f6186b..a69d66e 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -706,6 +706,7 @@ sched_getscheduler02 sched_getscheduler02
 
 sched_setscheduler01 sched_setscheduler01
 sched_setscheduler02 sched_setscheduler02
+sched_setscheduler03 sched_setscheduler03
 
 sched_yield01 sched_yield01
 
diff --git a/runtest/syscalls b/runtest/syscalls
index ed63358..5b57d31 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -942,6 +942,7 @@ sched_getscheduler02 sched_getscheduler02
 
 sched_setscheduler01 sched_setscheduler01
 sched_setscheduler02 sched_setscheduler02
+sched_setscheduler03 sched_setscheduler03
 
 sched_yield01 sched_yield01
 
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 0512f8a..6b6dfe4 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -786,6 +786,7 @@
 /sched_setparam/sched_setparam05
 /sched_setscheduler/sched_setscheduler01
 /sched_setscheduler/sched_setscheduler02
+/sched_setscheduler/sched_setscheduler03
 /sched_yield/sched_yield01
 /select/select01
 /select/select02
diff --git a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler03.c b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler03.c
new file mode 100644
index 0000000..b6f2598
--- /dev/null
+++ b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler03.c
@@ -0,0 +1,226 @@
+/*
+ * Copyright (c) 2016 Linux Test Project.
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 3 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * A regression test for can_nice call usage in sched_setscheduler,
+ * introduced by kernel commit:
+ *    d50dde5a (sched: Add new scheduler syscalls to support
+ *
+ * This was fixed by below commit:
+ *    eaad4513 (sched: Fix __sched_setscheduler() nice test
+ *
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <errno.h>
+#include <sched.h>
+#include <linux/capability.h>
+#include <sys/time.h>
+#include <sys/resource.h>
+
+#include "tst_test.h"
+#include "linux_syscall_numbers.h"
+
+#define RLIMIT_NICE_NORMAL 20
+
+#ifndef SCHED_IDLE
+#define SCHED_IDLE 5
+#endif
+
+/* cap_user_header_t is a pointer to __user_cap_header_struct */
+static struct __user_cap_header_struct cap_header;
+
+/*
+ * cap_user_data_t is a pointer to to __user_cap_data_struct.
+ * there are three versions of header, on v2 and v3, the calls
+ * need two data struct, here we use only v1 is enough, but
+ * leave it as a two item array for deprecate consideration.
+ */
+static struct __user_cap_data_struct cap_data[2];
+
+static struct rlimit limit;
+static pid_t zero_pid;
+static struct sched_param param[1] = {{0}};
+
+struct test_case_t {
+	pid_t *pid;
+	int policy;
+	struct sched_param *sched_param;
+	int error;
+};
+
+struct test_case_t cases[] = {
+	{
+		.pid = &zero_pid,
+		.policy = SCHED_OTHER,
+		.sched_param = &param[0]
+	},
+	{
+		.pid = &zero_pid,
+		.policy = SCHED_BATCH,
+		.sched_param = &param[0]
+	},
+	{
+		.pid = &zero_pid,
+		.policy = SCHED_IDLE,
+		.sched_param = &param[0]
+	}
+};
+
+static void l_rlimit_show(const int type, struct rlimit *limit)
+{
+	if (getrlimit(type, limit) < 0)
+		tst_brk(TBROK | TERRNO, "Error getrlimit");
+
+	tst_res(TINFO, "rlimit rlim_cur=%lu", (unsigned long)(limit->rlim_cur));
+	tst_res(TINFO, "rlimit rlim_max=%lu", (unsigned long)(limit->rlim_max));
+}
+
+static void l_rlimit_setup(const int type, struct rlimit *limit)
+{
+	tst_res(TINFO, "Setting rlim_cur to %lu", (unsigned long)(limit->rlim_cur));
+	tst_res(TINFO, "Setting rlim_max to %lu", (unsigned long)(limit->rlim_max));
+
+	struct rlimit tmp_rlimit;
+
+	if (setrlimit(type, limit) < 0)
+		tst_brk(TBROK | TERRNO, "Error setrlimit");
+
+	l_rlimit_show(RLIMIT_NICE, &tmp_rlimit);
+
+	if (tmp_rlimit.rlim_cur != limit->rlim_cur)
+		tst_brk(TBROK | TERRNO, "Expect rlim_cur = %lu, get %lu",
+				(unsigned long)(limit->rlim_cur),
+				(unsigned long)tmp_rlimit.rlim_cur);
+
+	if (tmp_rlimit.rlim_max != limit->rlim_max)
+		tst_brk(TBROK | TERRNO, "Expect rlim_max = %lu, get %lu",
+				(unsigned long)(limit->rlim_max),
+				(unsigned long)(tmp_rlimit.rlim_max));
+
+}
+
+static void l_cap_show(struct __user_cap_header_struct *header,
+				struct __user_cap_data_struct *cap)
+{
+	if (tst_syscall(__NR_capget, header, cap) < 0)
+		tst_brk(TBROK | TERRNO, "Error capget");
+
+	tst_res(TINFO,
+		"cap.effective = %X, cap.permitted = %X, cap.inheritable = %X",
+			 cap->effective, cap->permitted, cap->inheritable);
+
+}
+
+static void l_cap_setup(struct __user_cap_header_struct *header,
+			struct __user_cap_data_struct *cap)
+{
+	struct __user_cap_data_struct tmp_data[2];
+	struct __user_cap_header_struct tmp_header = *header;
+
+	tst_res(TINFO, "Setting cap %X", cap->effective);
+
+	if (tst_syscall(__NR_capset, header, cap) < 0)
+		tst_brk(TBROK | TERRNO, "Error capset");
+
+	l_cap_show(&tmp_header, &tmp_data[0]);
+
+	if (tmp_data[0].effective != cap->effective)
+		tst_brk(TBROK | TERRNO, "Expect cap->effective = %d, get %d",
+			cap->effective, tmp_data[0].effective);
+
+	if (tmp_data[0].permitted != cap->permitted)
+		tst_brk(TBROK | TERRNO, "Expect cap->effective = %d, get %d",
+			cap->permitted, tmp_data[0].permitted);
+
+
+	if (tmp_data[0].inheritable != cap->inheritable)
+		tst_brk(TBROK | TERRNO, "Expect cap->inheritable = %d, get %d",
+			cap->inheritable, tmp_data[0].inheritable);
+}
+
+static void verify_fn(unsigned int i)
+{
+
+	TEST(sched_setscheduler(*cases[i].pid, cases[i].policy,
+					cases[i].sched_param));
+	if (TEST_RETURN)
+		tst_res(TFAIL, "unexpected error - %d : %s - "
+			 "expected %d", TEST_ERRNO,
+			 strerror(TEST_ERRNO), cases[i].error);
+	else
+		tst_res(TPASS, "Succeed - %d : %s - "
+			 "expected %d", TEST_ERRNO,
+			 strerror(TEST_ERRNO), cases[i].error);
+}
+
+static void setup(void)
+{
+
+	cap_header.version = _LINUX_CAPABILITY_VERSION_1;
+
+	l_rlimit_show(RLIMIT_NICE, &limit);
+
+	/*
+	* nice rlimit ranges from 1 to 40, mapping to real nice
+	* value from 19 to -20. We set it to 19, as the default priority
+	* of process with fair policy is 120, which will be translated
+	* into nice 20, we make this RLIMIT_NICE smaller than that, to
+	* verify the can_nice usage issue.
+	*/
+	limit.rlim_cur = (RLIMIT_NICE_NORMAL - 1);
+	limit.rlim_max = (RLIMIT_NICE_NORMAL - 1);
+
+	l_rlimit_setup(RLIMIT_NICE, &limit);
+
+	tst_res(TINFO, "Setting init sched policy to SCHED_OTHER");
+	if (sched_setscheduler(0, SCHED_OTHER, &param[0]) != 0)
+		tst_brk(TBROK | TERRNO,
+			 "ERROR sched_setscheduler: (0, SCHED_OTHER, param)");
+
+	if (sched_getscheduler(0) != SCHED_OTHER)
+		tst_brk(TBROK | TERRNO, "ERROR sched_tetscheduler");
+
+	l_cap_show(&cap_header, &cap_data[0]);
+
+	cap_data[0].effective &= (~(1 << CAP_SYS_NICE));
+	cap_data[0].permitted &= (~(1 << CAP_SYS_NICE));
+	cap_data[0].inheritable = 1;
+
+	l_cap_setup(&cap_header, &cap_data[0]);
+}
+
+static void cleanup(void)
+{
+	tst_res(TINFO, "cleanup() executed by pid %i", getpid());
+}
+
+static void do_test(unsigned int i)
+{
+	verify_fn(i);
+}
+
+static struct tst_test test = {
+	.tid = "sched_setscheduler03",
+	.tcnt = 3,
+	.test = do_test,
+	.setup = setup,
+	.cleanup = cleanup,
+	.forks_child = 1,
+};
+
-- 
1.8.3.1

