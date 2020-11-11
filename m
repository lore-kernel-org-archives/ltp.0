From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 11 Nov 2020 15:40:05 +0100
Subject: [LTP] [PATCH v4] tcp_cmds/ping/ping02: Make it compatible with
 Busybox
In-Reply-To: <20201110180533.28595-1-kory.maincent@bootlin.com>
References: <20201110180533.28595-1-kory.maincent@bootlin.com>
Message-ID: <20201111144005.GA3358@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Kory, Alexey,

> The ping from busybox does not have -f parameter, use -i parameter instead.
> BusyBox does not accept pattern longer than 2 bytes.
> BusyBox support -i option since version 1.30

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>

LGTM.

I suggest to merge with few changes below.

* more precise message "ping from old busybox?"
* use just $(tst_ipaddr rhost) instead of $ipaddr
(some time ago we've started to use function calls for these simple evaluations)
* upper case for global variable (ugly, but easily recognizable

Kind regards,
Petr

diff --git testcases/network/tcp_cmds/ping/ping02.sh testcases/network/tcp_cmds/ping/ping02.sh
index d4290c873..acf2737bf 100755
--- testcases/network/tcp_cmds/ping/ping02.sh
+++ testcases/network/tcp_cmds/ping/ping02.sh
@@ -17,13 +17,12 @@ do_setup()
 
 	tst_require_cmds $PING
 
-	ping_opts="-f -p 000102030405060708090a0b0c0d0e0f"
-	ipaddr=$(tst_ipaddr rhost)
+	PING_OPTS="-f -p 000102030405060708090a0b0c0d0e0f"
 
-	if ! $PING -c 1 -f $ipaddr >/dev/null 2>&1; then
-		ping_opts="-i 0.01 -p aa"
+	if ! $PING -c 1 -f $(tst_ipaddr rhost) >/dev/null 2>&1; then
+		PING_OPTS="-i 0.01 -p aa"
 		if $PING -i 2>&1 | grep -q "invalid option"; then
-			tst_brk TCONF "unsupported ping version (old busybox?)"
+			tst_brk TCONF "unsupported ping version (ping from old busybox?)"
 		fi
 	fi
 }
@@ -32,10 +31,10 @@ do_test()
 {
 	local s
 
-	tst_res TINFO "flood $PING: ICMP packets with options '$ping_opts'"
+	tst_res TINFO "flood $PING: ICMP packets with options '$PING_OPTS'"
 
 	for s in $PACKETSIZES; do
-		EXPECT_PASS $PING -c $COUNT -s $s $ipaddr $ping_opts \>/dev/null
+		EXPECT_PASS $PING -c $COUNT -s $s $(tst_ipaddr rhost) $PING_OPTS \>/dev/null
 	done
 }
 
