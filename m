From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 21 Jul 2017 06:03:57 +0200
Subject: [LTP] [RFC PATCH v7 01/11] network/dhcp: Fix removing veth kernel
	module
In-Reply-To: <20170721040407.868-1-pvorel@suse.cz>
References: <20170721040407.868-1-pvorel@suse.cz>
Message-ID: <20170721040407.868-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Alexey Kodanev <alexey.kodanev@oracle.com>

This patch fixes problems with dhcp based tests run via netns when they
call TCONF:

$ /opt/ltp/testscripts/network.sh -6
dhcpd 1 TCONF: 'dhcpd' not found
...
cat: /sys/class/net/ltp_ns_veth2/address: No such file or directory

This also fixes other tests run after dhcp tests which are broken as
netns setup got broken.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>
---
Alexey, this is your proposed patch from mailing list [1]. I've tested it.

[1]: http://lists.linux.it/pipermail/ltp/2017-June/004850.html
---
 testcases/network/dhcp/dhcp_lib.sh | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/testcases/network/dhcp/dhcp_lib.sh b/testcases/network/dhcp/dhcp_lib.sh
index 85f9b88bf..500123284 100755
--- a/testcases/network/dhcp/dhcp_lib.sh
+++ b/testcases/network/dhcp/dhcp_lib.sh
@@ -40,8 +40,7 @@ init()
 	tst_require_root
 	tst_check_cmds cat $dhcp_name awk ip pgrep pkill dhclient
 
-	veth_loaded=
-	lsmod | grep -q '^veth ' && veth_loaded=1
+	lsmod | grep -q '^veth ' && veth_loaded=yes || veth_loaded=no
 
 	tst_resm TINFO "create veth interfaces"
 	ip li add $iface0 type veth peer name $iface1 || \
@@ -68,6 +67,8 @@ init()
 
 cleanup()
 {
+	[ -z "$veth_loaded" ] && return
+
 	stop_dhcp
 
 	pkill -f "dhclient -$ipv $iface1"
@@ -81,9 +82,7 @@ cleanup()
 
 	[ $veth_added ] && ip li del $iface0
 
-	if [ -z $veth_loaded ]; then
-		lsmod | grep -q '^veth ' && rmmod veth
-	fi
+	[ "$veth_loaded" = "no" ] && lsmod | grep -q '^veth ' && rmmod veth
 
 	tst_rmdir
 }
-- 
2.13.2

