From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  2 Nov 2018 23:14:53 +0100
Subject: [LTP] [PATCH 1/2] net: Add tst_net_driver helper
Message-ID: <20181102221454.5056-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index d1206e285..3a243ca05 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -653,6 +653,11 @@ tst_set_sysctl()
 
 	tst_rhost_run $safe -c "sysctl -q -w $add_opt $name=$value"
 }
+tst_net_driver()
+{
+	tst_test_drivers $@
+	tst_rhost_run "tst_test_drivers $@"
+}
 
 tst_cleanup_rhost()
 {
-- 
2.19.1

