From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 17 Apr 2019 14:47:28 +0300
Subject: [LTP] [PATCH 1/3][COMMITTED] network/arping01: convert to new API
Message-ID: <1555501650-16626-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Use SPDX-License-Identifier.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/tcp_cmds/arping/Makefile    |   16 +-------
 testcases/network/tcp_cmds/arping/arping01.sh |   49 ++++++++-----------------
 2 files changed, 17 insertions(+), 48 deletions(-)

diff --git a/testcases/network/tcp_cmds/arping/Makefile b/testcases/network/tcp_cmds/arping/Makefile
index 9af15b3..6852542 100644
--- a/testcases/network/tcp_cmds/arping/Makefile
+++ b/testcases/network/tcp_cmds/arping/Makefile
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
 
diff --git a/testcases/network/tcp_cmds/arping/arping01.sh b/testcases/network/tcp_cmds/arping/arping01.sh
index 774dbc1..d9c79f6 100755
--- a/testcases/network/tcp_cmds/arping/arping01.sh
+++ b/testcases/network/tcp_cmds/arping/arping01.sh
@@ -1,42 +1,23 @@
 #!/bin/sh
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
 #
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
-TCID=arping01
-TST_TOTAL=1
-TST_USE_LEGACY_API=1
-. tst_net.sh
+TST_TESTFUNC="do_test"
+TST_NEEDS_ROOT=1
+TST_NEEDS_CMDS="arping"
 
-tst_require_root
-tst_test_cmds arping
-
-timeout="10"
-ip_addr=$(tst_ipaddr rhost)
-dev=$(tst_iface)
-
-tst_resm TINFO "arping host '$RHOST' with ip '$ip_addr' dev '$dev'"
-tst_resm TINFO "with timeout '$timeout' seconds"
+. tst_net.sh
 
-arping -w $timeout "$ip_addr" -I $dev -fq
+do_test()
+{
+	local timeout="10"
+	local ip_addr=$(tst_ipaddr rhost)
+	local dev=$(tst_iface)
 
-if [ $? -ne 0 ]; then
-	tst_resm TFAIL "arping to '$RHOST' failed"
-else
-	tst_resm TPASS "done"
-fi
+	tst_res TINFO "arping host '$ip_addr' via dev '$dev' with timeout '$timeout' secs"
+	EXPECT_PASS arping -w $timeout "$ip_addr" -I $dev -fq
+}
 
-tst_exit
+tst_run
-- 
1.7.1

