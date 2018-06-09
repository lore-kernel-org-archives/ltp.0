From: Sun Lianwen <sunlw.fnst@cn.fujitsu.com>
Date: Sat, 9 Jun 2018 18:41:38 +0800
Subject: [LTP] [PATCH] macsec: fix double delete the tmp file
Message-ID: <20180609104138.8375-1-sunlw.fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

The virt_cleanup and tst_ipsec_cleanup in both in the cleanup() which will 
double delete the tmp file. and result to report below info:
"rm: cannot remove ‘/tmp/ltp-ddLUcf8ACl/macsec01.6YQ9qGRNuC’: No such file 
or directory"

Signed-off-by: Sun Lianwen <sunlw.fnst@cn.fujitsu.com>
---
 testcases/network/virt/macsec01.sh | 10 +++++++++-
 testcases/network/virt/macsec02.sh | 12 ++++++++++--
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/testcases/network/virt/macsec01.sh b/testcases/network/virt/macsec01.sh
index 52d6f071a..1a3499648 100755
--- a/testcases/network/virt/macsec01.sh
+++ b/testcases/network/virt/macsec01.sh
@@ -31,7 +31,15 @@ VIRT_PERF_THRESHOLD=${VIRT_PERF_THRESHOLD:-100}
 cleanup()
 {
 	virt_cleanup
-	tst_ipsec_cleanup
+
+	ip xfrm state flush
+	ip xfrm policy flush
+	tst_rhost_run -c "ip xfrm state flush && ip xfrm policy flush"
+
+	if [ -n "$cleanup_vti" ]; then
+		ip li del $cleanup_vti 2>/dev/null
+		tst_rhost_run -c "ip li del $cleanup_vti 2>/dev/null"
+	fi
 }
 TST_CLEANUP="cleanup"
 
diff --git a/testcases/network/virt/macsec02.sh b/testcases/network/virt/macsec02.sh
index 617860d41..6276a6b09 100755
--- a/testcases/network/virt/macsec02.sh
+++ b/testcases/network/virt/macsec02.sh
@@ -30,8 +30,16 @@ VIRT_PERF_THRESHOLD=${VIRT_PERF_THRESHOLD:-100}
 
 cleanup()
 {
-	virt_cleanup
-	tst_ipsec_cleanup
+    virt_cleanup
+
+    ip xfrm state flush
+    ip xfrm policy flush
+    tst_rhost_run -c "ip xfrm state flush && ip xfrm policy flush"
+
+    if [ -n "$cleanup_vti" ]; then
+        ip li del $cleanup_vti 2>/dev/null
+        tst_rhost_run -c "ip li del $cleanup_vti 2>/dev/null"
+    fi
 }
 TST_CLEANUP="cleanup"
 
-- 
2.17.0



