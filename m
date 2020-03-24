From: gengcixi@gmail.com <gengcixi@gmail.com>
Date: Tue, 24 Mar 2020 20:17:42 +0800
Subject: [LTP] [PATCH v2] uart: add uart testcase in kernel device-drivers
Message-ID: <20200324121742.7130-1-gengcixi@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Cixi Geng <gengcixi@gmail.com>

Porting UART test from ltp-ddt back to ltp.
rewrite case use ltp library functions instead of ltp-ddt's

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Orson Zhai <orsonzhai@gmail.com>
Signed-off-by: Cixi Geng <gengcixi@gmail.com>
---
changes v2:
    1. support more bandrate test 
    2. move test tags in kernel_misc file 
    3. use TST_NEEDS_CMDS to check lsof,dd and serialcheck command 
    4. remove arrays in bash,rewrite test flow control to adapt dash 
    5. others like License and code-style issues
explatin for v1:
    1. create_test_file should be just 2 lines of code in setup function.
    >>>the test files need have random data,So use create_test_file
    function
    2. why run 2 instances of serialcheck
    >>>run 2 instances is one test send and one test recv, sleep in
    send  for make sure recv instances can get the send data
---
 runtest/kernel_misc                           |  6 ++
 testcases/kernel/device-drivers/Makefile      |  1 +
 testcases/kernel/device-drivers/uart/Makefile | 10 +++
 .../kernel/device-drivers/uart/serialcheck.sh | 68 +++++++++++++++++++
 4 files changed, 85 insertions(+)
 create mode 100644 testcases/kernel/device-drivers/uart/Makefile
 create mode 100755 testcases/kernel/device-drivers/uart/serialcheck.sh

diff --git a/runtest/kernel_misc b/runtest/kernel_misc
index 7937c7bbf..7a077b23b 100644
--- a/runtest/kernel_misc
+++ b/runtest/kernel_misc
@@ -13,3 +13,9 @@ zram01 zram01.sh
 zram02 zram02.sh
 zram03 zram03
 umip_basic_test umip_basic_test
+# uart test in loopback mode
+uart_9600_k serialcheck.sh 9600 5 k
+uart_19200_k serialcheck.sh 19200 5 k
+uart_38400_k serialcheck.sh 38400 5 k
+uart_57600_k  serialcheck.sh 57600 5 k
+uart_115200_k serialcheck.sh 115200 5 k
diff --git a/testcases/kernel/device-drivers/Makefile b/testcases/kernel/device-drivers/Makefile
index 55e0d25a0..a214f211b 100644
--- a/testcases/kernel/device-drivers/Makefile
+++ b/testcases/kernel/device-drivers/Makefile
@@ -27,6 +27,7 @@ SUBDIRS		:= acpi \
 		   rtc \
 		   tbio \
 		   uaccess \
+		   uart \
 		   zram
 
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/device-drivers/uart/Makefile b/testcases/kernel/device-drivers/uart/Makefile
new file mode 100644
index 000000000..2e4781a6b
--- /dev/null
+++ b/testcases/kernel/device-drivers/uart/Makefile
@@ -0,0 +1,10 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2014-2015 Oracle and/or its affiliates. All Rights Reserved.
+
+top_srcdir	?= ../../../..
+include $(top_srcdir)/include/mk/testcases.mk
+
+INSTALL_TARGETS		:= *.sh
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/device-drivers/uart/serialcheck.sh b/testcases/kernel/device-drivers/uart/serialcheck.sh
new file mode 100755
index 000000000..afdc9212f
--- /dev/null
+++ b/testcases/kernel/device-drivers/uart/serialcheck.sh
@@ -0,0 +1,68 @@
+#!/bin/sh
+###############################################################################
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com/
+# Copyright (C) 2019, Unisoc Communications Inc.
+#
+# Test UART ports using git://git.breakpoint.cc/bigeasy/serialcheck.git
+#
+###############################################################################
+
+TST_TESTFUNC=do_test
+TST_POS_ARGS=3
+TST_USAGE=usage
+TST_NEEDS_ROOT=1
+TST_NEEDS_CMDS="serialcheck"
+TST_NEEDS_CMDS="lsof"
+TST_NEEDS_CMDS="dd"
+TST_NEEDS_TMPDIR=1
+
+. tst_test.sh
+
+usage()
+{
+    echo "usage: ./${0} [-r UART_RATE] [-l LOOPS] [-h|k to enable HW flow control or loopback]"
+    exit 1
+}
+
+UART_RATE=$1
+UART_LOOPS=$2
+UART_HWFLOW=$3
+
+create_test_file()
+{
+    temp_test_file=`mktemp`
+    dd if=/dev/urandom of=$temp_test_file count=1 bs=$((UART_RATE / 2))
+}
+
+test_serial()
+{
+    create_test_file
+    { sleep 1; serialcheck -b $UART_RATE -d $1 -f $temp_test_file -l $UART_LOOPS -m t -${UART_HWFLOW}; }&
+    PID=$!
+    serialcheck -b $UART_RATE -d $1 -f $temp_test_file -l $UART_LOOPS -m r -${UART_HWFLOW}
+    if [ $? ];  then
+        kill -- -$PID 2>/dev/null
+        tst_res TFAIL "uart test failed"
+    else
+        tst_res TPASS "uart test passed"
+    fi
+    rm $temp_test_file
+}
+
+do_test()
+{
+    for i in /sys/class/tty/*/uartclk ;do
+        PORT=`echo $i |cut -d '/' -f 5`
+        # Activate port in case it will be initialized only when startup
+        echo "UART TESTING">${PORT} 2>/dev/null
+        if [ `cat /sys/class/tty/${PORT}/uartclk` -ne 0 ]; then
+            lsof | grep "/dev/${PORT}" &> /dev/null || PORT_TO_TEST="/dev/${PORT}"
+            tst_res TINFO "start test on ${PORT_TO_TEST} ${UART_RATE}"
+            test_serial ${PORT_TO_TEST}
+        fi
+    done
+}
+
+tst_run
-- 
2.17.1

