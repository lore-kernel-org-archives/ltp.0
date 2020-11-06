From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri,  6 Nov 2020 15:36:05 +0100
Subject: [LTP] [PATCH v2] tcp_cmds/ping/ping02: Make it compatible with
 Busybox
Message-ID: <20201106143605.27230-1-kory.maincent@bootlin.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The ping from busybox does not have -f parameter, use -i parameter instead.
BusyBox does not accept pattern longer than 2 bytes.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 testcases/network/tcp_cmds/ping/ping02.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/network/tcp_cmds/ping/ping02.sh b/testcases/network/tcp_cmds/ping/ping02.sh
index e0a63c5f6..2784c8160 100755
--- a/testcases/network/tcp_cmds/ping/ping02.sh
+++ b/testcases/network/tcp_cmds/ping/ping02.sh
@@ -20,7 +20,7 @@ do_setup()
 
 do_test()
 {
-	local pat="000102030405060708090a0b0c0d0e0f"
+	local pat="aa"
 
 	tst_res TINFO "flood $PING: ICMP packets filled with pattern '$pat'"
 
@@ -28,7 +28,7 @@ do_test()
 	local s
 
 	for s in $PACKETSIZES; do
-		EXPECT_PASS $PING -c $COUNT -f -s $s $ipaddr -p "$pat" \>/dev/null
+		EXPECT_PASS $PING -c $COUNT -i 0.001 -s $s $ipaddr -p "$pat" \>/dev/null
 	done
 }
 
-- 
2.17.1

