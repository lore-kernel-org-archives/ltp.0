From: Chunyu Hu <chuhu@redhat.com>
Date: Mon, 18 Apr 2016 16:04:10 +0800
Subject: [LTP] [PATCH V2 3/9] tracing/ftrace: add a new case for
	signal_generate
In-Reply-To: <1460966656-28328-3-git-send-email-chuhu@redhat.com>
References: <1460966656-28328-1-git-send-email-chuhu@redhat.com>
 <1460966656-28328-2-git-send-email-chuhu@redhat.com>
 <1460966656-28328-3-git-send-email-chuhu@redhat.com>
Message-ID: <1460966656-28328-4-git-send-email-chuhu@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Li Wang <liwang@redhat.com>

PURPOSE: check signal:signal_generate gives 2 more fields: grp res

This testcase is writing for signal events change:
       6c303d3 tracing: let trace_signal_generate() report more info...
       163566f tracing: send_sigqueue() needs trace_signal_generate() too

Signed-off-by: Li Wang <liwang@redhat.com>
---
 runtest/tracing                                    |  1 +
 .../tracing/ftrace_test/ftrace_regression02.sh     | 67 ++++++++++++++++++++++
 2 files changed, 68 insertions(+)
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh

diff --git a/runtest/tracing b/runtest/tracing
index fb82515..9f8d5c8 100644
--- a/runtest/tracing
+++ b/runtest/tracing
@@ -1,3 +1,4 @@
 #DESCRIPTION:Tracing testing
 ftrace_regression01	ftrace_regression01.sh
+ftrace_regression02	ftrace_regression02.sh
 ftrace-stress-test	ftrace_stress_test.sh 90
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh b/testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh
new file mode 100755
index 0000000..c30bf29
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh
@@ -0,0 +1,67 @@
+#! /bin/sh
+
+###########################################################################
+##                                                                       ##
+## Copyright (c) 2015, Red Hat Inc.                                      ##
+##                                                                       ##
+## This program is free software: you can redistribute it and/or modify  ##
+## it under the terms of the GNU General Public License as published by  ##
+## the Free Software Foundation, either version 3 of the License, or     ##
+## (at your option) any later version.                                   ##
+##                                                                       ##
+## This program is distributed in the hope that it will be useful,       ##
+## but WITHOUT ANY WARRANTY; without even the implied warranty of        ##
+## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the          ##
+## GNU General Public License for more details.                          ##
+##                                                                       ##
+## You should have received a copy of the GNU General Public License     ##
+## along with this program. If not, see <http://www.gnu.org/licenses/>.  ##
+##                                                                       ##
+## Author: Li Wang <liwang@redhat.com>                                   ##
+##                                                                       ##
+###########################################################################
+##                                                                       ##
+## Summary: check signal:signal_generate gives 2 more fields: grp res    ##
+##                                                                       ##
+## This testcase is writing for signal events change:                    ##
+##       6c303d3 tracing: let trace_signal_generate() report more info...##
+##       163566f tracing: send_sigqueue() needs trace_signal_generate()  ##
+##                                                                       ##
+###########################################################################
+
+export TCID="ftrace_regression02"
+export TST_TOTAL=1
+
+. ftrace_lib.sh
+
+ftrace_signal_test()
+{
+	# Set envent
+	echo 'signal:signal_generate' > $TRACING_PATH/set_event
+	echo 1 > $TRACING_PATH/tracing_on
+	echo > $TRACING_PATH/trace
+
+	# just to generate trace
+	for i in $(seq 100); do
+		ls -l /proc > /dev/null 2>&1
+	done
+
+	grep -q 'grp=[0-9] res=[0-9]' $TRACING_PATH/trace
+	if [ $? -eq 0 ]; then
+		tst_resm TPASS "finished running the test."
+	else
+		tst_resm TFAIL "running the test failed, please check log message."
+	fi
+}
+
+#-----Test Start--------
+tst_kvercmp 3 2 0
+if [ $? -eq 0 ]; then
+	tst_brkm TCONF ignored "The test should be run in kernels >= 3.2.0 Skip the test..."
+fi
+
+save_old_setting
+
+ftrace_signal_test
+
+clean_up
-- 
1.8.3.1

