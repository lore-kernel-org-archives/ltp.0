From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 15 Aug 2017 16:05:04 +0300
Subject: [LTP] [PATCH 1/2] network/virt_lib: enhance virt_compare_netperf()
	and virt_setup()
Message-ID: <1502802305-27958-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* device options can be the same for virt_setup()

* allow to pass any other options to netstress tool

* don't remove virt devices in virt_compare_netperf,
  this will be done in cleanup()

* skip IPv6 DAD for newly created ltp_v0

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/virt/virt_lib.sh |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index 05eaf0d..39a0ce9 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -189,7 +189,7 @@ virt_add_delete_test()
 virt_setup()
 {
 	local opt="$1"
-	local opt_r="$2"
+	local opt_r="${2:-$1}"
 
 	tst_resm TINFO "setup local ${virt_type} with '$opt'"
 	virt_add ltp_v0 $opt || \
@@ -214,6 +214,9 @@ virt_setup()
 	ROD_SILENT "ip addr add ${ip_virt_local}/24 dev ltp_v0"
 	tst_rhost_run -s -c "ip addr add ${ip_virt_remote}/24 dev ltp_v0"
 
+	ROD sysctl -q net.ipv6.conf.ltp_v0.dad_transmits=0
+	tst_rhost_run -s -c "sysctl -q net.ipv6.conf.ltp_v0.dad_transmits=0"
+
 	ROD_SILENT "ip li set up ltp_v0"
 	tst_rhost_run -s -c "ip li set up ltp_v0"
 }
@@ -258,23 +261,21 @@ virt_compare_netperf()
 	local ret1="pass"
 	local ret2="pass"
 	local expect_res="${1:-pass}"
+	local opts="$2"
 
-	tst_netload -H $ip_virt_remote -a $clients_num -R $max_requests \
+	tst_netload -H $ip_virt_remote -a $clients_num -R $max_requests $opts \
 		-r $client_requests -d res_ipv4 -e $expect_res || ret1="fail"
 
-	tst_netload -H ${ip6_virt_remote}%ltp_v0 -a $clients_num \
+	tst_netload -H ${ip6_virt_remote}%ltp_v0 -a $clients_num $opts \
 		-R $max_requests -r $client_requests -d res_ipv6 \
 		-e $expect_res || ret2="fail"
 
-	ROD_SILENT "ip link delete ltp_v0"
-	tst_rhost_run -s -c "ip link delete ltp_v0"
-
 	[ "$ret1" = "fail" -o "$ret2" = "fail" ] && return
 
 	local vt="$(cat res_ipv4)"
 	local vt6="$(cat res_ipv6)"
 
-	tst_netload -H $ip_remote -a $clients_num -R $max_requests \
+	tst_netload -H $ip_remote -a $clients_num -R $max_requests $opts \
 		-r $client_requests -d res_ipv4
 
 	local lt="$(cat res_ipv4)"
-- 
1.7.1

