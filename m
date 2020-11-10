From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 10 Nov 2020 19:05:33 +0100
Subject: [LTP] [PATCH v4] tcp_cmds/ping/ping02: Make it compatible with
 Busybox
Message-ID: <20201110180533.28595-1-kory.maincent@bootlin.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The ping from busybox does not have -f parameter, use -i parameter instead.
BusyBox does not accept pattern longer than 2 bytes.
BusyBox support -i option since version 1.30

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes since v1:
 - Use "-i 0.01 -p aa" parameter instead of "-f"

Changes since v2:
 - Use "-i 0.01 -p aa" only in the case of "-f" parameter is not valid

Changes since v3:
 - Test if -i is a valid option.
 - Move all in do_setup function

 testcases/network/tcp_cmds/ping/ping02.sh | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/testcases/network/tcp_cmds/ping/ping02.sh b/testcases/network/tcp_cmds/ping/ping02.sh
index e0a63c5f6..d4290c873 100755
--- a/testcases/network/tcp_cmds/ping/ping02.sh
+++ b/testcases/network/tcp_cmds/ping/ping02.sh
@@ -16,19 +16,26 @@ do_setup()
 	PING=ping${TST_IPV6}
 
 	tst_require_cmds $PING
+
+	ping_opts="-f -p 000102030405060708090a0b0c0d0e0f"
+	ipaddr=$(tst_ipaddr rhost)
+
+	if ! $PING -c 1 -f $ipaddr >/dev/null 2>&1; then
+		ping_opts="-i 0.01 -p aa"
+		if $PING -i 2>&1 | grep -q "invalid option"; then
+			tst_brk TCONF "unsupported ping version (old busybox?)"
+		fi
+	fi
 }
 
 do_test()
 {
-	local pat="000102030405060708090a0b0c0d0e0f"
-
-	tst_res TINFO "flood $PING: ICMP packets filled with pattern '$pat'"
-
-	local ipaddr=$(tst_ipaddr rhost)
 	local s
 
+	tst_res TINFO "flood $PING: ICMP packets with options '$ping_opts'"
+
 	for s in $PACKETSIZES; do
-		EXPECT_PASS $PING -c $COUNT -f -s $s $ipaddr -p "$pat" \>/dev/null
+		EXPECT_PASS $PING -c $COUNT -s $s $ipaddr $ping_opts \>/dev/null
 	done
 }
 
-- 
2.17.1

