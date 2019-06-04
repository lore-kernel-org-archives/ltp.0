From: Christian Amann <camann@suse.com>
Date: Tue,  4 Jun 2019 09:22:28 +0200
Subject: [LTP] [PATCH v2] syscalls/acct02: add functional testcase
Message-ID: <20190604072228.17513-1-camann@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch adds a functional test to verify that the file
contents of the process accounting file contains valid and
correct data when triggered using the acct() syscall.

Signed-off-by: Christian Amann <camann@suse.com>
---
 configure.ac                                   |   1 +
 include/lapi/acct.h                            |  69 ++++++++++
 m4/ltp-acct.m4                                 |   7 +
 runtest/syscalls                               |   1 +
 testcases/kernel/syscalls/acct/.gitignore      |   2 +
 testcases/kernel/syscalls/acct/acct02.c        | 183 +++++++++++++++++++++++++
 testcases/kernel/syscalls/acct/acct02_helper.c |  16 +++
 7 files changed, 279 insertions(+)
 create mode 100644 include/lapi/acct.h
 create mode 100644 m4/ltp-acct.m4
 create mode 100644 testcases/kernel/syscalls/acct/acct02.c
 create mode 100644 testcases/kernel/syscalls/acct/acct02_helper.c

diff --git a/configure.ac b/configure.ac
index 5a3dc5b62..5ecc92781 100644
--- a/configure.ac
+++ b/configure.ac
@@ -194,6 +194,7 @@ AC_CONFIG_SUBDIRS([utils/ffsb-6.0-rc2])
 AC_CONFIG_COMMANDS([syscalls.h], [cd ${ac_top_srcdir}/include/lapi/syscalls; ./regen.sh])
 
 # custom functions
+LTP_CHECK_ACCT
 LTP_CHECK_ACL_SUPPORT
 LTP_CHECK_ATOMIC_MEMORY_MODEL
 LTP_CHECK_BUILTIN_CLEAR_CACHE
