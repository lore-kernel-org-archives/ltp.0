From: Li Wang <liwang@redhat.com>
Date: Wed,  2 Aug 2017 16:38:02 +0800
Subject: [LTP] [PATCH] mem/ksm: fix two errors in ksm06.c
Message-ID: <20170802083802.8706-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1.
If the default value of 'run', 'sleep_millisecs' and 'merge_across_nodes' are
equal 0, that would be failed to recover them in cleanup(), because they are
not satisfy with the condition(should '> 0', but '== 0') in comparing.

2.
tst_test.c:908: INFO: Timeout per run is 0h 05m 00s
ksm06.c:71: CONF: The case needs a NUMA system.
safe_file_ops.c:256: WARN: Failed to close FILE '/sys/kernel/mm/ksm/max_page_sharing' at mem.c:252

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/ksm/ksm06.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/mem/ksm/ksm06.c b/testcases/kernel/mem/ksm/ksm06.c
index df7cd39..334a048 100644
--- a/testcases/kernel/mem/ksm/ksm06.c
+++ b/testcases/kernel/mem/ksm/ksm06.c
@@ -67,6 +67,8 @@ static void setup(void)
 	if (access(PATH_KSM "merge_across_nodes", F_OK) == -1)
 		tst_brk(TCONF, "no merge_across_nodes sysfs knob");
 
+	save_max_page_sharing();
+
 	if (!is_numa(NULL, NH_MEMS, 2))
 		tst_brk(TCONF, "The case needs a NUMA system.");
 
@@ -76,21 +78,19 @@ static void setup(void)
 			"%d", &merge_across_nodes);
 	SAFE_FILE_SCANF(PATH_KSM "sleep_millisecs",
 			"%d", &sleep_millisecs);
-
-	save_max_page_sharing();
 }
 
 static void cleanup(void)
 {
-	if (merge_across_nodes > 0) {
+	if (merge_across_nodes != -1) {
 		FILE_PRINTF(PATH_KSM "merge_across_nodes",
 			    "%d", merge_across_nodes);
 	}
 
-	if (sleep_millisecs > 0)
+	if (sleep_millisecs != -1)
 		FILE_PRINTF(PATH_KSM "sleep_millisecs", "%d", sleep_millisecs);
 
-	if (run > 0)
+	if (run != -1)
 		FILE_PRINTF(PATH_KSM "run", "%d", run);
 
 	restore_max_page_sharing();
-- 
2.9.3

