From: Kory Maincent <kory.maincent@bootlin.com>
Date: Mon,  9 Nov 2020 20:16:18 +0100
Subject: [LTP] [PATCH v3] tcp_cmds/ping/ping02: Make it compatible with
 Busybox
Message-ID: <20201109191618.4442-1-kory.maincent@bootlin.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The ping from busybox does not have -f parameter, use -i parameter instead.
BusyBox does not accept pattern longer than 2 bytes.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes since v1:
 - Use "-i 0.01 -p aa" parameter instead of "-f"

Changes since v2:
 - Use "-i 0.01 -p aa" only in the case of "-f" parameter is not valid

 testcases/network/tcp_cmds/ping/ping02.sh | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/testcases/network/tcp_cmds/ping/ping02.sh b/testcases/network/tcp_cmds/ping/ping02.sh
index e0a63c5f6..80346c552 100755
--- a/testcases/network/tcp_cmds/ping/ping02.sh
+++ b/testcases/network/tcp_cmds/ping/ping02.sh
@@ -20,15 +20,16 @@ do_setup()
 
 do_test()
 {
-	local pat="000102030405060708090a0b0c0d0e0f"
-
-	tst_res TINFO "flood $PING: ICMP packets filled with pattern '$pat'"
-
+	local ping_opts="-f -p 000102030405060708090a0b0c0d0e0f"
 	local ipaddr=$(tst_ipaddr rhost)
 	local s
 
+	$PING -c 1 -f $ipaddr >/dev/null 2>&1 || ping_opts="-i 0.01 -p aa"
+
+	tst_res TINFO "flood $PING: ICMP packets with options '$ping_opts'"
+
 	for s in $PACKETSIZES; do
-		EXPECT_PASS $PING -c $COUNT -f -s $s $ipaddr -p "$pat" \>/dev/null
+		EXPECT_PASS $PING -c $COUNT -s $s $ipaddr $ping_opts \>/dev/null
 	done
 }
 
-- 
2.17.1

