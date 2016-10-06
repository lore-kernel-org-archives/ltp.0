From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  6 Oct 2016 16:50:14 +0300
Subject: [LTP] [PATCH] test_net.sh: don't waste time waiting 1 sec in
	tst_ping()
Message-ID: <1475761814-14468-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The current user of this function is 'icmp-uni-basic.sh' ipsec test
group that includes 17 tests. Usually, it takes about 50 seconds for
each test run. This change allows to run the same test in ~5 seconds
because interval is 0 and default number of packets transmitted for
each size parameter increased from 10 to 500.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/test_net.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index ceb6d9d..dc52d95 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -323,7 +323,7 @@ tst_netload()
 tst_ping()
 {
 	# The max number of ICMP echo request
-	PING_MAX=${PING_MAX:-"10"}
+	PING_MAX=${PING_MAX:-"500"}
 
 	local src_iface=${1:-"$(tst_iface)"}
 	local dst_addr=${2:-"$(tst_ipaddr rhost)"}; shift 2
@@ -333,7 +333,7 @@ tst_ping()
 	# ping cmd use 56 as default message size
 	for size in ${msg_sizes:-"56"}; do
 		ping$TST_IPV6 -I $src_iface -c $PING_MAX $dst_addr \
-			-s $size > /dev/null 2>&1
+			-s $size -i 0 > /dev/null 2>&1
 		ret=$?
 		if [ $ret -eq 0 ]; then
 			tst_resm TINFO "tst_ping IPv${TST_IPV6:-4} msg_size $size pass"
-- 
1.7.1

