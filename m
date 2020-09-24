From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 24 Sep 2020 10:17:36 +0300
Subject: [LTP] [PATCH 1/5] network/ipsec: fix warning when using wrong
 option for ipv4
Message-ID: <20200924071740.6963-1-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch is fixing the warning in ipsec vti setup:
Warning: nodad option can be set only for IPv6 addresses

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/stress/ipsec/ipsec_lib.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh b/testcases/network/stress/ipsec/ipsec_lib.sh
index d40941d45..198c9315d 100644
--- a/testcases/network/stress/ipsec/ipsec_lib.sh
+++ b/testcases/network/stress/ipsec/ipsec_lib.sh
@@ -295,11 +295,12 @@ tst_ipsec_setup_vti()
 	tst_ipsec_vti lhost $ip_loc $ip_rmt $tst_vti
 	tst_ipsec_vti rhost $ip_rmt $ip_loc $tst_vti
 
-	local mask=
+	local mask address_opt
 	if [ "$TST_IPV6" ]; then
 		ip_loc_tun="${IPV6_NET32_UNUSED}::1";
 		ip_rmt_tun="${IPV6_NET32_UNUSED}::2";
 		mask=64
+		address_opt=nodad
 		ROD ip -6 route add ${IPV6_NET32_UNUSED}::/$mask dev $tst_vti
 	else
 		ip_loc_tun="${IPV4_NET16_UNUSED}.1.1";
@@ -311,6 +312,6 @@ tst_ipsec_setup_vti()
 	tst_res TINFO "Add IPs to vti tunnel, " \
 		       "loc: $ip_loc_tun/$mask, rmt: $ip_rmt_tun/$mask"
 
-	ROD ip a add $ip_loc_tun/$mask dev $tst_vti nodad
+	ROD ip a add $ip_loc_tun/$mask dev $tst_vti $address_opt
 	tst_rhost_run -s -c "ip a add $ip_rmt_tun/$mask dev $tst_vti"
 }
-- 
2.20.1

