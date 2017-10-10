From: Li Wang <liwang@redhat.com>
Date: Tue, 10 Oct 2017 15:13:53 +0800
Subject: [LTP] [PATCH] ksm: fix ksm06 warning
Message-ID: <20171010071353.7627-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

tst_test.c:934: INFO: Timeout per run is 0h 05m 00s
ksm06.c:68: CONF: no merge_across_nodes sysfs knob
safe_file_ops.c:256: WARN: Failed to close FILE '/sys/kernel/mm/ksm/max_page_sharing' at mem.c:252

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/ksm/ksm06.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/mem/ksm/ksm06.c b/testcases/kernel/mem/ksm/ksm06.c
index 334a048..e6af6e0 100644
--- a/testcases/kernel/mem/ksm/ksm06.c
+++ b/testcases/kernel/mem/ksm/ksm06.c
@@ -64,11 +64,11 @@ static void test_ksm(void)
 
 static void setup(void)
 {
+	save_max_page_sharing();
+
 	if (access(PATH_KSM "merge_across_nodes", F_OK) == -1)
 		tst_brk(TCONF, "no merge_across_nodes sysfs knob");
 
-	save_max_page_sharing();
-
 	if (!is_numa(NULL, NH_MEMS, 2))
 		tst_brk(TCONF, "The case needs a NUMA system.");
 
-- 
2.9.3

