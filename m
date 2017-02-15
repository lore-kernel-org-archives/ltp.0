From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 15 Feb 2017 14:47:46 +0300
Subject: [LTP] [COMMITTED][PATCH 1/2] test_net.sh: flush IPsec config when
	initializing test interfaces
Message-ID: <1487159267-1317-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/test_net.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index 37cc939..6135032 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -216,6 +216,8 @@ tst_init_iface()
 	tst_resm TINFO "initialize '$type' '$iface' interface"
 
 	if [ "$type" = "lhost" ]; then
+		ip xfrm policy flush || return $?
+		ip xfrm state flush || return $?
 		ip link set $iface down || return $?
 		ip route flush dev $iface || return $?
 		ip addr flush dev $iface || return $?
@@ -223,6 +225,8 @@ tst_init_iface()
 		return $?
 	fi
 
+	tst_rhost_run -c "ip xfrm policy flush" || return $?
+	tst_rhost_run -c "ip xfrm state flush" || return $?
 	tst_rhost_run -c "ip link set $iface down" || return $?
 	tst_rhost_run -c "ip route flush dev $iface" || return $?
 	tst_rhost_run -c "ip addr flush dev $iface" || return $?
-- 
1.7.1

