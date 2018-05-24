From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 24 May 2018 13:39:51 +0200
Subject: [LTP] [PATCH v4 1/1] ipneigh : Use new API
In-Reply-To: <20180523132432.20681-1-asmorodskyi@suse.com>
References: <20180523132432.20681-1-asmorodskyi@suse.com>
Message-ID: <20180524113951.n6h7a365pggi3zdq@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Anton,

Thanks for your patch. I'm sorry to propose more changes:
* Thinking about it it'd be better to move creating commands to setup functions. Test
function get clearer by it (I've been told by Cyril several times to do that). I don't
like global shell variables (and upper case variables), but this is the purpose of setup
test function. And it allow us to check for command before (if you use 'ipneigh01.sh -c
foo' you get "unsupported command" first, not "command not found"
* Use tst_brk instead of tst_res, as test is run only once.
* Add command to TINFO.
* Add tst_brk TFAIL for ping (IMHO if you cannot ping the host test will fail so it's
better to reveal that it's due wrong link connection).
* Use $(tst_ipaddr rhost) instead of $rhost to 1) not introduce another global variable.
* Added git tag 'Signed-off-by: Anton Smorodskyi <asmorodskyi@suse.com>'. We use git tags in LTP.
* Add new line.

Bellow is diff, or you can see file online
https://raw.githubusercontent.com/pevik/ltp/anton/ipneigh.v4.fixes/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh

Do you agree with the changes (can I push it like this)?


Kind regards,
Petr

diff --git testcases/network/tcp_cmds/ipneigh/ipneigh01.sh testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
index 61e107a22..31dec6d49 100755
--- testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
+++ testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
@@ -28,6 +28,23 @@ TST_NEEDS_ROOT=1
 
 do_setup()
 {
+	case $CMD in
+	ip)
+		SHOW_CMD="ip neigh show"
+		DEL_CMD="ip neigh del $(tst_ipaddr rhost) dev $(tst_iface)"
+		;;
+	arp)
+		if [ -n "$TST_IPV6" ]; then
+			tst_brk TCONF "'arp' doesn't support IPv6"
+		fi
+		SHOW_CMD="arp -a"
+		DEL_CMD="arp -d $(tst_ipaddr rhost)"
+		;;
+	*)
+		tst_brk TBROK "unknown or missing command, use -c [ arp | ip ]"
+		;;
+	esac
+
 	tst_check_cmds $CMD ping$TST_IPV6
 }
 
@@ -45,39 +62,20 @@ parse_args()
 
 do_test()
 {
-	local rhost=$(tst_ipaddr rhost)
-	case $CMD in
-	ip)
-		local show_cmd="ip neigh show"
-		local del_cmd="ip neigh del $rhost dev $(tst_iface)"
-		;;
-	arp)
-		if [ -n "$TST_IPV6" ]; then
-			tst_res TCONF "'arp cmd doesn't support IPv6, skipping test-case"
-			return 1
-		fi
-		local show_cmd="arp -a"
-		local del_cmd="arp -d $rhost"
-		;;
-	*)
-		tst_res TBROK "-c is missing or have value not from list [ arp | ip ]"
-		return 1
-		;;
-	esac
-
 	local entry_name="ARP"
 	[ "$TST_IPV6" ] && entry_name="NDISC"
 
-	tst_res TINFO "Stress auto-creation of $entry_name cache entry $NUMLOOPS times"
+	tst_res TINFO "stress auto-creation $entry_name cache entry deleted with '$CMD' $NUMLOOPS times"
 
 	for i in $(seq 1 $NUMLOOPS); do
 
-		ping$TST_IPV6 -q -c1 $rhost > /dev/null
+		ping$TST_IPV6 -q -c1 $(tst_ipaddr rhost) > /dev/null || \
+			tst_brk TFAIL "cannot ping $(tst_ipaddr rhost)"
 
 		local k
 		local ret=1
 		for k in $(seq 1 30); do
-			$show_cmd | grep -q $rhost
+			$SHOW_CMD | grep -q $(tst_ipaddr rhost)
 			if [ $? -eq 0 ]; then
 				ret=0
 				break;
@@ -86,11 +84,12 @@ do_test()
 		done
 
 		[ "$ret" -ne 0 ] && \
-			tst_brk TFAIL "$entry_name entry '$rhost' not listed"
-		$del_cmd || tst_brk TFAIL "fail to delete entry"
+			tst_brk TFAIL "$entry_name entry '$(tst_ipaddr rhost)' not listed"
+
+		$DEL_CMD || tst_brk TFAIL "fail to delete entry"
 
-		$show_cmd | grep -q "${rhost}.*$(tst_hwaddr rhost)" && \
-			tst_brk TFAIL "'$del_cmd' failed, entry has " \
+		$SHOW_CMD | grep -q "${rhost}.*$(tst_hwaddr rhost)" && \
+			tst_brk TFAIL "'$DEL_CMD' failed, entry has " \
 				"$(tst_hwaddr rhost)' $i/$NUMLOOPS"
 	done
 
