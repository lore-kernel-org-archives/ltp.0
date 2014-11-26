Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1Xtcck-00028h-HS
	for ltp-list@lists.sourceforge.net; Wed, 26 Nov 2014 13:27:14 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Xtccj-0002FA-D2
	for ltp-list@lists.sourceforge.net; Wed, 26 Nov 2014 13:27:14 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id sAQDR707004228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Nov 2014 13:27:07 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	sAQDR6RA014522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Nov 2014 13:27:06 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	sAQDR5XR003211
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Nov 2014 13:27:05 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 26 Nov 2014 16:28:44 +0300
Message-Id: <1417008524-32105-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] network/dhcpd: improve testcase, use dummy module
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com

Run dhcp client and check that the interface configured as expected.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/dhcpd/dhcpd_tests.sh |  148 +++++++++++++++++++++-----------
 1 files changed, 98 insertions(+), 50 deletions(-)

diff --git a/testcases/network/dhcpd/dhcpd_tests.sh b/testcases/network/dhcpd/dhcpd_tests.sh
index ad95875..c4c2c21 100755
--- a/testcases/network/dhcpd/dhcpd_tests.sh
+++ b/testcases/network/dhcpd/dhcpd_tests.sh
@@ -17,6 +17,7 @@
 # Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 #
 # Author:       Manoj Iyer, manjo@mail.utexas.edu
+# Author:       Alexey Kodanev alexey.kodanev@oracle.com
 
 TST_CLEANUP=cleanup
 TST_TOTAL=1
@@ -28,42 +29,62 @@ stop_dhcp()
 {
 	if [ "$(pgrep -x dhcpd)" ]; then
 		tst_resm TINFO "stopping DHCP server"
-		pkill -x dhcpd || tst_brkm "failed to stop DHCP server"
+		pkill -x dhcpd
+		sleep 1
 	fi
 }
 
-# alias ethX to ethX:1 with IP 10.1.1.12
-init()
+setup_conf()
 {
-	tst_require_root
-	tst_tmpdir
-	tst_check_cmds cat dhcpd awk ip pgrep pkill diff
-
-	stop_dhcp
-
 	cat > tst_dhcpd.conf <<-EOF
+	ddns-update-style none;
+	update-static-leases off;
 	subnet 10.1.1.0 netmask 255.255.255.0 {
-        # default gateway
-		range 10.1.1.12 10.1.1.12;
-		default-lease-time 600;
-		max-lease-time 1200;
-		option routers 10.1.1.1;
-		option subnet-mask
-		255.255.255.0;
-		option
-		domain-name-servers
-		10.1.1.1;
-		option
-		domain-name
-		"dhcptest.net";
+		range 10.1.1.100 10.1.1.100;
+		default-lease-time 60;
+		max-lease-time 60;
 	}
-	ddns-update-style interim;
 	EOF
+}
 
