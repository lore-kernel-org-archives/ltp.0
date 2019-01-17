From: Pengfei Xu <pengfei.xu@intel.com>
Date: Thu, 17 Jan 2019 22:05:13 +0800
Subject: [LTP] [PATCH v6 ltp] Add Intel umip(User Mode Instruction
	Prevention) basic function tests
Message-ID: <20190117140513.9807-1-pengfei.xu@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

  umip is a security feature present in new Intel Processors.
  Intel CPU like ICE lake or newer is required.
  When umip enabled, it prevents the execution of certain instructions
  and situation as below:
    when Current Privilege Level (CPL) is greater than 0, user space
    applications could not access to system-wide settings such as
    the global and local descriptor tables, the segment selectors to
    the current task state and the local descriptor table.
  umip is enabled by default at boot.
  umip will protect below instructions in user mode:
    * SGDT - Store Global Descriptor Table
    * SIDT - Store Interrupt Descriptor Table
    * SLDT - Store Local Descriptor Table
    * SMSW - Store Machine Status Word
    * STR  - Store Task Register
  If CPU not support umip, you still could comment cpuinfo check code
  to verify anyway.

Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
---
 runtest/secure_umip                           |   2 +
 testcases/kernel/security/umip/.gitignore     |   1 +
 testcases/kernel/security/umip/Makefile       |   7 +
 testcases/kernel/security/umip/umip_gp_test.c | 182 ++++++++++++++++++++++++++
 4 files changed, 192 insertions(+)
 create mode 100644 runtest/secure_umip
 create mode 100644 testcases/kernel/security/umip/.gitignore
 create mode 100644 testcases/kernel/security/umip/Makefile
 create mode 100644 testcases/kernel/security/umip/umip_gp_test.c

diff --git a/runtest/secure_umip b/runtest/secure_umip
new file mode 100644
index 000000000..4082bc2a3
--- /dev/null
+++ b/runtest/secure_umip
@@ -0,0 +1,2 @@
+#DESCRIPTION: CPU security feature UMIP test
+umip_instruction_test umip_gp_test
diff --git a/testcases/kernel/security/umip/.gitignore b/testcases/kernel/security/umip/.gitignore
new file mode 100644
index 000000000..9e7022c59
--- /dev/null
+++ b/testcases/kernel/security/umip/.gitignore
@@ -0,0 +1 @@
+umip_gp_test
diff --git a/testcases/kernel/security/umip/Makefile b/testcases/kernel/security/umip/Makefile
new file mode 100644
index 000000000..18896b6f2
--- /dev/null
+++ b/testcases/kernel/security/umip/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/security/umip/umip_gp_test.c b/testcases/kernel/security/umip/umip_gp_test.c
new file mode 100644
index 000000000..b5835d371
--- /dev/null
+++ b/testcases/kernel/security/umip/umip_gp_test.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * testcases/security/umip/umip_gp_test.c
+ * Copyright (C) 2018 Intel Corporation
+ * Author: Neri, Ricardo <ricardo.neri@intel.com>
+ *	 Pengfei, Xu   <pengfei.xu@intel.com>
+ */
+
+/*
+ * This test will check if Intel umip(User-Mode Execution Prevention) is
+ * working.
+ *
+ * Intel CPU of ICE lake or newer is required for the test
+ * kconfig requirement:CONFIG_X86_INTEL_UMIP=y
+ *
+ */
+
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/wait.h>
+#include <signal.h>
+
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
+
+#define CPUINFO_FILE "/proc/cpuinfo"
+
+#define GDT_LEN 10
+#define IDT_LEN 10
+
+static int fd = -1;
+
+static struct tcase {
+	enum {
+	sgdt,
+	sidt,
+	sldt,
+	smsw,
+	str
+	} option;
+	int exp_sig;
+} tcases[] = {
+	{sgdt, SIGSEGV},
+	{sidt, SIGSEGV},
+	{sldt, SIGSEGV},
+	{smsw, SIGSEGV},
+	{str, SIGSEGV},
+};
+
+static void asm_sgdt(void)
+{
+	unsigned char val[GDT_LEN];
+
+	memset(val, 0, sizeof(val));
+	tst_res(TINFO, "TEST sgdt, sgdt result save at [%p]", val);
+	asm volatile("sgdt %0\n" : "=m" (val));
+	exit(0);
+}
+
+static void asm_sidt(void)
+{
+	unsigned char val[IDT_LEN];
+
+	memset(val, 0, sizeof(val));
+	tst_res(TINFO, "TEST sidt, sidt result save at [%p]\n", val);
+	asm volatile("sidt %0\n" : "=m" (val));
+	exit(0);
+}
+
+static void asm_sldt(void)
+{
+	unsigned long val;
+
+	tst_res(TINFO, "TEST sldt, sldt result save at [%p]\n", &val);
+	asm volatile("sldt %0\n" : "=m" (val));
+	exit(0);
+}
+
+static void asm_smsw(void)
+{
+	unsigned long val;
+
+	tst_res(TINFO, "TEST smsw, smsw result save at [%p]\n", &val);
+	asm volatile("smsw %0\n" : "=m" (val));
+	exit(0);
+}
+
+static void asm_str(void)
+{
+	unsigned long val;
+
+	tst_res(TINFO, "TEST str, str result save at [%p]\n", &val);
+	asm volatile("str %0\n" : "=m" (val));
+	exit(0);
+}
+
+static void verify_umip_instruction(unsigned int n)
+{
+	int status;
+	struct tcase *tc = &tcases[n];
+	pid_t pid;
+
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		switch (tc->option) {
+		case 0:
+			asm_sgdt();
+			break;
+		case 1:
+			asm_sidt();
+			break;
+		case 2:
+			asm_sldt();
+			break;
+		case 3:
+			asm_smsw();
+			break;
+		case 4:
+			asm_str();
+			break;
+		default:
+			tst_brk(TCONF, "Invalid tcase parameter:%d",
+				tc->option);
+		}
+		exit(0);
+	}
+
+	SAFE_WAITPID(pid, &status, 0);
+
+	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
+		tst_res(TPASS, "Got SIGSEGV");
+		return;
+	}
+	tst_res(TFAIL, "Didn't receive SIGSEGV, child exited with %s",
+		tst_strstatus(status));
+}
+
+static void setup(void)
+{
+	FILE *fp;
+	int max = 2048;
+	char buf[max];
+
+	// cpuinfo should contain umip
+	fp = SAFE_FOPEN(CPUINFO_FILE, "r");
+	while (!feof(fp)) {
+		if (fgets(buf, sizeof(buf), fp) == NULL) {
+			tst_brk(TCONF, "cpuinfo show: cpu does not support umip");
+		}
+
+		if (!strstr(buf, "flags"))
+			continue;
+
+		if (strstr(buf, "umip")) {
+			tst_res(TINFO, "cpuinfo contain umip, cpu support umip");
+			break;
+		} else
+			continue;
+	}
+
+	SAFE_FCLOSE(fp);
+}
+
+static void cleanup(void)
+{
+	if (fd != -1)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.min_kver = "4.1",
+	.setup = setup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.forks_child = 1,
+	.test = verify_umip_instruction,
+	.cleanup = cleanup,
+	.needs_root = 1,
+};
-- 
2.14.1

