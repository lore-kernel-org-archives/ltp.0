From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 22 Oct 2019 16:07:45 +0200
Subject: [LTP] [PATCH] net/dhcp: Don't start dhclient when wicked is running
Message-ID: <20191022140745.12777-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is a rework of wicked workaround. Commit f5b28dbb0 stopped wicked
(if running) as it's conflicting with dhclient. But for systems which
use wicked is better to actually test wicked as client side, because
dhclient is not actually used.

Fixes: f5b28dbb0 ("net/dhcp: Add support for wicked")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---

NOTE: I actually had also idea to use -sf (dhclient-script) and maybe
-cf (config file) parameter from running dhclient instance.
NetworkManager is using it's own dhclient-script and config file,
so it'd have more sense to test them (for the same reasons as this
commit). But it does not work (either using just -sf or using both -sf
and -cf - the latter isn't surprising).

Kind regards,
Petr

 testcases/network/dhcp/dhcp_lib.sh | 33 ++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/testcases/network/dhcp/dhcp_lib.sh b/testcases/network/dhcp/dhcp_lib.sh
index f731eed24..634d6ab43 100755
--- a/testcases/network/dhcp/dhcp_lib.sh
+++ b/testcases/network/dhcp/dhcp_lib.sh
@@ -108,7 +108,8 @@ print_dhcp_log()
 
 test01()
 {
-	local wicked
+	local wicked_cfg="/etc/sysconfig/network/ifcfg-$iface1"
+	local wicked_cleanup
 
 	tst_res TINFO "testing DHCP server $dhcp_name: $(print_dhcp_version)"
 	tst_res TINFO "using DHCP client: $(dhclient --version 2>&1)"
@@ -130,15 +131,28 @@ test01()
 
 	if [ $HAVE_SYSTEMCTL -eq 1 ] && \
 		systemctl --no-pager -p Id show network.service | grep -q Id=wicked.service; then
-		tst_res TINFO "temporarily disabling wicked"
-		wicked=1
-		systemctl disable wicked
+		tst_res TINFO "wicked is running, don't start dhclient"
+		if [ ! -f "$wicked_cfg" ]; then
+			cat <<EOF > $wicked_cfg
+BOOTPROTO='dhcp'
+NAME='LTP card'
+STARTMODE='auto'
+USERCONTROL='no'
+EOF
+			wicked_cleanup=1
+		else
+			tst_res TINFO "wicked config file $wicked_cfg already exist"
+		fi
+
+		tst_res TINFO "restarting wicked"
+		systemctl restart wicked
+	else
+		tst_res TINFO "starting dhclient -$TST_IPVER $iface1"
+		dhclient -$TST_IPVER $iface1 || tst_brk TBROK "dhclient failed"
 	fi
-	tst_res TINFO "starting dhclient -$TST_IPVER $iface1"
-	dhclient -$TST_IPVER $iface1 || tst_brk TBROK "dhclient failed"
 
 	# check that we get configured ip address
-	ip addr show $iface1 | grep $ip_addr_check > /dev/null
+	ip addr show $iface1 | grep -q $ip_addr_check
 	if [ $? -eq 0 ]; then
 		tst_res TPASS "'$ip_addr_check' configured by DHCPv$TST_IPVER"
 	else
@@ -151,10 +165,7 @@ test01()
 		fi
 	fi
 
-	if [ "$wicked" ]; then
-		tst_res TINFO "reenabling wicked"
-		systemctl enable wicked
-	fi
+	[ "$wicked_cleanup" ] && rm -f $wicked_cfg
 
 	stop_dhcp
 }
-- 
2.23.0

