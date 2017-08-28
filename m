From: Sandeep Patil <sspatil@google.com>
Date: Mon, 28 Aug 2017 14:24:44 -0700
Subject: [LTP] [PATCH] android: madvise08: fix for android devices.
Message-ID: <20170828212444.123677-1-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The test uses '%m' conversion specifier for vfscanf() that is not
supported in bionic. Use '%s' instead with a buffer that is
substatially larger than the current maximum coredump file name length
of 128 bytes.

Signed-off-by: Sandeep Patil <sspatil@google.com>
---
 testcases/kernel/syscalls/madvise/madvise08.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise08.c b/testcases/kernel/syscalls/madvise/madvise08.c
index 296c2bff3..813cd687a 100644
--- a/testcases/kernel/syscalls/madvise/madvise08.c
+++ b/testcases/kernel/syscalls/madvise/madvise08.c
@@ -49,10 +49,11 @@
 #define CORE_FILTER "/proc/self/coredump_filter"
 #define YCOUNT 0x500L
 #define FMEMSIZE (YCOUNT + 0x2L)
+#define CORENAME_MAX_SIZE 512
 
 static int dfd;
 static void *fmem;
-static char *cpattern;
+static char cpattern[CORENAME_MAX_SIZE];
 
 static void setup(void)
 {
@@ -80,7 +81,7 @@ static void setup(void)
 	if (!(0x1 & filter))
 		tst_brk(TCONF, "Anonymous private memory is not dumpable.");
 
-	SAFE_FILE_SCANF(CORE_PATTERN, "%m[^\n]", &cpattern);
+	SAFE_FILE_SCANF(CORE_PATTERN, "%s[^\n]", cpattern);
 	tst_res(TINFO, "System core pattern is '%s'", cpattern);
 
 	SAFE_GETCWD(cwd, sizeof(cwd));
@@ -108,10 +109,7 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	if (cpattern)
-		SAFE_FILE_PRINTF(CORE_PATTERN, "%s", cpattern);
-
-	free(cpattern);
+	SAFE_FILE_PRINTF(CORE_PATTERN, "%s", cpattern);
 
 	if (fmem)
 		SAFE_MUNMAP(fmem, FMEMSIZE);
-- 
2.14.1.342.g6490525c54-goog

