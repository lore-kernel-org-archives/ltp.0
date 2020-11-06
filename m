From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri,  6 Nov 2020 11:37:48 +0100
Subject: [LTP] [PATCH] tcp_cmds/ping: TCONF on unknown -f parameter
Message-ID: <20201106103748.20241-1-kory.maincent@bootlin.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The ping from busybox does not have -f parameter.
Return TCONF in that case.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 testcases/network/tcp_cmds/ping/ping02.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/network/tcp_cmds/ping/ping02.sh b/testcases/network/tcp_cmds/ping/ping02.sh
index e0a63c5f6..6daf22635 100755
--- a/testcases/network/tcp_cmds/ping/ping02.sh
+++ b/testcases/network/tcp_cmds/ping/ping02.sh
@@ -27,6 +27,10 @@ do_test()
 	local ipaddr=$(tst_ipaddr rhost)
 	local s
 
+	if ! $PING -c 1 -f $ipaddr >/dev/null; then
+		tst_brk TCONF "$PING: invalid option -- 'f'"
+	fi
+
 	for s in $PACKETSIZES; do
 		EXPECT_PASS $PING -c $COUNT -f -s $s $ipaddr -p "$pat" \>/dev/null
 	done
-- 
2.17.1

