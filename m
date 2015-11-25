From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 25 Nov 2015 11:39:11 +0300
Subject: [LTP] [Committed] network/virt/gre01: set local address for
	tunneled packets
Message-ID: <1448440751-9483-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Alexey Kodanev <akodanev@gmail.com>

Signed-off-by: Alexey Kodanev <akodanev@gmail.com>
---
 testcases/network/virt/gre01.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/network/virt/gre01.sh b/testcases/network/virt/gre01.sh
index e4bd990..a2c574f 100755
--- a/testcases/network/virt/gre01.sh
+++ b/testcases/network/virt/gre01.sh
@@ -50,8 +50,8 @@ if [ -z $ip_local -o -z $ip_remote ]; then
 fi
 
 tst_resm TINFO "test $virt_type"
-virt_setup "remote $(tst_ipaddr rhost) dev $(tst_iface)" \
-"remote $(tst_ipaddr) dev $(tst_iface rhost)"
+virt_setup "local $(tst_ipaddr) remote $(tst_ipaddr rhost) dev $(tst_iface)" \
+"local $(tst_ipaddr rhost) remote $(tst_ipaddr) dev $(tst_iface rhost)"
 
 virt_compare_netperf
 
-- 
1.7.1

