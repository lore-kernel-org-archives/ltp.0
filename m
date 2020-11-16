From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 16 Nov 2020 08:58:44 +0000
Subject: [LTP] [PATCH] madvise06: Do no set swap limit
Message-ID: <20201116085844.29499-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Setting the swap limit is unnecessary for this test. By default it
appears to be set to some large value which is OK. Setting it may fail
for reasons unrelated to the test's purpose making the test less
reliable.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

I should not have included this in the first update to the test. It
appears that it fails with EACCES on at least one configuration, where
the test ran previously. Also it could fail with EBUSY in theory.

I don't know why limit_in_bytes can be set, but memsw.limit_in_bytes
results in EACCES. This is interesting, however should be the focus of
a different test IMO.

 testcases/kernel/syscalls/madvise/madvise06.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise06.c b/testcases/kernel/syscalls/madvise/madvise06.c
index 817faae39..2ba2bac6f 100644
--- a/testcases/kernel/syscalls/madvise/madvise06.c
+++ b/testcases/kernel/syscalls/madvise/madvise06.c
@@ -46,7 +46,6 @@
 
 #define CHUNK_SZ (400*1024*1024L)
 #define MEM_LIMIT (CHUNK_SZ / 2)
-#define MEMSW_LIMIT (2 * CHUNK_SZ)
 #define PASS_THRESHOLD (CHUNK_SZ / 4)
 #define PASS_THRESHOLD_KB (PASS_THRESHOLD / 1024)
 
@@ -124,8 +123,6 @@ static void setup(void)
 	SAFE_FILE_PRINTF("/proc/self/oom_score_adj", "%d", -1000);
 	SAFE_FILE_PRINTF(MNT_NAME"/"GROUP_NAME"/memory.limit_in_bytes", "%ld\n",
 			 MEM_LIMIT);
-	SAFE_FILE_PRINTF(MNT_NAME"/"GROUP_NAME"/memory.memsw.limit_in_bytes", "%ld\n",
-			 MEMSW_LIMIT);
 	SAFE_FILE_PRINTF(MNT_NAME"/"GROUP_NAME"/memory.swappiness", "60");
 	SAFE_FILE_PRINTF(MNT_NAME"/"GROUP_NAME"/tasks", "%d\n", getpid());
 
-- 
2.29.1

