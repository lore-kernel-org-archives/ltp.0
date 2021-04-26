From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 26 Apr 2021 15:01:43 +0300
Subject: [LTP] [PATCH 0/3] network/virt: new FOU and GUE tests
In-Reply-To: <YIZbfLBS7C5hUu++@pevik>
References: <20210422131630.28565-1-alexey.kodanev@oracle.com>
 <YIZbfLBS7C5hUu++@pevik>
Message-ID: <d7f5805b-318f-d1f2-84ed-c2fe0769b854@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 26.04.2021 09:19, Petr Vorel wrote:
> Hi Alexey,
> 
>> The first patch adds IPv6 flag '-6' to the library, which
>> will be used by the two new tests in this patch series too.
> 
>> The rest are adding two similar tests for UDP tunneling.
> 
> fou01.sh and gue01.sh are nearly the same, but I also wouldn't complicate things
> by putting functions into virt_lib.sh to reduce duplicity.
> 
> Thus whole patchset LGTM, thanks!
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 

Hi Petr,

Thanks for the review! I think with test args we could reduce
duplication without complicating too much... what about these
diffs below (gue01.sh removed)?

diff --git a/runtest/net.features b/runtest/net.features
index f30a79741..e4b171a4b 100644
--- a/runtest/net.features
+++ b/runtest/net.features
@@ -65,8 +65,8 @@ gre_ipv6_01 gre01.sh -6
 gre_ipv4_02 gre02.sh
 gre_ipv6_02 gre02.sh -6

-gue01 gue01.sh
-gue01_ipv6 gue01.sh -6
+gue01 fou01.sh -t gue
+gue01_ipv6 fou01.sh -t gue -6

 fou01 fou01.sh
 fou01_ipv6 fou01.sh -6
diff --git a/testcases/network/virt/fou01.sh b/testcases/network/virt/fou01.sh
index 77521e260..1d7057fe5 100755
--- a/testcases/network/virt/fou01.sh
+++ b/testcases/network/virt/fou01.sh
@@ -6,18 +6,26 @@ TST_TESTFUNC=virt_netperf_rand_sizes
 TST_SETUP=do_setup
 TST_CLEANUP=do_cleanup
 TST_NEEDS_TMPDIR=1
+TST_OPTS="t:"
+TST_PARSE_ARGS="parse_args"

 virt_type="fou"
 . virt_lib.sh

-# GRE IP protocol number
-PROTO=47
+GRE_IP_PROTO=47
+
+parse_args()
+{
+	case $1 in
+	t) virt_type="$2" ;;
+	esac
+}

 do_cleanup()
 {
 	if [ "$FOU_PORT" ]; then
 		tst_net_run -l $FOU_PORT -r $FOU_PORT_RMT \
-			"ip fou del ipproto $PROTO ${TST_IPV6_FLAG} port"
+			"ip fou del $FOU_PROTO ${TST_IPV6_FLAG} port"
 	fi

 	virt_cleanup_rmt
@@ -27,11 +35,18 @@ do_cleanup()
 do_setup()
 {
 	local get_port_cmd="tst_get_unused_port ipv${TST_IPVER} dgram"
-	local encap_cmd="encap fou encap-sport auto encap-dport"
+	local encap_cmd="encap $virt_type encap-sport auto encap-dport"
 	local loc_ip=$(tst_ipaddr)
 	local rmt_ip=$(tst_ipaddr rhost)
 	local fou="fou$TST_IPV6"

+	case $virt_type in
+	fou) FOU_PROTO="ipproto $GRE_IP_PROTO";;
+	gue) FOU_PROTO="gue";;
+	esac
+
 	tst_require_drivers $fou
 	tst_net_run -s modprobe $fou

@@ -39,7 +54,7 @@ do_setup()
 	FOU_PORT_RMT=$(tst_rhost_run -c "$get_port_cmd")

 	tst_net_run -s -l $FOU_PORT -r $FOU_PORT_RMT \
-		"ip fou add ipproto $PROTO ${TST_IPV6_FLAG} port"
+		"ip fou add $FOU_PROTO ${TST_IPV6_FLAG} port"

 	virt_setup "local $loc_ip remote $rmt_ip $encap_cmd $FOU_PORT_RMT" \
 		   "local $rmt_ip remote $loc_ip $encap_cmd $FOU_PORT"

