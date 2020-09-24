From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 24 Sep 2020 10:17:37 +0300
Subject: [LTP] [PATCH 2/5] network/virt_lib: use test ip version in
 virt_compare_netperf()
In-Reply-To: <20200924071740.6963-1-alexey.kodanev@oracle.com>
References: <20200924071740.6963-1-alexey.kodanev@oracle.com>
Message-ID: <20200924071740.6963-2-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This will match virtual device underlying ip version.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/virt/virt_lib.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index f488932ff..827829633 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -292,10 +292,10 @@ virt_compare_netperf()
 	local vt="$(cat res_ipv4)"
 	local vt6="$(cat res_ipv6)"
 
-	tst_netload -H $ip_remote $opts -d res_ipv4
+	tst_netload -H $(tst_ipaddr rhost) $opts -d res_lan
 
-	local lt="$(cat res_ipv4)"
-	tst_res TINFO "time lan($lt) $virt_type IPv4($vt) and IPv6($vt6) ms"
+	local lt="$(cat res_lan)"
+	tst_res TINFO "time lan IPv${TST_IPVER}($lt) $virt_type IPv4($vt) and IPv6($vt6) ms"
 
 	per=$(( $vt * 100 / $lt - 100 ))
 	per6=$(( $vt6 * 100 / $lt - 100 ))
-- 
2.20.1

