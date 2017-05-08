From: Li Wang <liwang@redhat.com>
Date: Mon,  8 May 2017 13:42:47 +0800
Subject: [LTP] [PATCH] move_pages12: fix Warning on system which not support
	hugepage
Message-ID: <20170508054247.994-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

WARNING:
 tst_test.c:847: INFO: Timeout per run is 0h 05m 00s
 move_pages_support.c:407: CONF: at least 2 allowed NUMA nodes are required
 safe_file_ops.c:301: WARN: Failed to close FILE '/proc/sys/vm/nr_hugepages' at move_pages12.c:159: EOPNOTSUPP

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/move_pages/move_pages12.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
index de00346..f93311f 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages12.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
@@ -158,7 +158,8 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	SAFE_FILE_PRINTF(PATH_NR_HUGEPAGES, "%ld", orig_hugepages);
+	if (!access(PATH_HUGEPAGES, F_OK))
+		SAFE_FILE_PRINTF(PATH_NR_HUGEPAGES, "%ld", orig_hugepages);
 }
 
 static struct tst_test test = {
-- 
2.9.3

