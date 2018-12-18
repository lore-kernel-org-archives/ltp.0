From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 18 Dec 2018 02:02:19 +0100
Subject: [LTP] [PATCH v3 5/6] net/dhcp: Move print_dhcp_log() into dhcp
	library
In-Reply-To: <20181218010220.2446-1-pvorel@suse.cz>
References: <20181218010220.2446-1-pvorel@suse.cz>
Message-ID: <20181218010220.2446-6-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Create default path for log file, but allow test to specify it.
This is needed for AppArmor respected paths, which was already defined
in 3e76b9896 ("net/dhcp: Use paths allowed by AppArmor for dnsmasq").

Also check if file exists. This is needed for dnsmasq --log-facility
switch when AppArmor enabled, because according to dnsmasq(8) errors
whilst reading configuration will still go to syslog. And then error
report of cat of missing file is misleading.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/dhcp/dhcp_lib.sh      | 7 +++++++
 testcases/network/dhcp/dhcpd_tests.sh   | 7 +------
 testcases/network/dhcp/dnsmasq_tests.sh | 5 -----
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/testcases/network/dhcp/dhcp_lib.sh b/testcases/network/dhcp/dhcp_lib.sh
index 632b1a9b1..c92117f47 100755
--- a/testcases/network/dhcp/dhcp_lib.sh
+++ b/testcases/network/dhcp/dhcp_lib.sh
@@ -38,6 +38,8 @@ stop_dhcp()
 
 dhcp_lib_setup()
 {
+	[ -z "$log" ] && log="$PWD/$(basename $0 '.sh').log"
+
 	if [ $TST_IPV6 ]; then
 		ip_addr="fd00:1:1:2::12/64"
 		ip_addr_check="fd00:1:1:2::100/64"
@@ -98,6 +100,11 @@ dhcp_lib_cleanup()
 	[ "$veth_loaded" = "no" ] && lsmod | grep -q '^veth ' && rmmod veth
 }
 
+print_dhcp_log()
+{
+	[ -f "$log" ] && cat $log
+}
+
 test01()
 {
 	local wicked
diff --git a/testcases/network/dhcp/dhcpd_tests.sh b/testcases/network/dhcp/dhcpd_tests.sh
index 5d695bf24..23dc8a45b 100755
--- a/testcases/network/dhcp/dhcpd_tests.sh
+++ b/testcases/network/dhcp/dhcpd_tests.sh
@@ -40,7 +40,7 @@ setup_dhcpd_conf()
 start_dhcpd()
 {
 	touch $lease_file
-	dhcpd -lf $lease_file -$TST_IPVER $iface0 > tst_dhcpd.err 2>&1
+	dhcpd -lf $lease_file -$TST_IPVER $iface0 > $log 2>&1
 }
 
 start_dhcp()
@@ -79,11 +79,6 @@ cleanup_dhcp()
 	rm -f $lease_file
 }
 
-print_dhcp_log()
-{
-	cat tst_dhcpd.err
-}
-
 print_dhcp_version()
 {
 	dhcpd --version 2>&1
diff --git a/testcases/network/dhcp/dnsmasq_tests.sh b/testcases/network/dhcp/dnsmasq_tests.sh
index 8e466dafe..f80ce1e0b 100755
--- a/testcases/network/dhcp/dnsmasq_tests.sh
+++ b/testcases/network/dhcp/dnsmasq_tests.sh
@@ -42,11 +42,6 @@ cleanup_dhcp()
 	rm -f $log
 }
 
-print_dhcp_log()
-{
-	cat $log
-}
-
 print_dhcp_version()
 {
 	dnsmasq --version | head -2
-- 
2.19.2

