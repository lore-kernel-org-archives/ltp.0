From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed,  1 Feb 2017 11:33:53 +0100
Subject: [LTP] [COMMITTED] [PATCH] madvise01: Fix MADV_FREE
Message-ID: <1485945233-15762-1-git-send-email-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Currently MADV_FREE works only on anonymous pages.

Also the test was passing a file descriptor to the MAP_ANONYMOUS mmap(),
which is not wrong since the fd argument is ignored in that case, but it
was mildly confusing. So now we pass -1 and the pointer variable is
called amem instead of pfile which was confusing as well.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/madvise/madvise01.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise01.c b/testcases/kernel/syscalls/madvise/madvise01.c
index 4b6a6ce..22fb2e6 100644
--- a/testcases/kernel/syscalls/madvise/madvise01.c
+++ b/testcases/kernel/syscalls/madvise/madvise01.c
@@ -38,7 +38,7 @@
 #define STR "abcdefghijklmnopqrstuvwxyz12345\n"
 
 static char *sfile;
-static char *pfile;
+static char *amem;
 static struct stat st;
 
 static struct tcase {
@@ -57,11 +57,11 @@ static struct tcase {
 	{MADV_HWPOISON,    "MADV_HWPOISON",    &sfile}, /* since Linux 2.6.32 */
 	{MADV_MERGEABLE,   "MADV_MERGEABLE",   &sfile}, /* since Linux 2.6.32 */
 	{MADV_UNMERGEABLE, "MADV_UNMERGEABLE", &sfile}, /* since Linux 2.6.32 */
-	{MADV_HUGEPAGE,    "MADV_HUGEPAGE",    &pfile}, /* since Linux 2.6.38 */
-	{MADV_NOHUGEPAGE,  "MADV_NOHUGEPAGE",  &pfile}, /* since Linux 2.6.38 */
+	{MADV_HUGEPAGE,    "MADV_HUGEPAGE",    &amem},  /* since Linux 2.6.38 */
+	{MADV_NOHUGEPAGE,  "MADV_NOHUGEPAGE",  &amem},  /* since Linux 2.6.38 */
 	{MADV_DONTDUMP,    "MADV_DONTDUMP",    &sfile}, /* since Linux 3.4 */
 	{MADV_DODUMP,      "MADV_DODUMP",      &sfile}, /* since Linux 3.4 */
-	{MADV_FREE,        "MADV_FREE",        &sfile}, /* since Linux 4.5 */
+	{MADV_FREE,        "MADV_FREE",        &amem},  /* since Linux 4.5 */
 };
 
 static void setup(void)
@@ -86,8 +86,8 @@ static void setup(void)
 
 	/* Map the input file into private memory. MADV_HUGEPAGE only works
 	 * with private anonymous pages */
-	pfile = SAFE_MMAP(NULL, st.st_size,
-			PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, fd, 0);
+	amem = SAFE_MMAP(NULL, st.st_size,
+			PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 
 	SAFE_CLOSE(fd);
 }
@@ -95,7 +95,7 @@ static void setup(void)
 static void cleanup(void)
 {
 	munmap(sfile, st.st_size);
-	munmap(pfile, st.st_size);
+	munmap(amem, st.st_size);
 	umount(TMP_DIR);
 	rmdir(TMP_DIR);
 }
-- 
2.7.3

