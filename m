From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 18 Oct 2017 15:49:55 +0200
Subject: [LTP] [RFC PATCH 1/7] net/tcp_cmds: Remove rwho test
In-Reply-To: <20171018135001.30382-1-pvorel@suse.cz>
References: <20171018135001.30382-1-pvorel@suse.cz>
Message-ID: <20171018135001.30382-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

rwhod daemon is way too old to bother to test it.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/net.tcp_cmds                     |  1 -
 testcases/network/tcp_cmds/rwho/Makefile | 31 -----------
 testcases/network/tcp_cmds/rwho/rwho01   | 91 --------------------------------
 3 files changed, 123 deletions(-)
 delete mode 100644 testcases/network/tcp_cmds/rwho/Makefile
 delete mode 100755 testcases/network/tcp_cmds/rwho/rwho01

diff --git a/runtest/net.tcp_cmds b/runtest/net.tcp_cmds
index b7daf9d35..dab7128e8 100644
--- a/runtest/net.tcp_cmds
+++ b/runtest/net.tcp_cmds
@@ -16,7 +16,6 @@ rcp export TCbin=$LTPROOT/testcases/network/tcp_cmds/rcp; rcp01
 rdist export TCbin=$LTPROOT/testcases/network/tcp_cmds/rdist; rdist01
 rlogin rlogin01
 rsh rsh01
-rwho rwho01
 sendfile export TCbin=$LTPROOT/testcases/network/tcp_cmds/sendfile; sendfile01
 tcpdump tcpdump01
 telnet telnet01
diff --git a/testcases/network/tcp_cmds/rwho/Makefile b/testcases/network/tcp_cmds/rwho/Makefile
deleted file mode 100644
index 508fc85e1..000000000
--- a/testcases/network/tcp_cmds/rwho/Makefile
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-#    network/tcp_cmds/rwho testcases Makefile.
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
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= rwho01
-
-MAKE_TARGETS		:=
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/tcp_cmds/rwho/rwho01 b/testcases/network/tcp_cmds/rwho/rwho01
deleted file mode 100755
index 9842aba7a..000000000
--- a/testcases/network/tcp_cmds/rwho/rwho01
+++ /dev/null
@@ -1,91 +0,0 @@
-#!/bin/sh
-# Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
-# Copyright (c) International Business Machines  Corp., 2000
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
-#
-# PURPOSE: To test the basic functionality of the rwhod daemon using the
-#          `rwho` and `ruptime` commands.
-#
-
-TCID=rwho01
-TST_TOTAL=25
-TST_CLEANUP="do_cleanup"
-
-. test_net.sh
-
-LHOST_PID=
-RHOST_PID=
-
-do_setup()
-{
-	tst_check_cmds cut hostname killall rwho ruptime
-
-	LHOST=$(hostname | cut -f1 -d.)
-
-	pgrep -x rwhod > /dev/null
-	if [ $? -ne 0 ]; then
-		tst_resm TINFO "Starting rwhod on $LHOST"
-		ROD rwhod
-		LHOST_PID=$(pgrep -x rwhod)
-		[ -z "$LHOST_PID" ] && \
-			tst_brkm TBROK "Unable to start rwhod on $LHOST"
-	fi
-
-	tst_rhost_run -c "pgrep -x rwhod" > /dev/null
-	if [ $? -ne 0 ]; then
-		tst_resm TINFO "Starting rwhod on $RHOST"
-		tst_rhost_run -s -c "rwhod"
-		RHOST_PID=$(tst_rhost_run -c "pgrep -x rwhod")
-		[ -z "$RHOST_PID" ] && \
-			tst_brkm TBROK "Unable to start rwhod on $RHOST"
-	fi
-
-	RHOSTNAME=$(tst_rhost_run -c "hostname | cut -f1 -d.")
-	[ "$RHOSTNAME" ] || tst_brkm TBROK "Unable to determine RHOSTNAME"
-}
-
-do_test()
-{
-	rwho -a | grep -q $LHOST || \
-		tst_brkm TFAIL "$LHOST isn't in rwho output"
-	rwho -a | grep -q $RHOSTNAME || \
-		tst_brkm TFAIL "$RHOSTNAME isn't in rwho output"
-	ruptime -a | grep -q $LHOST || \
-		tst_brkm TFAIL "$LHOST is not in ruptime outfile"
-	ruptime -a | grep -q $RHOSTNAME || \
-		tst_brkm TFAIL "$RHOSTNAME is not in ruptime outfile"
-}
-
-do_cleanup()
-{
-	if [ "$LHOST_PID" ]; then
-		tst_resm TINFO "Stopping rwhod on $LHOST"
-		killall rwhod
-	fi
-
-	if [ "$RHOST_PID" ]; then
-		tst_resm TINFO "Stopping rwhod on $RHOST"
-		tst_rhost_run -c "killall rwhod"
-	fi
-}
-
-do_setup
-
-for i in $(seq 1 $TST_TOTAL); do
-	do_test
-	tst_resm TPASS "Test $i/$TST_COUNT complete"
-done
-
-tst_exit
-- 
2.14.2

