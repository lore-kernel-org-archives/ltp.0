From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  3 Oct 2018 17:37:53 +0200
Subject: [LTP] [PATCH 2/5] net/dhcp: Disable DNS for dnsmasq
In-Reply-To: <20181003153756.3825-1-pvorel@suse.cz>
References: <20181003153756.3825-1-pvorel@suse.cz>
Message-ID: <20181003153756.3825-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This fixes error when another DNS server is already running:
dnsmasq: failed to create listening socket for port 53: Address already in use

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/dhcp/dnsmasq_tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/dhcp/dnsmasq_tests.sh b/testcases/network/dhcp/dnsmasq_tests.sh
index 3d29abea3..2edefd1c1 100755
--- a/testcases/network/dhcp/dnsmasq_tests.sh
+++ b/testcases/network/dhcp/dnsmasq_tests.sh
@@ -10,7 +10,7 @@ dhcp_name="dnsmasq"
 
 common_opt="--no-hosts --no-resolv --dhcp-authoritative \
 	--log-facility=./tst_dnsmasq.log --interface=$iface0 \
-	--dhcp-leasefile=tst_dnsmasq.lease --conf-file= "
+	--dhcp-leasefile=tst_dnsmasq.lease --port=0 --conf-file= "
 
 start_dhcp()
 {
-- 
2.19.0

