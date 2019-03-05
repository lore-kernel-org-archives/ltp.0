From: Jan Stancek <jstancek@redhat.com>
Date: Tue,  5 Mar 2019 17:17:27 +0100
Subject: [LTP] [PATCH v2] syscalls/readahead02: limit max readahead to
	backing device max_readahead_kb
In-Reply-To: <CAOQ4uxi49WogvHDck_JXiUV8VfLDHhzu=EYVYWiTz+zagT41KA@mail.gmail.com>
References: <CAOQ4uxi49WogvHDck_JXiUV8VfLDHhzu=EYVYWiTz+zagT41KA@mail.gmail.com>
Message-ID: <e27f21eef1ea317efcae24816b7a014e9e663f2d.1551802444.git.jstancek@redhat.com>
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

Stop relying on used cache size, and use backing device readahead
limit instead.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/readahead/readahead02.c | 38 +++++++++++++----------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index 293c839e169e..c4c90a51c7de 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -49,7 +49,7 @@ static int ovl_mounted;
 #define OVL_UPPER	MNTPOINT"/upper"
 #define OVL_WORK	MNTPOINT"/work"
 #define OVL_MNT		MNTPOINT"/ovl"
-#define MIN_SANE_READAHEAD (4u * 1024u)
+int min_sane_readahead  = 4096;
 
 static const char mntpoint[] = MNTPOINT;
 
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
+			offset += min_sane_readahead;
 		} while ((size_t)offset < fsize);
 		tst_res(TINFO, "readahead calls made: %zu", i);
 		*cached = get_cached_size();
@@ -366,12 +351,31 @@ static void setup_overlay(void)
 
 static void setup(void)
 {
+	struct stat sbuf;
+	char tmp[PATH_MAX], sys_ra_path[PATH_MAX], *backing_dev;
+	int read_ahead_kb;
+
 	if (opt_fsizestr)
 		testfile_size = SAFE_STRTOL(opt_fsizestr, 1, INT_MAX);
 
 	if (access(PROC_IO_FNAME, F_OK))
 		tst_brk(TCONF, "Requires " PROC_IO_FNAME);
 
+	/* Use backing device read_ahead_kb limit as min_sane_readahead */
+	SAFE_LSTAT(tst_device->dev, &sbuf);
+	if (S_ISLNK(sbuf.st_mode))
+		SAFE_READLINK(tst_device->dev, tmp, PATH_MAX);
+	else
+		strcpy(tmp, tst_device->dev);
+	backing_dev = basename(tmp);
+	sprintf(sys_ra_path, "/sys/class/block/%s/bdi/read_ahead_kb", backing_dev);
+	if (access(sys_ra_path, F_OK) == 0) {
+		SAFE_FILE_SCANF(sys_ra_path, "%d", &read_ahead_kb);
+		if (read_ahead_kb * 1024 > min_sane_readahead)
+			min_sane_readahead = read_ahead_kb * 1024;
+	}
+	tst_res(TINFO, "min_sane_readahead: %u", min_sane_readahead);
+
 	has_file(DROP_CACHES_FNAME, 1);
 	has_file(MEMINFO_FNAME, 1);
 
-- 
1.8.3.1

