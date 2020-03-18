From: Cixi Geng <gengcixi@gmail.com>
Date: Wed, 18 Mar 2020 13:31:19 +0800
Subject: [LTP] [PATCH] uart: add uart testcase in kernel device-driver
Message-ID: <CAF12kFsKiR8XFW2WhMuNs7VYEGh8Sj=oaQHC05uc689vAcmarA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Porting UART test from ltp-ddt back to ltp. only test 115200 UART_RATE.

[TODO] support more rate, and add test HWFLOW function test.

Signed-off-by: Orson Zhai <orson@gmail.com>
Signed-off-by: Cixi Geng <gengcixi@gmail.com>
---
 runtest/kernel_ddt                            |   1 +
 testcases/kernel/device-drivers/Makefile      |   1 +
 testcases/kernel/device-drivers/uart/Makefile |  22 ++++
 .../kernel/device-drivers/uart/serialcheck.sh | 111 ++++++++++++++++++
 4 files changed, 135 insertions(+)
 create mode 100644 runtest/kernel_ddt
 create mode 100644 testcases/kernel/device-drivers/uart/Makefile
 create mode 100755 testcases/kernel/device-drivers/uart/serialcheck.sh

diff --git a/runtest/kernel_ddt b/runtest/kernel_ddt
new file mode 100644
index 000000000..30e9a0269
--- /dev/null
+++ b/runtest/kernel_ddt
@@ -0,0 +1 @@
+uart serialcheck.sh
diff --git a/testcases/kernel/device-drivers/Makefile
b/testcases/kernel/device-drivers/Makefile
index 55e0d25a0..a214f211b 100644
--- a/testcases/kernel/device-drivers/Makefile
+++ b/testcases/kernel/device-drivers/Makefile
@@ -27,6 +27,7 @@ SUBDIRS := acpi \
    rtc \
    tbio \
    uaccess \
+   uart \
    zram

 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/device-drivers/uart/Makefile
b/testcases/kernel/device-drivers/uart/Makefile
new file mode 100644
index 000000000..0d73f6635
--- /dev/null
+++ b/testcases/kernel/device-drivers/uart/Makefile
@@ -0,0 +1,22 @@
+# Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+
+top_srcdir ?= ../../../..
+include $(top_srcdir)/include/mk/testcases.mk
+
+INSTALL_TARGETS := *.sh
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/device-drivers/uart/serialcheck.sh
b/testcases/kernel/device-drivers/uart/serialcheck.sh
new file mode 100755
index 000000000..f4cf13e02
--- /dev/null
+++ b/testcases/kernel/device-drivers/uart/serialcheck.sh
@@ -0,0 +1,111 @@
+#!/bin/sh
+###############################################################################
+#
+# Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com/
+# Copyright (C) 2019, Unisoc Communications Inc.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation version 2.
+#
+# This program is distributed "as is" WITHOUT ANY WARRANTY of any
+# kind, whether express or implied; without even the implied warranty
+# of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+###############################################################################
+
+# @desc Test UART ports using git://
git.breakpoint.cc/bigeasy/serialcheck.git
+
+#### Functions definitions ####
+usage()
+{
+    echo "usage: ./${0##*/} [-r UART_RATE] [-l LOOPS] [-x to enable HW
flow control]"
+    exit 1
+}
+
+# Default values
+: ${UART_RATE:=115200}
+: ${UART_LOOPS:=5}
+: ${UART_HWFLOW:=0}
+
+PORTS_TO_TEST=();
+UART_PORTS=();
+ARRAY=(`find /sys/class/tty/*/uartclk`);
+
+check_requirements()
+{
+ which serialcheck
+ ret=$?
+ if [ $ret -eq 0 ];then
+ tst_res TINFO "serialcheck command is in system,continue to test"
+ else
+ tst_brk TCONF "test failed for lack of requirement,returned is $ret"
+ fi
+
+}
+
+create_test_file()
+{
+    temp_test_file=`mktemp`
+    dd if=/dev/urandom of=$temp_test_file count=1 bs=$((UART_RATE / 2))
+}
+
+get_uart_ports()
+{
+for i in ${ARRAY[@]}; do
+    PORT=/dev/`echo $i | cut -d'/' -f 5`
+    # Activate port in case it will be initialized only when startup
+    echo "DDT TESTING" > $PORT 2>/dev/null
+    if [ `cat $i` -ne 0 ]; then
+        UART_PORTS=("${UART_PORTS[@]}" "$PORT")
+    fi
+done
+}
+
+filter_out_used_ports()
+{
+ which lsof
+ ret=$?
+ if [ $ret -eq 0 ];then
+ tst_res TINFO "lsof command exist, filter out used ports";
+ else
+ tst_brk TCONF "test failed for lack of requirement,returned is $ret"
+ fi
+
+    for i in ${UART_PORTS[@]}; do
+        lsof | grep $i &> /dev/null ||
PORTS_TO_TEST=("${PORTS_TO_TEST[@]}" $i)
+    done
+}
+
+run_serial_test()
+{
+ create_test_file
+    for i in ${PORTS_TO_TEST[@]}; do
+        if [ $UART_HWFLOW -eq 0 ]; then
+            { sleep 1; serialcheck -b $UART_RATE -d $i -f $temp_test_file
-l $UART_LOOPS -m t -k; }&
+            PID=$!
+            serialcheck -b $UART_RATE -d $i -f $temp_test_file -l
$UART_LOOPS -m r -k || { kill -- -$PID 2>/dev/null; tst_res TFAIL "TEST
FAILED"; }
+        else
+            { sleep 1; serialcheck -b $UART_RATE -d $i -f $temp_test_file
-l $UART_LOOPS -m t -h; } &
+            PID=$!
+            serialcheck -b $UART_RATE -d $i -f $temp_test_file -l
$UART_LOOPS -m r -h || { kill -- -$PID 2>/dev/null; tst_res TFAIL "TEST
FAILED"; }
+        fi
+    done
+    rm $temp_test_file
+ tst_res TPASS "uart test passed"
+}
+
+
+TST_TESTFUNC=do_test
+. tst_test.sh
+
+do_test()
+{
+ check_requirements
+ get_uart_ports
+ filter_out_used_ports
+ run_serial_test
+}
+
+tst_run
-- 
2.17.1
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200318/cce05c12/attachment-0001.htm>