diff --git a/include/lapi/acct.h b/include/lapi/acct.h
new file mode 100644
index 000000000..ebd65bbf4
--- /dev/null
+++ b/include/lapi/acct.h
@@ -0,0 +1,69 @@
+//SPDX-License-Identifier: GPL-2.0-or-later
+
+#ifndef LAPI_ACCT_H
+#define LAPI_ACCT_H
+
+#include <sys/types.h>
+#include "config.h"
+
+#ifdef HAVE_STRUCT_ACCT_V3
+#include <sys/acct.h>
+#else
+
+#define ACCT_COMM 16
+
+typedef uint16_t comp_t;
+
+/* Fallback structures to parse the process accounting file */
+struct acct {
+	char ac_flag;
+	uint16_t ac_uid;
+	uint16_t ac_gid;
+	uint16_t ac_tty;
+	uint32_t ac_btime;
+	comp_t    ac_utime;
+	comp_t    ac_stime;
+	comp_t    ac_etime;
+	comp_t    ac_mem;
+	comp_t    ac_io;
+	comp_t    ac_rw;
+	comp_t    ac_minflt;
+	comp_t    ac_majflt;
+	comp_t    ac_swaps;
+	uint32_t ac_exitcode;
+	char      ac_comm[ACCT_COMM+1];
+	char      ac_pad[10];
+};
+
+struct acct_v3 {
+	char      ac_flag;
+	char      ac_version;
+	uint16_t ac_tty;
+	uint32_t ac_exitcode;
+	uint32_t ac_uid;
+	uint32_t ac_gid;
+	uint32_t ac_pid;
+	uint32_t ac_ppid;
+	uint32_t ac_btime;
+	float     ac_etime;
+	comp_t    ac_utime;
+	comp_t    ac_stime;
+	comp_t    ac_mem;
+	comp_t    ac_io;
+	comp_t    ac_rw;
+	comp_t    ac_minflt;
+	comp_t    ac_majflt;
+	comp_t    ac_swaps;
+	char      ac_comm[ACCT_COMM];
+};
+
+/* Possible values for the ac_flag member */
+enum {
+	AFORK = 0x01,
+	ASU   = 0x02,
+	ACORE = 0x08,
+	AXSIG = 0x10
+};
+#endif /* HAVE_STRUCT_ACCT_V3 */
+
+#endif /* LAPI_ACCT_H */
diff --git a/m4/ltp-acct.m4 b/m4/ltp-acct.m4
new file mode 100644
index 000000000..61bc01947
--- /dev/null
+++ b/m4/ltp-acct.m4
@@ -0,0 +1,7 @@
+dnl SPDX-License-Identifier: GPL-2.0-or-later
+dnl Copyright (c) 2019 SUSE LLC
+dnl Author: Christian Amann <camann@suse.com>
+
+AC_DEFUN([LTP_CHECK_ACCT],[
+AC_CHECK_TYPES([struct acct_v3],,,[#include <sys/acct.h>])
+])
diff --git a/runtest/syscalls b/runtest/syscalls
index 762b15b1f..e4d506033 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -10,6 +10,7 @@ access03 access03
 access04 access04
 
 acct01 acct01
+acct02 acct02
 
 add_key01 add_key01
 add_key02 add_key02
diff --git a/testcases/kernel/syscalls/acct/.gitignore b/testcases/kernel/syscalls/acct/.gitignore
index c2fb15611..08a89756b 100644
--- a/testcases/kernel/syscalls/acct/.gitignore
+++ b/testcases/kernel/syscalls/acct/.gitignore
@@ -1 +1,3 @@
 /acct01
+/acct02
+/acct02_helper
diff --git a/testcases/kernel/syscalls/acct/acct02.c b/testcases/kernel/syscalls/acct/acct02.c
new file mode 100644
index 000000000..8a99bb94d
--- /dev/null
+++ b/testcases/kernel/syscalls/acct/acct02.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  Copyright (c) SUSE LLC, 2019
+ *  Author: Christian Amann <camann@suse.com>
+ */
+/*
+ * This tests if the kernel writes correct data to the
+ * process accounting file.
+ *
+ * First, system-wide process accounting is turned on and the output gets
+ * directed to a defined file. After that a dummy program is run in order
+ * to generate data and the process accounting gets turned off again.
+ *
+ * To verify the written data, the entries of the accounting file get
+ * parsed into the corresponding acct structure. Since it cannot be guaranteed
+ * that only the command issued by this test gets written into the accounting
+ * file, the contents get parsed until the correct entry is found, or EOF
+ * is reached.
+ */
+
+#include <sys/stat.h>
+#include <errno.h>
+#include <string.h>
+#include <time.h>
+#include <unistd.h>
+#include "tst_kconfig.h"
+#include "tst_test.h"
+#include "lapi/acct.h"
+
+#define COMMAND		"acct02_helper"
+#define OUTPUT_FILE	"acct_file"
+
+#define UNPACK(x) ((x & 0x1fff) << (((x >> 13) & 0x7) * 3))
+
+static int fd;
+static int v3;
+static int acct_size;
+static int clock_ticks;
+static unsigned int rc;
+static unsigned int start_time;
+
+static union acct_union {
+	struct acct	v0;
+	struct acct_v3	v3;
+} acct_struct;
+
+static int acct_version_is_3(void)
+{
+	const char *kconfig_acct_v3[] = {
+		"CONFIG_BSD_PROCESS_ACCT_V3",
+		NULL
+	};
+
+	struct tst_kconfig_res results[1];
+
+	tst_kconfig_read(kconfig_acct_v3, results, 1);
+
+	return results[0].match == 'y';
+}
+
+static void run_command(void)
+{
+	const char *const cmd[] = {COMMAND, NULL};
+
+	rc = tst_run_cmd(cmd, NULL, NULL, 1) << 8;
+}
+
+static int verify_acct(struct acct *acc)
+{
+	int sys_time  = UNPACK(acc->ac_stime);
+	int user_time = UNPACK(acc->ac_utime);
+	int elap_time = UNPACK(acc->ac_etime);
+
+	if (strcmp(acc->ac_comm, COMMAND) ||
+		acc->ac_btime < start_time ||
+		acc->ac_btime - start_time > 1 ||
+		acc->ac_uid != getuid() ||
+		acc->ac_gid != getgid() ||
+		user_time/clock_ticks > 1 ||
+		sys_time/clock_ticks  > 1 ||
+		elap_time/clock_ticks >= 2 ||
+		acc->ac_exitcode != rc)
+		return 0;
+	return 1;
+}
+
+static int verify_acct_v3(struct acct_v3 *acc)
+{
+	int sys_time  = UNPACK(acc->ac_stime);
+	int user_time = UNPACK(acc->ac_utime);
+	int elap_time = acc->ac_etime;
+
+	if (strcmp(acc->ac_comm, COMMAND) ||
+		acc->ac_btime < start_time ||
+		acc->ac_btime - start_time > 1 ||
+		acc->ac_uid != getuid() ||
+		acc->ac_gid != getgid() ||
+		acc->ac_ppid != (uint32_t)getpid() ||
+		user_time/clock_ticks > 1 ||
+		sys_time/clock_ticks  > 1 ||
+		elap_time/clock_ticks >= 2 ||
+		acc->ac_exitcode != rc ||
+		acc->ac_version != 3 ||
+		acc->ac_pid < 1)
+		return 0;
+	return 1;
+}
+
+static void run(void)
+{
+	int read_bytes, ret, entry_count;
+
+	fd = SAFE_OPEN(OUTPUT_FILE, O_RDWR | O_CREAT, 0644);
+
+	TEST(acct(OUTPUT_FILE));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "Could not set acct output file");
+
+	start_time = time(NULL);
+	run_command();
+	acct(NULL);
+
+	entry_count = 0;
+	do {
+		read_bytes = SAFE_READ(0, fd, &acct_struct, acct_size);
+
+		if (v3)
+			ret = verify_acct_v3(&acct_struct.v3);
+		else
+			ret = verify_acct(&acct_struct.v0);
+
+		if (read_bytes)
+			entry_count++;
+	} while (read_bytes == acct_size && !ret);
+
+	tst_res(TINFO, "Number of accounting file entries tested: %d",
+			entry_count);
+
+	if (ret)
+		tst_res(TPASS, "acct() wrote correct file contents!");
+	else
+		tst_res(TFAIL, "acct() wrote incorrect file contents!");
+}
+
+static void setup(void)
+{
+	clock_ticks = SAFE_SYSCONF(_SC_CLK_TCK);
+
+	TEST(acct(NULL));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO,
+			"acct() system call returned with error");
+
+	v3 = acct_version_is_3();
+	if (v3) {
+		tst_res(TINFO, "Verifying using 'struct acct_v3'");
+		acct_size = sizeof(struct acct_v3);
+	} else {
+		tst_res(TINFO, "Verifying using 'struct acct'");
+		acct_size = sizeof(struct acct);
+	}
+}
+
+static void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+	acct(NULL);
+}
+
+static const char *kconfigs[] = {
+	"CONFIG_BSD_PROCESS_ACCT",
+	NULL
+};
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_kconfigs = kconfigs,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+};
diff --git a/testcases/kernel/syscalls/acct/acct02_helper.c b/testcases/kernel/syscalls/acct/acct02_helper.c
new file mode 100644
index 000000000..66017cb9b
--- /dev/null
+++ b/testcases/kernel/syscalls/acct/acct02_helper.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  Copyright (c) SUSE LLC, 2019
+ *  Author: Christian Amann <camann@suse.com>
+ */
+/*
+ * Dummy program used in acct02
+ */
+
+#include <unistd.h>
+
+int main(void)
+{
+	sleep(1);
+	return 128;
+}
-- 
2.16.4

