From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue,  8 Dec 2020 19:24:40 +0300
Subject: [LTP] [PATCH 2/2] network/ping02: use tst_ping() from the library
In-Reply-To: <20201208162440.14538-1-alexey.kodanev@oracle.com>
References: <20201208162440.14538-1-alexey.kodanev@oracle.com>
Message-ID: <20201208162440.14538-2-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/tcp_cmds/ping/ping02.sh | 30 ++---------------------
 1 file changed, 2 insertions(+), 28 deletions(-)

diff --git a/testcases/network/tcp_cmds/ping/ping02.sh b/testcases/network/tcp_cmds/ping/ping02.sh
index d4290c873..07a713531 100755
--- a/testcases/network/tcp_cmds/ping/ping02.sh
+++ b/testcases/network/tcp_cmds/ping/ping02.sh
@@ -2,41 +2,15 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2016-2019 Oracle and/or its affiliates. All Rights Reserved.
 
-TST_SETUP="do_setup"
 TST_TESTFUNC="do_test"
 TST_NEEDS_ROOT=1
 
 . tst_net.sh
 
-do_setup()
-{
-	COUNT=${COUNT:-3}
-	PACKETSIZES=${PACKETSIZES:-"8 16 32 64 128 256 512 1024 2048 4064"}
-
-	PING=ping${TST_IPV6}
-
-	tst_require_cmds $PING
-
-	ping_opts="-f -p 000102030405060708090a0b0c0d0e0f"
-	ipaddr=$(tst_ipaddr rhost)
-
-	if ! $PING -c 1 -f $ipaddr >/dev/null 2>&1; then
-		ping_opts="-i 0.01 -p aa"
-		if $PING -i 2>&1 | grep -q "invalid option"; then
-			tst_brk TCONF "unsupported ping version (old busybox?)"
-		fi
-	fi
-}
-
 do_test()
 {
-	local s
-
-	tst_res TINFO "flood $PING: ICMP packets with options '$ping_opts'"
-
-	for s in $PACKETSIZES; do
-		EXPECT_PASS $PING -c $COUNT -s $s $ipaddr $ping_opts \>/dev/null
-	done
+	tst_ping -s "${PACKETSIZES:-8 16 32 64 128 256 512 1024 2048 4064}" \
+		 -p "000102030405060708090a0b0c0d0e0f" -c "${COUNT:-3}"
 }
 
 tst_run
-- 
2.20.1

