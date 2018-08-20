From: Masayoshi Mizuma <msys.mizuma@gmail.com>
Date: Mon, 20 Aug 2018 15:49:12 -0400
Subject: [LTP] [PATCH 2/5] acpi_hotplug: Add ACPI based cpu and memory
	hotplug testing
In-Reply-To: <20180820194915.11805-1-msys.mizuma@gmail.com>
References: <20180820194915.11805-1-msys.mizuma@gmail.com>
Message-ID: <20180820194915.11805-3-msys.mizuma@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

This tests the following ACPI based cpu and memory hotplugs.

  1. Memory hot remove
  2. CPU hot remove
  3. ACPI container device hot remove
  4. ACPI container device hot add
  5. CPU hot add
  6. Memory hot add

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 .../hotplug/acpi_hotplug/ACPIHOTPLUG_01.sh    | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100755 testcases/kernel/hotplug/acpi_hotplug/ACPIHOTPLUG_01.sh

diff --git a/testcases/kernel/hotplug/acpi_hotplug/ACPIHOTPLUG_01.sh b/testcases/kernel/hotplug/acpi_hotplug/ACPIHOTPLUG_01.sh
new file mode 100755
index 000000000..e01b9ad79
--- /dev/null
+++ b/testcases/kernel/hotplug/acpi_hotplug/ACPIHOTPLUG_01.sh
@@ -0,0 +1,92 @@
+#!/bin/sh
+
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018, FUJITSU LIMITED. All rights reserved.
+
+TST_SETUP=_setup
+TST_CLEANUP=_cleanup
+TST_TESTFUNC=test
+TST_CNT=6
+
+. tst_test.sh
+. ACPIHOTPLUG_lib.sh
+
+test1()
+{
+	if [[ ${#HOTPLUGABLE_NODES[@]} -eq 0 ]]; then
+		tst_brk TCONF "Memory hotplug may be not supported in this system"
+	fi
+	memory_hp "hotremove"
+	if [[ $? -eq 0 ]]; then
+		tst_res TPASS "memory hotremove success"
+	else
+		tst_res TFAIL "memory hotremove failed"
+	fi
+}
+
+test2()
+{
+	if [[ -z $HOTPLUGABLE_CONTAINER ]]; then
+		tst_brk TCONF "CPU hotplug may be not supported in this system"
+	fi
+	cpu_hp "hotremove"
+	if [[ $? -eq 0 ]]; then
+		tst_res TPASS "cpu hotremove success"
+	else
+		tst_res TFAIL "cpu hotremove failed"
+	fi
+}
+
+test3()
+{
+	if [[ -z $HOTPLUGABLE_CONTAINER ]]; then
+		tst_brk TCONF "ACPI container hotplug may be not supported in this system"
+	fi
+	container_hp "hotremove"
+	if [[ $? -eq 0 ]]; then
+		tst_res TPASS "ACPI container hotremove success"
+	else
+		tst_res TFAIL "ACPI container hotremove failed"
+	fi
+}
+
+test4()
+{
+	if [[ -z $HOTPLUGABLE_CONTAINER ]]; then
+		tst_brk TCONF "ACPI container hotplug may be not supported in this system"
+	fi
+	container_hp "hotadd"
+	if [[ $? -eq 0 ]]; then
+		tst_res TPASS "ACPI container hotadd success"
+	else
+		tst_res TFAIL "ACPI container  hotadd failed"
+	fi
+}
+
+test5()
+{
+	if [[ -z $HOTPLUGABLE_CONTAINER ]]; then
+		tst_brk TCONF "CPU hotplug may be not supported in this system"
+	fi
+	cpu_hp "hotadd"
+	if [[ $? -eq 0 ]]; then
+		tst_res TPASS "cpu hotadd success"
+	else
+		tst_res TFAIL "cpu hotadd failed"
+	fi
+}
+
+
+test6()
+{
+	if [[ ${#HOTPLUGABLE_NODES[@]} -eq 0 ]]; then
+		tst_brk TCONF "Memory hotplug may be not supported in this system"
+	fi
+	memory_hp "hotadd"
+	if [[ $? -eq 0 ]]; then
+		tst_res TPASS "memory hotadd success"
+	else
+		tst_res TFAIL "memory hotadd failed"
+	fi
+}
+tst_run
-- 
2.18.0

