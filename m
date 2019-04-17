From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 17 Apr 2019 14:47:30 +0300
Subject: [LTP] [PATCH 3/3][COMMITTED] network/ping{01|02}: convert to new
	API with improvements
In-Reply-To: <1555501650-16626-1-git-send-email-alexey.kodanev@oracle.com>
References: <1555501650-16626-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1555501650-16626-3-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Use SPDX-License-Identifier.

* Make the variables in the for loop to be local.

* ping01: set minimum possible interval without super user privileges:
  test time decreased from 20 seconds to 4 seconds.

* ping02: test uses flood ping with zero interval, so add "needs root".

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/tcp_cmds/ping/Makefile  |   21 +--------------
 testcases/network/tcp_cmds/ping/ping01.sh |   34 +++++++-----------------
 testcases/network/tcp_cmds/ping/ping02.sh |   39 +++++++++-------------------
 3 files changed, 25 insertions(+), 69 deletions(-)

diff --git a/testcases/network/tcp_cmds/ping/Makefile b/testcases/network/tcp_cmds/ping/Makefile
index 703f8ce..f8293e5 100644
--- a/testcases/network/tcp_cmds/ping/Makefile
+++ b/testcases/network/tcp_cmds/ping/Makefile
@@ -1,24 +1,7 @@
-#
-#    network/tcp_cmds/ping testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 #
 # Ngie Cooper, July 2009
-#
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/network/tcp_cmds/ping/ping01.sh b/testcases/network/tcp_cmds/ping/ping01.sh
index e127481..916f057 100755
--- a/testcases/network/tcp_cmds/ping/ping01.sh
+++ b/testcases/network/tcp_cmds/ping/ping01.sh
@@ -1,20 +1,8 @@
 #! /bin/sh
-# Copyright (c) 2014-2016 Oracle and/or its affiliates. All Rights Reserved.
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2014-2019 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2000
 #
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
-#
 #  PURPOSE: To test the basic functionality of the `ping` command.
 #
 #  SETUP: If "RHOST" is not exported, then the local hostname is used.
@@ -25,10 +13,9 @@
 #    03/01 Robbie Williamson (robbiew@us.ibm.com)
 #      -Ported
 
-TST_TOTAL=10
-TCID="ping01"
+TST_SETUP="do_setup"
+TST_TESTFUNC="do_test"
 
-TST_USE_LEGACY_API=1
 . tst_net.sh
 
 do_setup()
@@ -43,14 +30,13 @@ do_setup()
 
 do_test()
 {
-	tst_resm TINFO "$PING_CMD with $PACKETSIZES ICMP packets"
+	tst_res TINFO "$PING_CMD with $PACKETSIZES ICMP packets"
 	local ipaddr=$(tst_ipaddr rhost)
-	for packetsize in $PACKETSIZES; do
-		EXPECT_PASS $PING_CMD -c $COUNT -s $packetsize $ipaddr \>/dev/null
+	local s
+
+	for s in $PACKETSIZES; do
+		EXPECT_PASS $PING_CMD -i 0.2 -c $COUNT -s $s $ipaddr \>/dev/null
 	done
 }
 
-do_setup
-do_test
-
-tst_exit
+tst_run
diff --git a/testcases/network/tcp_cmds/ping/ping02.sh b/testcases/network/tcp_cmds/ping/ping02.sh
index 04069f2..b245210 100755
--- a/testcases/network/tcp_cmds/ping/ping02.sh
+++ b/testcases/network/tcp_cmds/ping/ping02.sh
@@ -1,23 +1,11 @@
 #! /bin/sh
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
-
-TST_TOTAL=10
-TCID="ping02"
-
-TST_USE_LEGACY_API=1
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2016-2019 Oracle and/or its affiliates. All Rights Reserved.
+
+TST_SETUP="do_setup"
+TST_TESTFUNC="do_test"
+TST_NEEDS_ROOT=1
+
 . tst_net.sh
 
 do_setup()
@@ -34,15 +22,14 @@ do_test()
 {
 	local pat="000102030405060708090a0b0c0d0e0f"
 
-	tst_resm TINFO "flood $PING: ICMP packets filled with pattern '$pat'"
+	tst_res TINFO "flood $PING: ICMP packets filled with pattern '$pat'"
 
 	local ipaddr=$(tst_ipaddr rhost)
-	for psize in $PACKETSIZES; do
-		EXPECT_PASS $PING -c $COUNT -f -s $psize $ipaddr -p "$pat" \>/dev/null
+	local s
+
+	for s in $PACKETSIZES; do
+		EXPECT_PASS $PING -c $COUNT -f -s $s $ipaddr -p "$pat" \>/dev/null
 	done
 }
 
-do_setup
-do_test
-
-tst_exit
+tst_run
-- 
1.7.1

