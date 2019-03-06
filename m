From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 6 Mar 2019 17:42:56 +0100
Subject: [LTP] [PATCH v2] syscalls/readahead02: limit max readahead to
 backing device max_readahead_kb
In-Reply-To: <CAOQ4uxiVkayLBWPAdPSz9W17hPNp7LagdtJ2k+vL98C0KgbKtA@mail.gmail.com>
References: <CAOQ4uxi49WogvHDck_JXiUV8VfLDHhzu=EYVYWiTz+zagT41KA@mail.gmail.com>
 <e27f21eef1ea317efcae24816b7a014e9e663f2d.1551802444.git.jstancek@redhat.com>
 <CAOQ4uxgc2NqK=6Lmau08y_k6tQa17xg8Q50UB+xwkgdetTWKuQ@mail.gmail.com>
 <518295220.5323766.1551804903461.JavaMail.zimbra@redhat.com>
 <CAOQ4uxhAESuU2HZ73kU0tMZ4CvQSJPo4c176MuBoN9WrT2nhTg@mail.gmail.com>
 <2040204176.5432824.1551817326223.JavaMail.zimbra@redhat.com>
 <CAOQ4uxiVkayLBWPAdPSz9W17hPNp7LagdtJ2k+vL98C0KgbKtA@mail.gmail.com>
Message-ID: <20190306164256.GA570@dustball.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Mar 05, 2019 at 10:44:57PM +0200, Amir Goldstein wrote:
>> > > > This is certainly better than 4K, but still feels like we are not really
>> > > > testing
>> > > > the API properly, but I'm fine with this fix.
>> > > >
>> > > > However... as follow up, how about extending the new
>> > > > tst_dev_bytes_written() utils from Sumit to cover also bytes_read
>> > > > and replace validation of readahead() from get_cached_size() diff
>> > > > to tst_dev_bytes_read()?
>> > >
>> > > There is something similar based on /proc/self/io. We could try using
>> > > that to estimate max readahead size.
>> > >
>> > > Or /sys/class/block/$dev/stat as you suggested, not sure which one is
>> > > more accurate/up to date.
>> > >
>> >
>> > I believe /proc/self/io doesn't count IO performed by kernel async
>> > readahead against the process that issued the readahead, but didn't
>> > check. The test uses /proc/self/io to check how many IO where avoided
>> > by readahead...
>>
>> We could do one readahead() on entire file, then read
>> the file and see how many IO we didn't manage to avoid.
>> The difference between filesize and IO we couldn't avoid,
>> would be our max readahead size.

This also doesn't seem 100% accurate.

Any method to inspect side-effect of readahead, appears to lead to more
readahead done by kernel. E.g. sequential reads leading to more async
readahead started by kernel (which tries to stay ahead by async_size).
mmap() approach appears to fault-in with do_fault_around().

MAP_NONBLOCK is gone, mincore and pagemap doesn't help here.

I'm attaching v3, where I do reads with sycalls() in reverse order.
But occasionally, it still somehow leads to couple extra pages being
read to cache. So, it still over-estimates. On ppc64le, it's quite
significant, 4 extra pages in cache, each 64k, causes readahead
loop to miss ~10MB of data.

/sys/class/block/$dev/ stats appear to be increased for fs metadata
as well, which can also inflate value and we over-estimate.

I'm running out of ideas for something more accurate/stable than v2.

Regards,
Jan
-------------- next part --------------
From f5a0bf04cb4dd1746636702b668da7b6c9146008 Mon Sep 17 00:00:00 2001
Message-Id: <f5a0bf04cb4dd1746636702b668da7b6c9146008.1551888987.git.jstancek@redhat.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 6 Mar 2019 16:52:33 +0100
Subject: [PATCH v3] syscalls/readahead02: don't use system-wide cache stats to
 estimate max readahead

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

This patch makes following changes:
- max readahead size estimate is no longer using system-wide cache
- it is replaced with function, that makes 1 readahead on entire file,
  then tries to read it and checks /proc/self/io stats.
  The difference in read_bytes stat is the amount of IO we didn't
  manage to avoid. max readahead size is then file size minus
  IO we didn't manage to avoid.
- File reading is no longer done sequentially, because kernel has
  optimizations that lead to async readahead on offsets following
  the read.
- File reading is done directly with syscalls (without mmap), to
  try avoid kernel optimizations like do_fault_around().

This combined makes max readahead estimate more accurate, but it's
not byte-perfect every time. It still occasionally over-estimates
maximum readahead by small amount.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/readahead/readahead02.c | 83 ++++++++++++++---------
 1 file changed, 50 insertions(+), 33 deletions(-)

diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index 293c839e169e..89d1ca3bcd64 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -49,7 +49,7 @@ static int ovl_mounted;
 #define OVL_UPPER	MNTPOINT"/upper"
 #define OVL_WORK	MNTPOINT"/work"
 #define OVL_MNT		MNTPOINT"/ovl"
-#define MIN_SANE_READAHEAD (4u * 1024u)
+#define MIN_SANE_READAHEAD 4096
 
 static const char mntpoint[] = MNTPOINT;
 
@@ -145,6 +145,49 @@ static void create_testfile(int use_overlay)
 	free(tmp);
 }
 
+static void read_file_backwards(int fd, size_t fsize)
+{
+	size_t i;
+	unsigned char p;
+
+	/*
+	 * read from end to beginning, to avoid kernel optimizations
+	 * for sequential read, where it asynchronously reads ahead
+	 */
+	for (i = 0; i < fsize; i+= pagesize) {
+		SAFE_LSEEK(fd, fsize - i - 1, SEEK_SET);
+		SAFE_READ(1, fd, &p, 1);
+	}
+	SAFE_LSEEK(fd, 0, SEEK_SET);
+}
+
+/*
+ * Call readahead() on entire file and try to read it. Check how much
+ * has read IO stat increased. Difference between file size and increase
+ * in IO is our guess for maximum allowed readahead size.
+ */
+static int guess_max_ra(struct tcase *tc, int fd, size_t fsize)
+{
+	int max_ra = 0;
+	long read_bytes_start, read_bytes;
+
+	tc->readahead(fd, 0, fsize);
+
+	read_bytes_start = get_bytes_read();
+	read_file_backwards(fd, fsize);
+	read_bytes = get_bytes_read() - read_bytes_start;
+
+	max_ra = fsize - read_bytes;
+	if (max_ra < MIN_SANE_READAHEAD) {
+		tst_res(TWARN, "Failed to estimate max ra size: %d", max_ra);
+		max_ra = MIN_SANE_READAHEAD;
+	}
+	tst_res(TINFO, "max readahead size estimate: %d", max_ra);
+
+	drop_caches();
+	return max_ra;
+}
+
 /* read_testfile - mmap testfile and read every page.
  * This functions measures how many I/O and time it takes to fully
  * read contents of test file.
@@ -164,14 +207,12 @@ static int read_testfile(struct tcase *tc, int do_readahead,
 	int fd;
 	size_t i = 0;
 	long read_bytes_start;
-	unsigned char *p, tmp;
-	unsigned long cached_start, max_ra_estimate = 0;
 	off_t offset = 0;
+	int max_ra = 0;
 
 	fd = SAFE_OPEN(fname, O_RDONLY);
-
 	if (do_readahead) {
-		cached_start = get_cached_size();
+		max_ra = guess_max_ra(tc, fd, fsize);
 		do {
 			TEST(tc->readahead(fd, offset, fsize - offset));
 			if (TST_RET != 0) {
@@ -179,21 +220,8 @@ static int read_testfile(struct tcase *tc, int do_readahead,
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
+			offset += max_ra;
 		} while ((size_t)offset < fsize);
 		tst_res(TINFO, "readahead calls made: %zu", i);
 		*cached = get_cached_size();
@@ -207,25 +235,14 @@ static int read_testfile(struct tcase *tc, int do_readahead,
 	}
 
 	tst_timer_start(CLOCK_MONOTONIC);
-	read_bytes_start = get_bytes_read();
 
-	p = SAFE_MMAP(NULL, fsize, PROT_READ, MAP_SHARED | MAP_POPULATE, fd, 0);
-
-	/* for old kernels, where MAP_POPULATE doesn't work, touch each page */
-	tmp = 0;
-	for (i = 0; i < fsize; i += pagesize)
-		tmp = tmp ^ p[i];
-	/* prevent gcc from optimizing out loop above */
-	if (tmp != 0)
-		tst_brk(TBROK, "This line should not be reached");
+	read_bytes_start = get_bytes_read();
+	read_file_backwards(fd, fsize);
+	*read_bytes = get_bytes_read() - read_bytes_start;
 
 	if (!do_readahead)
 		*cached = get_cached_size();
 
-	SAFE_MUNMAP(p, fsize);
-
-	*read_bytes = get_bytes_read() - read_bytes_start;
-
 	tst_timer_stop();
 	*usec = tst_timer_elapsed_us();
 
-- 
1.8.3.1

