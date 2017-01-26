From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 26 Jan 2017 15:09:44 +0100
Subject: [LTP] [COMMITTED] [PATCH] madvise01: Add MADV_FREE + fallback in
	lapi/mmap.h
Message-ID: <1485439784-2893-1-git-send-email-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/lapi/mmap.h                           | 4 ++++
 testcases/kernel/syscalls/madvise/madvise01.c | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/lapi/mmap.h b/include/lapi/mmap.h
index fd136f6..10065a4 100644
--- a/include/lapi/mmap.h
+++ b/include/lapi/mmap.h
@@ -67,4 +67,8 @@
 # define MADV_DODUMP   17
 #endif
 
+#ifndef MADV_FREE
+# define MADV_FREE	8
+#endif
+
 #endif /* LAPI_MMAP_H__ */
diff --git a/testcases/kernel/syscalls/madvise/madvise01.c b/testcases/kernel/syscalls/madvise/madvise01.c
index a8a974b..4b6a6ce 100644
--- a/testcases/kernel/syscalls/madvise/madvise01.c
+++ b/testcases/kernel/syscalls/madvise/madvise01.c
@@ -60,7 +60,8 @@ static struct tcase {
 	{MADV_HUGEPAGE,    "MADV_HUGEPAGE",    &pfile}, /* since Linux 2.6.38 */
 	{MADV_NOHUGEPAGE,  "MADV_NOHUGEPAGE",  &pfile}, /* since Linux 2.6.38 */
 	{MADV_DONTDUMP,    "MADV_DONTDUMP",    &sfile}, /* since Linux 3.4 */
-	{MADV_DODUMP,      "MADV_DODUMP",      &sfile}  /* since Linux 3.4 */
+	{MADV_DODUMP,      "MADV_DODUMP",      &sfile}, /* since Linux 3.4 */
+	{MADV_FREE,        "MADV_FREE",        &sfile}, /* since Linux 4.5 */
 };
 
 static void setup(void)
-- 
2.7.3

