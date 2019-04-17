From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 17 Apr 2019 14:47:29 +0300
Subject: [LTP] [PATCH 2/3][COMMITTED] network/clockdiff01: convert to new API
In-Reply-To: <1555501650-16626-1-git-send-email-alexey.kodanev@oracle.com>
References: <1555501650-16626-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1555501650-16626-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Use SPDX-License-Identifier.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/tcp_cmds/clockdiff/Makefile      |   16 +-----
 .../network/tcp_cmds/clockdiff/clockdiff01.sh      |   51 ++++++++------------
 2 files changed, 22 insertions(+), 45 deletions(-)

diff --git a/testcases/network/tcp_cmds/clockdiff/Makefile b/testcases/network/tcp_cmds/clockdiff/Makefile
index 3b212a9..d2e7251 100644
--- a/testcases/network/tcp_cmds/clockdiff/Makefile
+++ b/testcases/network/tcp_cmds/clockdiff/Makefile
@@ -1,17 +1,5 @@
-# Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program. If not, see <http://www.gnu.org/licenses/>.
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2016-2019 Oracle and/or its affiliates. All Rights Reserved.
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/network/tcp_cmds/clockdiff/clockdiff01.sh b/testcases/network/tcp_cmds/clockdiff/clockdiff01.sh
index e664391..db1b8d5 100755
--- a/testcases/network/tcp_cmds/clockdiff/clockdiff01.sh
+++ b/testcases/network/tcp_cmds/clockdiff/clockdiff01.sh
@@ -1,42 +1,31 @@
 #!/bin/sh
-# Copyright (c) 2016-2017 Oracle and/or its affiliates. All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program. If not, see <http://www.gnu.org/licenses/>.
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2016-2019 Oracle and/or its affiliates. All Rights Reserved.
 #
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
-TCID=clockdiff01
-TST_TOTAL=1
-TST_USE_LEGACY_API=1
-. tst_net.sh
+TST_TESTFUNC="do_test"
+TST_NEEDS_ROOT=1
+TST_NEEDS_CMDS="cut clockdiff"
 
-tst_require_root
-tst_test_cmds cut clockdiff
+. tst_net.sh
 
-tst_resm TINFO "check time delta for $(tst_ipaddr)"
+do_test()
+{
+	tst_res TINFO "check time delta for $(tst_ipaddr)"
 
-output=$(clockdiff $(tst_ipaddr))
+	local output=$(clockdiff $(tst_ipaddr))
 
-if [ $? -ne 0 ]; then
-	tst_resm TFAIL "clockdiff failed to get delta"
-else
-	delta=$(echo "$output" | cut -d' ' -f2,3)
-	if [ "$delta" = "0 0" ]; then
-		tst_resm TPASS "delta is 0 as expected"
+	if [ $? -ne 0 ]; then
+		tst_res TFAIL "clockdiff failed to get delta"
 	else
-		tst_resm TFAIL "not expected data received: '$output'"
+		delta=$(echo "$output" | cut -d' ' -f2,3)
+		if [ "$delta" = "0 0" ]; then
+			tst_res TPASS "delta is 0 as expected"
+		else
+			tst_res TFAIL "not expected data received: '$output'"
+		fi
 	fi
-fi
+}
 
-tst_exit
+tst_run
-- 
1.7.1

