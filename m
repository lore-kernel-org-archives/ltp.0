From: Li Wang <liwang@redhat.com>
Date: Fri,  4 Mar 2016 16:24:53 +0800
Subject: [LTP] [PATCH RFC 4/9] ftrace_regression: add new case to
	ftrace_regression/ dir
In-Reply-To: <1457079898-9449-4-git-send-email-liwang@redhat.com>
References: <1457079898-9449-1-git-send-email-liwang@redhat.com>
 <1457079898-9449-2-git-send-email-liwang@redhat.com>
 <1457079898-9449-3-git-send-email-liwang@redhat.com>
 <1457079898-9449-4-git-send-email-liwang@redhat.com>
Message-ID: <1457079898-9449-5-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This case is the reproducer of ftrace userstacktrace bug.

BUG: unable to handle kernel paging request at 00000000417683c0
IP: [<ffffffff8105c834>] update_curr+0x124/0x1e0
PGD 41a796067 PUD 0
Thread overran stack, or stack corrupted
Oops: 0000 [#1] SMP
last sysfs file: /sys/devices/system/cpu/cpu15/cache/index2/shared_cpu_map

The bug was fixed by:
      1dbd195 (tracing: Fix preempt count leak)

Signed-off-by: Li Wang <liwang@redhat.com>
---
 .../ftrace_panic_with_userstacktrace.sh            | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_regression/ftrace_panic_with_userstacktrace.sh

diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression/ftrace_panic_with_userstacktrace.sh b/testcases/kernel/tracing/ftrace_test/ftrace_regression/ftrace_panic_with_userstacktrace.sh
new file mode 100755
index 0000000..10ed16a
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_regression/ftrace_panic_with_userstacktrace.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+
+###############################################################################
+#                                                                             #
+# Copyright (c) 2015, Red Hat Inc.                                            #
+#                                                                             #
+# This program is free software; you can redistribute it and/or modify it     #
+# under the terms of the GNU General Public License as published by the Free  #
+# Software Foundation; either version 2 of the License, or (at your option)   #
+# any later version.                                                          #
+#                                                                             #
+# Summary:                                                                    #
+#      panic while using userstacktrace                                       #
+#                                                                             #
+# This is a regression case for commit:                                       #
+#      1dbd195 tracing: Fix preempt count leak                                #
+###############################################################################
+
+LOOP=10
+
+TSTACK_TRACE_PATH=/proc/sys/kernel/stack_tracer_enabled
+
+cd $TRACING_PATH
+
+grep -q CONFIG_STACK_TRACER=y /boot/config-`uname -r`
+if [ $? -ne 0 ];then
+	echo "Stack Tracer is not cofigured in This kernel. Skip the test"
+else
+	for ((i = 0; i < $LOOP; i++))
+	{
+		echo 1 >  $TSTACK_TRACE_PATH
+		echo userstacktrace > trace_options
+		grep -q "^userstacktrace"  trace_options
+
+		if [ -f "events/exceptions/page_fault_kernel/enable" ]; then
+			PAGE_FAULT_KERNEL_ENABLE=`cat events/exceptions/page_fault_kernel/enable`
+			echo 1 > events/exceptions/page_fault_kernel/enable
+		else
+			MM_KERNEL_PAGEFAULT_ENABLE=`cat events/kmem/mm_kernel_pagefault/enable`
+			echo 1 > events/kmem/mm_kernel_pagefault/enable
+		fi
+	}
+
+	if [ -f "events/exceptions/page_fault_kernel/enable" ]; then
+		echo "$PAGE_FAULT_KERNEL_ENABLE" > events/exceptions/page_fault_kernel/enable
+	else
+		echo "$MM_KERNEL_PAGEFAULT_ENABLE" > events/kmem/mm_kernel_pagefault/enable
+	fi
+	# echo "No panic, Still alive."
+fi
+
+cd - > /dev/null
-- 
1.8.3.1

