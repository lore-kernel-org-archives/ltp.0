From: rasibley <rasibley@redhat.com>
Date: Fri,  4 Oct 2019 14:44:36 -0400
Subject: [LTP] [PATCH] Update dynamic_debug grep check
Message-ID: <20191004184436.30922-1-rasibley@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If running on debug kernel this check will fail on EDAC DEBUG messages,
update grep to ignore such cases like this.
---
 testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh b/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
index f39d67d0a..7f06c2488 100755
--- a/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
+++ b/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
@@ -127,7 +127,7 @@ ddebug_test()
 	sed -i -e 1,`wc -l < ./dmesg.old`d ./dmesg.new
 	if grep -q -e "Kernel panic" -e "Oops" -e "general protection fault" \
 		-e "general protection handler: wrong gs" -e "\(XEN\) Panic" \
-		-e "fault" -e "warn" -e "BUG" ./dmesg.new ; then
+		-e "fault" -e "warn" -e "\<BUG\>" ./dmesg.new ; then
 		tst_res TFAIL "Issues found in dmesg!"
 	else
 		tst_res TPASS "Dynamic debug OK"
-- 
2.20.1

