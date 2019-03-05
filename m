From: Jan Stancek <jstancek@redhat.com>
Date: Tue,  5 Mar 2019 13:34:26 +0100
Subject: [LTP] [PATCH/RFC] syscalls/readahead02: don't use cache size
Message-ID: <69e171efb14ec9078a4b70838f45ff5a550388d8.1551789098.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Using system-wide "Cached" size is not accurate. The test is sporadically
failing with warning on ppc64le 4.18 and 5.0 kernels.

Problem is that test over-estimates max readahead size, which then
leads to fewer readhead calls and kernel can silently trims length
in each of them:
  ...
  readahead02.c:244: INFO: Test #2: POSIX_FADV_WILLNEED on file
  readahead02.c:134: INFO: creating test file of size: 67108864
  readahead02.c:263: INFO: read_testfile(0)
  readahead02.c:274: INFO: read_testfile(1)
  readahead02.c:189: INFO: max ra estimate: 12320768
  readahead02.c:198: INFO: readahead calls made: 6
  readahead02.c:204: PASS: offset is still at 0 as expected
  readahead02.c:308: INFO: read_testfile(0) took: 492486 usec
  readahead02.c:309: INFO: read_testfile(1) took: 430627 usec
  readahead02.c:311: INFO: read_testfile(0) read: 67108864 bytes
  readahead02.c:313: INFO: read_testfile(1) read: 59244544 bytes
  readahead02.c:316: PASS: readahead saved some I/O
  readahead02.c:324: INFO: cache can hold at least: 264192 kB
  readahead02.c:325: INFO: read_testfile(0) used cache: 124992 kB
  readahead02.c:326: INFO: read_testfile(1) used cache: 12032 kB
  readahead02.c:338: WARN: using less cache than expected

Stop relying on used cache size, and use minimal sane readahead length,
that should work across all systems.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/readahead/readahead02.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index 293c839e169e..2f4d7f05a550 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -165,13 +165,11 @@ static int read_testfile(struct tcase *tc, int do_readahead,
 	size_t i = 0;
 	long read_bytes_start;
 	unsigned char *p, tmp;
-	unsigned long cached_start, max_ra_estimate = 0;
 	off_t offset = 0;
 
 	fd = SAFE_OPEN(fname, O_RDONLY);
 
 	if (do_readahead) {
-		cached_start = get_cached_size();
 		do {
 			TEST(tc->readahead(fd, offset, fsize - offset));
 			if (TST_RET != 0) {
@@ -179,21 +177,8 @@ static int read_testfile(struct tcase *tc, int do_readahead,
 				return TST_ERR;
 			}
 
-			/* estimate max readahead size based on first call */
-			if (!max_ra_estimate) {
-				*cached = get_cached_size();
-				if (*cached > cached_start) {
-					max_ra_estimate = (1024 *
-						(*cached - cached_start));
-					tst_res(TINFO, "max ra estimate: %lu",
-						max_ra_estimate);
-				}
-				max_ra_estimate = MAX(max_ra_estimate,
-					MIN_SANE_READAHEAD);
-			}
-
 			i++;
-			offset += max_ra_estimate;
+			offset += MIN_SANE_READAHEAD;
 		} while ((size_t)offset < fsize);
 		tst_res(TINFO, "readahead calls made: %zu", i);
 		*cached = get_cached_size();
@@ -334,8 +319,6 @@ static void test_readahead(unsigned int n)
 			tst_res(TPASS, "using cache as expected");
 		else if (!cached_ra)
 			tst_res(TFAIL, "readahead failed to use any cache");
-		else
-			tst_res(TWARN, "using less cache than expected");
 	} else {
 		tst_res(TCONF, "Page cache on your system is too small "
 			"to hold whole testfile.");
-- 
1.8.3.1

