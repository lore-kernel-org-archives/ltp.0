From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 15 Dec 2020 20:05:45 +0100
Subject: [LTP] [PATCH 1/1] if-mtu-change.sh: Add max packet size detection
 for IPv4
Message-ID: <20201215190545.19939-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Although theoretical maximum IP packet size is 65507, this does not work
on s390x on low MTU. But according to Wenjia Zhang the same problem is
on more platforms, e.g. x86:

A big IP packet is fragmented into small packets according to the MTU
size.  Each small packet consumes an amount of system memory, which are
recorded in ?skb->truesize?. And the sum of the space all of the small
packets need is limited by ?2 * sk->sk_sndbuf? (which you can find in
'__ip_append_data' function in net/ipv4/ip_output.c), that is inherited
from the system default set during socket initialization. The problem on
s390 is that ?skb->truesize? is got by aligning the size of the data
buffer to the L1 cache line (using SKB_DATA_ALIGN), which on s390 and
only on s390 is 256 bytes, while on other processors less than or equal
to 128 bytes. So the sum on s390 is much easier to exceed the limit,
that the big packet can not be sent successfully.

Because of the big cache line size on s390, the maximum size of the
packet is limited in between 53816 and 64960, if the MTU is set to
between 484 and 588.
However, this problem not only occurs on s390, but also on some other
processor e.g. x86. If the MTU is set to less than 340, an IP packet
with the theoretical maximum size (65507 bytes) likewise can not be sent
successfully.

NOTE: the detection isn't precise. I didn't consider it important enough
to implement bisection method. Detected only for IPv4, because IPv6 uses
high enough MTU (and function is not IPv6 ready).

Link: https://lore.kernel.org/lkml/ab8289e5-547c-5375-5d0f-e9a363005db1@linux.ibm.com/

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Alexey,

This simple change would be enough:
[ "$(uname -m)" = "s390x" ] && MAX_PACKET_SIZE="61244"

But I wanted to fix this for all platforms at once.

Kind regards,
Petr

 .../network/stress/interface/if-mtu-change.sh | 61 ++++++++++++++-----
 1 file changed, 45 insertions(+), 16 deletions(-)

diff --git a/testcases/network/stress/interface/if-mtu-change.sh b/testcases/network/stress/interface/if-mtu-change.sh
index f7ec35619..bc05ee187 100755
--- a/testcases/network/stress/interface/if-mtu-change.sh
+++ b/testcases/network/stress/interface/if-mtu-change.sh
@@ -21,11 +21,53 @@ CHANGE_VALUES="784 1142 552 1500 552 1500 552 748 552 1142 1500"
 CHANGE6_VALUES="1280 1445 1335 1390 1500 1280 1500 1280 1335 1500"
 saved_mtu=
 
+MAX_PACKET_SIZE=65507
+
+set_mtu()
+{
+	local mtu="$1"
+	local cmd="$2"
+	local ret=0
+	local iface=$(tst_iface)
+	local iface_rmt=$(tst_iface rhost)
+
+	case $cmd in
+		ifconfig) ifconfig $iface mtu $mtu || ret=1
+			tst_rhost_run -c "ifconfig $iface_rmt mtu $mtu" || ret=1
+			;;
+		ip) ip link set $iface mtu $mtu || ret=1
+			tst_rhost_run -c "ip link set $iface_rmt mtu $mtu" || ret=1
+			;;
+		*) tst_brk TBROK "unknown cmd '$cmd'"
+			;;
+	esac
+
+	return $ret
+}
+
+find_ipv4_max_packet_size()
+{
+	local min_mtu=552
+	local size=$MAX_PACKET_SIZE
+
+	set_mtu $min_mtu $CMD || tst_brk TBROK "failed to set MTU to $mtu"
+	tst_res TINFO "checking max MTU"
+	while [ $size -gt 0 ]; do
+		if ping -I $(tst_iface) -c1 -w1 -s $size $(tst_ipaddr rhost) >/dev/null; then
+			tst_res TINFO "use max MTU $size"
+			MAX_PACKET_SIZE=$size
+			return
+		fi
+		size=$((size - 500))
+	done
+}
+
 do_setup()
 {
 	[ "$TST_IPV6" ] && CHANGE_VALUES=$CHANGE6_VALUES
 	if_setup
 	saved_mtu="$(cat /sys/class/net/$(tst_iface)/mtu)"
+	[ "$TST_IPV6" ] || find_ipv4_max_packet_size
 }
 
 do_cleanup()
@@ -41,9 +83,6 @@ test_body()
 {
 	local cmd="$CMD"
 
-	local iface=$(tst_iface)
-	local iface_rmt=$(tst_iface rhost)
-
 	tst_res TINFO "'$cmd' changes MTU $MTU_CHANGE_TIMES times" \
 	               "every $CHANGE_INTERVAL seconds"
 
@@ -59,24 +98,14 @@ test_body()
 		make_background_tcp_traffic
 
 		tst_res TINFO "set MTU to $mtu $cnt/$MTU_CHANGE_TIMES"
-		local ret=0
-		case $cmd in
-		ifconfig) ifconfig $iface mtu $mtu || ret=1
-			tst_rhost_run -c "ifconfig $iface_rmt mtu $mtu"
-		;;
-		ip) ip link set $iface mtu $mtu || ret=1
-			tst_rhost_run -c "ip link set $iface_rmt mtu $mtu"
-		;;
-		esac
-
-		if [ $? -ne 0 -o $ret -ne 0 ]; then
-			tst_res TFAIL "Failed to change the mtu at $cnt time"
+		if ! set_mtu $mtu $cmd; then
+			tst_res TFAIL "failed to change MTU to $mtu at $cnt time"
 			return
 		fi
 
 		tst_sleep $CHANGE_INTERVAL
 
-		tst_ping -s "1 1000 65507"
+		tst_ping -s "1 1000 $MAX_PACKET_SIZE"
 	done
 }
 
-- 
2.29.2

