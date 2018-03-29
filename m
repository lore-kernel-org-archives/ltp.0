From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 30 Mar 2018 01:31:33 +0200
Subject: [LTP] [RFC PATCH v2 2/3] network/interface: Cleanup if4-addr-change
In-Reply-To: <20180329233134.24151-1-pvorel@suse.cz>
References: <20180329233134.24151-1-pvorel@suse.cz>
Message-ID: <20180329233134.24151-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Wrap test code into function.
This is preparation for next commit.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/stress/interface/if4-addr-change | 60 ++++++++++++----------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/testcases/network/stress/interface/if4-addr-change b/testcases/network/stress/interface/if4-addr-change
index dbb3d3356..30f3bbbb4 100644
--- a/testcases/network/stress/interface/if4-addr-change
+++ b/testcases/network/stress/interface/if4-addr-change
@@ -36,42 +36,48 @@ do_cleanup()
 
 trap "tst_brkm TBROK 'test interrupted'" INT
 
-tst_check_cmds ifconfig
+test_body()
+{
+	local cnt=0
+	local num=1
+	local add_to_net=
+
+	tst_resm TINFO "ifconfig changes IPv4 address $NS_TIMES times"
 
-tst_resm TINFO "ifconfig changes IPv4 address $NS_TIMES times"
+	while [ $cnt -lt $NS_TIMES ]; do
+		# Define the network portion
+		num=$(($num + 1))
+		[ $num -gt $LHOST_IPV4_HOST_MAX ] && num=1
 
-cnt=0
-num=1
-while [ $cnt -lt $NS_TIMES ]; do
-	# Define the network portion
-	num=$(($num + 1))
-	[ $num -gt $LHOST_IPV4_HOST_MAX ] && num=1
+		[ $num -eq $RHOST_IPV4_HOST ] && continue
 
-	[ $num -eq $RHOST_IPV4_HOST ] && continue
+		# check prefix and fix values for prefix != 24
+		add_to_net=
+		if [ $IPV4_LPREFIX -lt 8 -o $IPV4_LPREFIX -ge 32 ] ; then
+			tst_brkm TCONF "test must be with prefix >= 8 and prefix < 32 ($IPV4_LPREFIX)"
+		elif [ $IPV4_LPREFIX -lt 16 ]; then # N.x.x.num
+			add_to_net=".0.1"
+		elif [ $IPV4_LPREFIX -lt 24 ]; then # N.N.x.num
+			add_to_net=".1"
+		fi
 
-	# check prefix and fix values for prefix != 24
-	add_to_net=
-	if [ $IPV4_LPREFIX -lt 8 -o $IPV4_LPREFIX -ge 32 ] ; then
-		tst_brkm TCONF "test must be with prefix >= 8 and prefix < 32 ($IPV4_LPREFIX)"
-	elif [ $IPV4_LPREFIX -lt 16 ]; then # N.x.x.num
-		add_to_net=".0.1"
-	elif [ $IPV4_LPREFIX -lt 24 ]; then # N.N.x.num
-		add_to_net=".1"
-	fi
+		# Change IPv4 address
+		ROD ifconfig $(tst_iface) ${IPV4_LNETWORK}${add_to_net}.${num} netmask \
+			$IPV4_LNETMASK broadcast $IPV4_LBROADCAST
 
-	# Change IPv4 address
-	ROD ifconfig $(tst_iface) ${IPV4_LNETWORK}${add_to_net}.${num} netmask \
-		$IPV4_LNETMASK broadcast $IPV4_LBROADCAST
+		cnt=$(($cnt + 1))
 
-	cnt=$(($cnt + 1))
+		[ $CHECK_INTERVAL -eq 0 ] && continue
+		[ $(($cnt % $CHECK_INTERVAL)) -ne 0 ] && continue
 
-	[ $CHECK_INTERVAL -eq 0 ] && continue
-	[ $(($cnt % $CHECK_INTERVAL)) -ne 0 ] && continue
+		tst_resm TINFO "ping $(tst_ipaddr):$(tst_ipaddr rhost) ${cnt}/$NS_TIMES"
+		tst_ping
+	done
 
-	tst_resm TINFO "ping $(tst_ipaddr):$(tst_ipaddr rhost) ${cnt}/$NS_TIMES"
 	tst_ping
-done
+}
 
-tst_ping
+tst_check_cmds ifconfig
+test_body
 
 tst_exit
-- 
2.16.3

