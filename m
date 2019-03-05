From: Elif Aslan <elas@linux.vnet.ibm.com>
Date: Tue,  5 Mar 2019 14:30:15 +0100
Subject: [LTP] [PATCH] Fixed mon_fsstatd.sh
Message-ID: <20190305133015.3859-1-elas@linux.vnet.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

---
 testcases/commands/cpuplugd/mon_fsstatd.sh | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/testcases/commands/cpuplugd/mon_fsstatd.sh b/testcases/commands/cpuplugd/mon_fsstatd.sh
index 0a8d5b8c2..fdbd3ee3d 100644
--- a/testcases/commands/cpuplugd/mon_fsstatd.sh
+++ b/testcases/commands/cpuplugd/mon_fsstatd.sh
@@ -135,13 +135,23 @@ mon_fsstatd_test1()
     mon_fsstatd_run 0 "mon_procd -i 30"
 
     sleep 2
-    mon_fsstatd_run 0 "mon_procd -a &"
+    mon_procd -a &
+    if [ "$?" -eq "0" ]; then
+            tst_res TPASS "'mon_procd -a' returned 0"
+    else
+            tst_res TFAIL "'mon_procd -a' did not return 0"
+    fi
 
     sleep 2
     mon_fsstatd_run 0 "killall mon_procd"
 
     sleep 2
-    mon_fsstatd_run 0 "mon_fsstatd -a &"
+    mon_fsstatd -a &
+    if [ "$?" -eq "0" ]; then
+            tst_res TPASS "'mon_fsstatd -a' returned 0"
+    else
+            tst_res TFAIL "'mon_fsstatd -a' did not return 0"
+    fi
 
     sleep 2
     mon_fsstatd_run 0 "killall mon_fsstatd"
-- 
2.17.2 (Apple Git-113)

