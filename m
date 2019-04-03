From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed,  3 Apr 2019 20:02:04 +0300
Subject: [LTP] [PATCH] network/dhcp: correct prefix for expected IPv6 address
Message-ID: <1554310924-24751-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Assuming a /64 prefix from DHCPv6 server is wrong [1], fixed dhclient
sets /128 prefix.

With this patch the test also checks the configured address without
the prefix, when the first check fails, and reports a more verbose
message, plus shows an output from 'ip addr show $iface' command.

[1] https://bugs.launchpad.net/ubuntu/+source/isc-dhcp/+bug/1609898

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/dhcp/dhcp_lib.sh |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/testcases/network/dhcp/dhcp_lib.sh b/testcases/network/dhcp/dhcp_lib.sh
index c92117f..434ac1d 100755
--- a/testcases/network/dhcp/dhcp_lib.sh
+++ b/testcases/network/dhcp/dhcp_lib.sh
@@ -42,10 +42,12 @@ dhcp_lib_setup()
 
 	if [ $TST_IPV6 ]; then
 		ip_addr="fd00:1:1:2::12/64"
-		ip_addr_check="fd00:1:1:2::100/64"
+		ip_addr_check_nm="fd00:1:1:2::100"
+		ip_addr_check="$ip_addr_check_nm/128"
 	else
 		ip_addr="10.1.1.12/24"
-		ip_addr_check="10.1.1.100/24"
+		ip_addr_check_nm="10.1.1.100"
+		ip_addr_check="$ip_addr_check_nm/24"
 	fi
 
 	lsmod | grep -q '^veth ' && veth_loaded=yes || veth_loaded=no
@@ -141,8 +143,13 @@ test01()
 	if [ $? -eq 0 ]; then
 		tst_res TPASS "'$ip_addr_check' configured by DHCPv$TST_IPVER"
 	else
-		tst_res TFAIL "'$ip_addr_check' not configured by DHCPv$TST_IPVER"
-		print_dhcp_log
+		if ip addr show $iface1 | grep -q $ip_addr_check_nm; then
+			tst_res TFAIL "'$ip_addr_check_nm' configured but has wrong prefix, expect '$ip_addr_check'"
+			ip addr show $iface1
+		else
+			tst_res TFAIL "'$ip_addr_check' not configured by DHCPv$TST_IPVER"
+			print_dhcp_log
+		fi
 	fi
 
 	if [ "$wicked" ]; then
-- 
1.7.1

