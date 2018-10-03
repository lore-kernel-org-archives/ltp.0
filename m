From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  3 Oct 2018 17:37:56 +0200
Subject: [LTP] [PATCH 5/5] net/dhcp: TBROK when dnsmasq does not start
In-Reply-To: <20181003153756.3825-1-pvorel@suse.cz>
References: <20181003153756.3825-1-pvorel@suse.cz>
Message-ID: <20181003153756.3825-6-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Move error handling detection from dhcpd test to library to be used
also by dnsmasq test.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/dhcp/dhcp_lib.sh    | 5 +++++
 testcases/network/dhcp/dhcpd_tests.sh | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/network/dhcp/dhcp_lib.sh b/testcases/network/dhcp/dhcp_lib.sh
index 07d5ff131..76bf11800 100755
--- a/testcases/network/dhcp/dhcp_lib.sh
+++ b/testcases/network/dhcp/dhcp_lib.sh
@@ -98,6 +98,11 @@ test01()
 	tst_res TINFO "starting DHCPv$TST_IPVER server on $iface0"
 
 	start_dhcp$TST_IPV6
+	if [ $? -ne 0 ]; then
+		print_dhcp_log
+		tst_brk TBROK "Failed to start $dhcp_name"
+	fi
+
 	sleep 1
 
 	if [ "$(pgrep '$dhcp_name')" ]; then
diff --git a/testcases/network/dhcp/dhcpd_tests.sh b/testcases/network/dhcp/dhcpd_tests.sh
index 29d688551..f1af09153 100755
--- a/testcases/network/dhcp/dhcpd_tests.sh
+++ b/testcases/network/dhcp/dhcpd_tests.sh
@@ -31,11 +31,6 @@ start_dhcpd()
 {
 	touch tst_hdcpd.lease
 	dhcpd -lf tst_hdcpd.lease -$TST_IPVER $iface0 > tst_dhcpd.err 2>&1
-	if [ $? -ne 0 ]; then
-		cat tst_dhcpd.err
-		tst_brk TBROK "Failed to start dhcpd"
-	fi
-
 }
 
 start_dhcp()
-- 
2.19.0

