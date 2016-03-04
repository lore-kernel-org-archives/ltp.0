From: Li Wang <liwang@redhat.com>
Date: Fri,  4 Mar 2016 16:24:54 +0800
Subject: [LTP] [PATCH RFC 5/9] ftrace_regression: add a new testcase
In-Reply-To: <1457079898-9449-5-git-send-email-liwang@redhat.com>
References: <1457079898-9449-1-git-send-email-liwang@redhat.com>
 <1457079898-9449-2-git-send-email-liwang@redhat.com>
 <1457079898-9449-3-git-send-email-liwang@redhat.com>
 <1457079898-9449-4-git-send-email-liwang@redhat.com>
 <1457079898-9449-5-git-send-email-liwang@redhat.com>
Message-ID: <1457079898-9449-6-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

PURPOSE: check signal:signal_generate gives 2 more fields: grp res

This testcase is writing for signal events change:
       6c303d3 tracing: let trace_signal_generate() report more info...
       163566f tracing: send_sigqueue() needs trace_signal_generate() too

Signed-off-by: Li Wang <liwang@redhat.com>
---
 .../ftrace_enhanced_signal_tracepoint.sh           | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_regression/ftrace_enhanced_signal_tracepoint.sh

diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression/ftrace_enhanced_signal_tracepoint.sh b/testcases/kernel/tracing/ftrace_test/ftrace_regression/ftrace_enhanced_signal_tracepoint.sh
new file mode 100755
index 0000000..36fc2ba
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_regression/ftrace_enhanced_signal_tracepoint.sh
@@ -0,0 +1,35 @@
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
+# PURPOSE: check signal:signal_generate gives 2 more fields: grp res          #
+#                                                                             #
+# This testcase is verifing signal events change:                             #
+#        6c303d3 tracing: let trace_signal_generate() report more info...     #
+#        163566f tracing: send_sigqueue() needs trace_signal_generate() too   #
+#                                                                             #
+###############################################################################
+
+
+# Set envent
+echo 'signal:signal_generate' > $TRACING_PATH/set_event
+
+echo 1 > $TRACING_PATH/tracing_on
+
+echo > $TRACING_PATH/trace
+
+sleep 10
+
+grep -q 'grp=[0-9] res=[0-9]' $TRACING_PATH/trace
+if [ $? -eq 0 ]; then
+	exit 0
+else
+	exit 1
+fi
-- 
1.8.3.1

