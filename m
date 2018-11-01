From: Pengfei Xu <pengfei.xu@intel.com>
Date: Thu,  1 Nov 2018 09:49:27 +0800
Subject: [LTP] [PATCH ltp v2 1/2] Add Intel umip(User Mode Instruction
	Prevention) basic function tests
Message-ID: <20181101014928.23628-1-pengfei.xu@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

  umip is one Intel security function, which protect(#GP exception)
  below instructions in user mode:
    * SGDT - Store Global Descriptor Table
    * SIDT - Store Interrupt Descriptor Table
    * SLDT - Store Local Descriptor Table
    * SMSW - Store Machine Status Word
    * STR - Store Task Register
  Add test code and scripts.

Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
---
 testcases/kernel/security/umip/.gitignore     |   1 +
 testcases/kernel/security/umip/Makefile       |   9 ++
 testcases/kernel/security/umip/umip_common.sh |  39 ++++++
 testcases/kernel/security/umip/umip_func.sh   |  58 +++++++++
 testcases/kernel/security/umip/umip_gp_test.c | 171 ++++++++++++++++++++++++++
 5 files changed, 278 insertions(+)
 create mode 100644 testcases/kernel/security/umip/.gitignore
 create mode 100644 testcases/kernel/security/umip/Makefile
 create mode 100755 testcases/kernel/security/umip/umip_common.sh
 create mode 100755 testcases/kernel/security/umip/umip_func.sh
 create mode 100644 testcases/kernel/security/umip/umip_gp_test.c

diff --git a/testcases/kernel/security/umip/.gitignore b/testcases/kernel/security/umip/.gitignore
new file mode 100644
index 000000000..9e7022c59
--- /dev/null
+++ b/testcases/kernel/security/umip/.gitignore
@@ -0,0 +1 @@
+umip_gp_test
diff --git a/testcases/kernel/security/umip/Makefile b/testcases/kernel/security/umip/Makefile
new file mode 100644
index 000000000..972536c92
--- /dev/null
+++ b/testcases/kernel/security/umip/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+INSTALL_TARGETS		:= *.sh
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/security/umip/umip_common.sh b/testcases/kernel/security/umip/umip_common.sh
new file mode 100755
index 000000000..0841afc49
--- /dev/null
+++ b/testcases/kernel/security/umip/umip_common.sh
@@ -0,0 +1,39 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018, Intel Corporation
+# Authors:      Pengfei Xu - pengfei.xu@intel.com
+# Description: it's for umip test common function scripts
+
+. tst_test.sh
+
+# check kernel config already set or not
+kconfig_check()
+{
+	config_content="$1"
+	result=""
+
+	if [ -r "/boot/config-$(uname -r)" ]; then
+		result=$(grep -E "^$config_content" "/boot/config-$(uname -r)")
+	# for clear linux, kernel config saved in /lib/kernel/
+	elif [ -r "/lib/kernel/config-$(uname -r)" ]; then
+		result=$(grep -E "^$config_content" "/lib/kernel/config-$(uname -r)")
+	elif [ -r "/proc/config.gz" ]; then
+		result=$(zcat "/proc/config.gz" | grep -E "^$config_content")
+	else
+		tst_res TINFO "No config file readable on this system"
+		return 1
+	fi
+	[ -n "$result" ] || return 1
+	return 0
+}
+
+# check /proc/cpuinfo contain test function or not
+cpu_info_check()
+{
+	cpu_func="$1"
+
+	[ -n "$cpu_func" ] || tst_brk TWARN "no cpu info check item"
+	grep -q "$cpu_func" /proc/cpuinfo || return 1
+	tst_res TINFO "/proc/cpuinfo contain '$cpu_func'"
+	return 0
+}
diff --git a/testcases/kernel/security/umip/umip_func.sh b/testcases/kernel/security/umip/umip_func.sh
new file mode 100755
index 000000000..8719409e3
--- /dev/null
+++ b/testcases/kernel/security/umip/umip_func.sh
@@ -0,0 +1,58 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018, Intel Corporation
+# Authors:      Pengfei Xu - pengfei.xu@intel.com
+# Description: it's for Intel User Mode Instruction Prevention(UMIP)
+# function test, below instructions should be GP exception blocked if
+# Current Privilege Level (CPL) is greater than 0.
+# UMIP protected instructions are as below:
+#    * SGDT - Store Global Descriptor Table
+#    * SIDT - Store Interrupt Descriptor Table
+#    * SLDT - Store Local Descriptor Table
+#    * SMSW - Store Machine Status Word
+#    * STR  - Store Task Register
+#    kconfig requirement: CONFIG_X86_INTEL_UMIP=y
+#    cpu requirement: /proc/cpuinfo need contain umip
+
+TST_CNT=1
+TST_SETUP=setup
+TST_TESTFUNC=do_test
+TST_POS_ARGS=2
+TST_USAGE=usage
+TST_NEEDS_ROOT=1
+
+. tst_test.sh
+. umip_common.sh
+
+bin_name="$1"
+parm="$2"
+
+usage() {
+	cat <<__EOF
+	usage: ./$0  [bin_name][parm]
+	bin_name:  Test cpu bin name like umip_gp_test and so on
+	parm:  Test bin file parameter like 'g' and so on
+__EOF
+}
+
+# kernel config should set CONFIG_X86_INTEL_UMIP=y
+# /proc/cpuinfo should contain umip
+setup()
+{
+	func_name="umip"
+	config_umip="CONFIG_X86_INTEL_UMIP=y"
+
+	kconfig_check "$config_umip" \
+	    || tst_brk TCONF "kernel config not set $config_umip"
+	cpu_info_check "$func_name" \
+	    || tst_brk TCONF "/proc/cpuinfo no umip function"
+}
+
+# umip protect instruction should be blocked when user execute
+do_test()
+{
+	tst_res TINFO "Test $bin_name $parm"
+	EXPECT_FAIL "$bin_name" "$parm"
+}
+
+tst_run
diff --git a/testcases/kernel/security/umip/umip_gp_test.c b/testcases/kernel/security/umip/umip_gp_test.c
new file mode 100644
index 000000000..ae1068a60
--- /dev/null
+++ b/testcases/kernel/security/umip/umip_gp_test.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * testcases/security/umip/umip_gp_test.c
+ * Copyright (C) 2018 Intel Corporation
+ * Author: Pengfei, Xu <pengfei.xu@intel.com>
+ */
+
+/*
+ * This test is for Intel User-Mode Execution Prevention(umip) test
+ *
+ * umip is a security feature present in new Intel Processors.
+ * If enabled, it prevents the execution of certain instructions
+ * if the Current Privilege Level (CPL) is greater than 0.
+ * If these instructions were executed while in CPL > 0, user space
+ * applications could not access to system-wide settings such as
+ * the global and local descriptor tables, the segment selectors to
+ * the current task state and the local descriptor table.
+ * UMIP is enabled by default at boot.
+ *
+ * History:    Oct 23 2018 - created
+ *        - Tested sgdt, sidt, sldt, smsw and str by asm in C
+ *          all above 5 instruction should be #GP(general protection)
+ *          exception in UMIP supproted and enabled platform, if
+ *          disabled UMIP, will show instruction store results
+ *        - Add parameter for each instruction test
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#define GDT_LEN 10
+#define IDT_LEN 10
+
+void usage(void)
+{
+	printf("Usage: [g][i][l][m][t][a]\n");
+	printf("g      Test sgdt\n");
+	printf("i      Test sidt\n");
+	printf("l      Test sldt\n");
+	printf("m      Test smsw\n");
+	printf("t      Test str\n");
+	printf("a      Test all\n");
+}
+
+static void asm_sgdt(void)
+{
+	int i;
+	unsigned char val[GDT_LEN];
+
+	memset(val, 0, sizeof(val));
+
+	printf("RESULTS SGDT save at [%p]\n", val);
+	printf("Initial val:0x");
+	for (i = 0; i < GDT_LEN; i++)
+		printf("%02x", val[i]);
+
+	asm volatile("sgdt %0\n" : "=m" (val));
+	printf("\nSGDT results in val:\n");
+	printf("val:0x");
+	for (i = 0; i < GDT_LEN; i++)
+		printf("%02x", val[i]);
+	printf("\nDone.\n");
+}
+
+static void asm_sidt(void)
+{
+	int i;
+	unsigned char val[IDT_LEN];
+
+	memset(val, 0, sizeof(val));
+
+	printf("RESULTS SIDT save at [%p]\n", val);
+	printf("Initial val:0x");
+	for (i = 0; i < IDT_LEN; i++)
+		printf("%02x", val[i]);
+	asm volatile("sidt %0\n" : "=m" (val));
+	printf("\nSIDT results in val:\n");
+	printf("val:0x");
+	for (i = 0; i < GDT_LEN; i++)
+		printf("%02x", val[i]);
+	printf("\nDone.\n");
+}
+
+static void asm_sldt(void)
+{
+	unsigned long val;
+
+	printf("RESULTS SLDT save at [%p]\n", &val);
+	printf("Initial val:0x%lx", val);
+	asm volatile("sldt %0\n" : "=m" (val));
+
+	printf("\nSLDT results in val:\n");
+	printf("val:0x%lx", val);
+	printf("\nDone.\n");
+}
+
+static void asm_smsw(void)
+{
+	unsigned long val;
+
+	printf("RESULTS SMSW save at [%p]\n", &val);
+	printf("Initial val:0x%lx", val);
+	asm volatile("smsw %0\n" : "=m" (val));
+
+	printf("\nSMSW results in val:\n");
+	printf("val:0x%lx", val);
+	printf("\nDone.\n");
+}
+
+static void asm_str(void)
+{
+	unsigned long val;
+
+	printf("RESULTS STR save@[%p]\n", &val);
+	printf("Initial val:0x%lx", val);
+	asm volatile("str %0\n" : "=m" (val));
+
+	printf("\nSTR results in val:\n");
+	printf("val:0x%lx", val);
+	printf("\nDone.\n");
+}
+
+int main(int argc, char *argv[])
+{
+	char parm;
+
+	if (argc == 1) {
+		usage();
+		exit(1);
+		}
+	else {
+		if (sscanf(argv[1], "%c", &parm) == 1) {
+			printf("1 parameters: parm=%c\n", parm);
+			}
+		else {
+			printf("Get parameter failed.\n");
+			exit(1);
+			}
+		}
+
+	switch (parm) {
+	case 'a':
+		printf("Test all.\n");
+		asm_sgdt();
+		asm_sidt();
+		asm_sldt();
+		asm_smsw();
+		asm_str();
+		break;
+	case 'g':
+		asm_sgdt();
+		break;
+	case 'i':
+		asm_sidt();
+		break;
+	case 'l':
+		asm_sldt();
+		break;
+	case 'm':
+		asm_smsw();
+		break;
+	case 't':
+		asm_str();
+		break;
+	default:
+		usage();
+		exit(1);
+	}
+}
-- 
2.14.1

