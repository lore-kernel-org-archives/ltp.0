From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  3 Oct 2018 17:37:54 +0200
Subject: [LTP] [PATCH 3/5] net/dhcp: Print client and server versions
In-Reply-To: <20181003153756.3825-1-pvorel@suse.cz>
References: <20181003153756.3825-1-pvorel@suse.cz>
Message-ID: <20181003153756.3825-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/dhcp/dhcp_lib.sh      | 3 +++
 testcases/network/dhcp/dhcpd_tests.sh   | 5 +++++
 testcases/network/dhcp/dnsmasq_tests.sh | 5 +++++
 3 files changed, 13 insertions(+)

diff --git a/testcases/network/dhcp/dhcp_lib.sh b/testcases/network/dhcp/dhcp_lib.sh
index b3cb70267..07d5ff131 100755
--- a/testcases/network/dhcp/dhcp_lib.sh
+++ b/testcases/network/dhcp/dhcp_lib.sh
@@ -92,6 +92,9 @@ test01()
 {
 	local wicked
 
+	tst_res TINFO "testing DHCP server $dhcp_name: $(print_dhcp_version)"
+	tst_res TINFO "using DHCP client: $(dhclient --version 2>&1)"
+
 	tst_res TINFO "starting DHCPv$TST_IPVER server on $iface0"
 
 	start_dhcp$TST_IPV6
diff --git a/testcases/network/dhcp/dhcpd_tests.sh b/testcases/network/dhcp/dhcpd_tests.sh
index b42d55777..0f53db66e 100755
--- a/testcases/network/dhcp/dhcpd_tests.sh
+++ b/testcases/network/dhcp/dhcpd_tests.sh
@@ -77,4 +77,9 @@ print_dhcp_log()
 	cat tst_dhcpd.err
 }
 
+print_dhcp_version()
+{
+	dhcpd --version 2>&1
+}
+
 tst_run
diff --git a/testcases/network/dhcp/dnsmasq_tests.sh b/testcases/network/dhcp/dnsmasq_tests.sh
index 2edefd1c1..a9255c7c1 100755
--- a/testcases/network/dhcp/dnsmasq_tests.sh
+++ b/testcases/network/dhcp/dnsmasq_tests.sh
@@ -40,4 +40,9 @@ print_dhcp_log()
 	cat tst_dnsmasq.log
 }
 
+print_dhcp_version()
+{
+	dnsmasq --version | head -2
+}
+
 tst_run
-- 
2.19.0

