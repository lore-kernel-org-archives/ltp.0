From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  3 Oct 2018 17:37:52 +0200
Subject: [LTP] [PATCH 1/5] net/dhcp: Add support for wicked
In-Reply-To: <20181003153756.3825-1-pvorel@suse.cz>
References: <20181003153756.3825-1-pvorel@suse.cz>
Message-ID: <20181003153756.3825-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

wicked network configuration daemon conflicts with dhclient. In order to
use dhclient, it requires wicked to be disabled.

daemonlib.sh currently doesn't have support for enabling detection.
While we could add support for it, wicked is used only in openSUSE/SLE
with systemd let's ignore non-systemd versions.

Fixes: openSUSE/SLE using wicked

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/dhcp/dhcp_lib.sh | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/testcases/network/dhcp/dhcp_lib.sh b/testcases/network/dhcp/dhcp_lib.sh
index 0c4c76be2..b3cb70267 100755
--- a/testcases/network/dhcp/dhcp_lib.sh
+++ b/testcases/network/dhcp/dhcp_lib.sh
@@ -12,6 +12,7 @@ TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="cat $dhcp_name awk ip pgrep pkill dhclient"
 
 . tst_net.sh
+. daemonlib.sh
 
 iface0="ltp_veth0"
 iface1="ltp_veth1"
@@ -89,10 +90,11 @@ cleanup()
 
 test01()
 {
+	local wicked
+
 	tst_res TINFO "starting DHCPv$TST_IPVER server on $iface0"
 
 	start_dhcp$TST_IPV6
-
 	sleep 1
 
 	if [ "$(pgrep '$dhcp_name')" ]; then
@@ -100,6 +102,12 @@ test01()
 		tst_brk TBROK "Failed to start $dhcp_name"
 	fi
 
+	if [ $HAVE_SYSTEMCTL -eq 1 ] && \
+		systemctl --no-pager -p Id show network.service | grep -q Id=wicked.service; then
+		tst_res TINFO "temporarily disabling wicked"
+		wicked=1
+		systemctl disable wicked
+	fi
 	tst_res TINFO "starting dhclient -$TST_IPVER $iface1"
 	dhclient -$TST_IPVER $iface1 || tst_brk TBROK "dhclient failed"
 
@@ -112,5 +120,10 @@ test01()
 		print_dhcp_log
 	fi
 
+	if [ "$wicked" ]; then
+		tst_res TINFO "reenabling wicked"
+		systemctl enable wicked
+	fi
+
 	stop_dhcp
 }
-- 
2.19.0

