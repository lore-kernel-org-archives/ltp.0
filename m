From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 23 May 2018 18:40:44 +0300
Subject: [LTP] [PATCH] network/gre01: fix device type setting
Message-ID: <1527090044-11443-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since the include of tst_net.sh moved to virt_lib.sh, setting
correct GRE device type should be moved there too, i.e. after
sourcing tst_net.sh and before virt_lib.sh. Otherwise IPv6
test-case won't work.

Fixes: ce920a5a430c ("network/virt_lib.sh: Process getopts parameters with TST_OPTS and TST_PARSE_ARGS")
Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/virt/gre01.sh    |    2 --
 testcases/network/virt/virt_lib.sh |    2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/network/virt/gre01.sh b/testcases/network/virt/gre01.sh
index 09a77a4..4da3969 100755
--- a/testcases/network/virt/gre01.sh
+++ b/testcases/network/virt/gre01.sh
@@ -25,8 +25,6 @@ TST_TOTAL=1
 TST_NEEDS_TMPDIR=1
 
 virt_type="gre"
-[ "$TST_IPV6" ] && virt_type="ip6gre"
-
 . virt_lib.sh
 
 TST_CLEANUP="virt_cleanup"
diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index d59aaa1..5fb6c22 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -54,6 +54,8 @@ TST_PARSE_ARGS=virt_lib_parse_args
 TST_USE_LEGACY_API=1
 . tst_net.sh
 
+[ -n "$TST_IPV6" -a "$virt_type" = "gre" ] && virt_type="ip6gre"
+
 ip_local=$(tst_ipaddr)
 ip_virt_local="$(TST_IPV6= tst_ipaddr_un)"
 ip6_virt_local="$(TST_IPV6=6 tst_ipaddr_un)"
-- 
1.7.1