-	if [ $? -ne 0 ]; then
-		tst_brkm TBROK "unable to create temp file: tst_dhcpd.conf"
+setup_conf6()
+{
+	cat > tst_dhcpd.conf <<-EOF
+	ddns-update-style none;
+	update-static-leases off;
+	subnet6 fd00:1:1:2::/64 {
+		range6 fd00:1:1:2::100 fd00:1:1:2::100;
+		default-lease-time 60;
+		max-lease-time 60;
+	}
+	EOF
+}
+
+init()
+{
+	tst_require_root
+	tst_check_cmds cat dhcpd awk ip pgrep pkill dhclient
+
+	dummy_loaded=
+	lsmod | grep -q '^dummy '
+	if [ $? -eq 0 ]; then
+		dummy_loaded=1
+	else
+		modprobe dummy || tst_brkm TCONF "failed to find dummy module"
 	fi
 
+	tst_resm TINFO "create dummy interface"
+	ip li add $iface type dummy || \
+		tst_brkm TBROK "failed to add dummy $iface"
+
+	ip li set up $iface || tst_brkm TBROK "failed to bring $iface up"
+
+	tst_tmpdir
+
+	stop_dhcp
+
+	setup_conf$TST_IPV6
+
 	if [ -f /etc/dhcpd.conf ]; then
 		DHCPD_CONF="/etc/dhcpd.conf"
 	elif [ -f /etc/dhcp/dhcpd.conf ]; then
@@ -78,58 +99,85 @@ init()
 	mv tst_dhcpd.conf $DHCPD_CONF
 	[ $? -ne 0 ] && tst_brkm TBROK "failed to create dhcpd.conf"
 
-	tst_resm TINFO "add $iface:1 10.1.1.12/24 to create private network"
-	ip addr add 10.1.1.12/24 dev $iface label $iface:1
-	if [ $? -ne 0 ]; then
-		tst_brkm TBROK "failed to add alias"
+	dhclient_lease="/var/lib/dhclient/dhclient${TST_IPV6}.leases"
+	if [ -f $dhclient_lease ]; then
+		tst_resm TINFO "backup dhclient${TST_IPV6}.leases"
+		mv $dhclient_lease .
 	fi
+
+	tst_resm TINFO "add $ip_addr to $iface to create private network"
+	ip addr add $ip_addr dev $iface || \
+		tst_brkm TBROK "failed to add ip address"
 }
 
 cleanup()
 {
 	stop_dhcp
+
+	pkill -f "dhclient -$ipv $iface"
+
 	[ -f dhcpd.conf ] && mv dhcpd.conf $DHCPD_CONF
 
-	ip addr show $iface | grep "$iface:1" > /dev/null &&
-		ip addr del 10.1.1.12/24 dev $iface label $iface:1
+	# restore dhclient leases
+	rm -f $dhclient_lease
+	[ -f "dhclient${TST_IPV6}.leases" ] && \
+		mv dhclient${TST_IPV6}.leases $dhclient_lease
+
+	if [ "$dummy_loaded" ]; then
+		ip li del $iface
+	else
+		rmmod dummy
+	fi
 
 	tst_rmdir
 }
 
 test01()
 {
-	tst_resm TINFO "start/stop DHCP server"
+	tst_resm TINFO "starting DHCPv${ipv} server on $iface"
+	dhcpd -$ipv $iface > tst_dhcpd.err 2>&1
+	if [ $? -ne 0 ]; then
+		cat tst_dhcpd.err
+		tst_brkm TBROK "Failed to start dhcpd"
+	fi
 
-	cat > tst_dhcpd.exp <<-EOF
-	Sending on   Socket/fallback/fallback-net
-	EOF
-	[ $? -ne 0 ] && tst_brkm TBROK "unable to create expected results"
+	sleep 1
 
-	tst_resm TINFO "starting DHCP server"
-	dhcpd > tst_dhcpd.err 2>&1
-	if [ $? -ne 0 ]; then
+	if [ "$(pgrep 'dhcpd -$ipv $iface')" ]; then
 		cat tst_dhcpd.err
 		tst_brkm TBROK "Failed to start dhcpd"
 	fi
 
-	cat tst_dhcpd.err | tail -n 1 > tst_dhcpd.out
-	[ $? -ne 0 ] && tst_brkm TBROK "unable to create output file"
+	tst_resm TINFO "starting dhclient -${ipv} $iface"
+	dhclient -$ipv $iface || \
+		tst_brkm TBROK "dhclient failed"
 
-	diff -iwB tst_dhcpd.out tst_dhcpd.exp
-	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "failed to start dhcpd"
-		return
+	# check that we get configured ip address
+	ip addr show $iface | grep $ip_addr_check > /dev/null
+	if [ $? -eq 0 ]; then
+		tst_resm TPASS "'$ip_addr_check' configured by DHCPv$ipv"
+	else
+		tst_resm TFAIL "'$ip_addr_check' not configured by DHCPv$ipv"
 	fi
 
 	stop_dhcp
-
-	tst_resm TPASS "dhcpd started and stopped successfully"
 }
 
-iface=$(tst_iface)
+tst_read_opts $*
 
-init
+iface="ltp_dummy"
+ipv=${TST_IPV6:-"4"}
 
-test01
+if [ $TST_IPV6 ]; then
+	ip_addr="fd00:1:1:2::12/64"
+	ip_addr_check="fd00:1:1:2::100/64"
+else
+	ip_addr="10.1.1.12/24"
+	ip_addr_check="10.1.1.100/24"
+fi
+
+trap "tst_brkm TBROK 'test interrupted'" INT
 
+init
+test01
 tst_exit
-- 
1.7.1


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
