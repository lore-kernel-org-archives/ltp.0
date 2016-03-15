From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 15 Mar 2016 16:14:08 +0100
Subject: [LTP] [PATCH v3] syscalls/readahead02: use bdi max readahead limit
Message-ID: <18accfbb7a4015da92cddcb208b580e709f5d5f7.1458054752.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Roman Gushchin <klamm@yandex-team.ru>

After commit 600e19afc5f8a6 ("mm: use only per-device readahead limit")
readahead size is not limited anymore by 2 megabytes. Instead,
the per-bdi limit is used for kernels 4.4 and older.

Signed-off-by: Roman Gushchin <klamm@yandex-team.ru>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/readahead/readahead02.c | 28 ++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index 90ad853f17fa..7dc308c03e5d 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -184,6 +184,21 @@ static void create_testfile(void)
 	free(tmp);
 }
 
+static long get_device_readahead(const char *fname)
+{
+	struct stat st;
+	unsigned long ra_kb = 0;
+	char buf[256];
+
+	if (stat(fname, &st) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "stat");
+	snprintf(buf, sizeof(buf), "/sys/dev/block/%d:%d/queue/read_ahead_kb",
+		 major(st.st_dev), minor(st.st_dev));
+	SAFE_FILE_SCANF(cleanup, buf, "%ld", &ra_kb);
+
+	return ra_kb * 1024;
+}
+
 /* read_testfile - mmap testfile and read every page.
  * This functions measures how many I/O and time it takes to fully
  * read contents of test file.
@@ -206,16 +221,23 @@ static void read_testfile(int do_readahead, const char *fname, size_t fsize,
 	unsigned long time_start_usec, time_end_usec;
 	off_t offset;
 	struct timeval now;
+	long readahead_size;
+
+	/* use bdi limit for 4.4 and older, otherwise default to 2M */
+	if ((tst_kvercmp(4, 4, 0)) >= 0)
+		readahead_size = get_device_readahead(fname);
+	else
+		readahead_size = 2 * 1024 * 1024;
+	tst_resm(TINFO, "max readahead size is: %ld", readahead_size);
 
 	fd = open(fname, O_RDONLY);
 	if (fd < 0)
 		tst_brkm(TBROK | TERRNO, cleanup, "Failed to open %s", fname);
 
 	if (do_readahead) {
-		/* read ahead in chunks, 2MB is maximum since 3.15-rc1 */
-		for (i = 0; i < fsize; i += 2*1024*1024) {
+		for (i = 0; i < fsize; i += readahead_size) {
 			TEST(ltp_syscall(__NR_readahead, fd,
-				(off64_t) i, 2*1024*1024));
+				(off64_t) i, readahead_size));
 			if (TEST_RETURN != 0)
 				break;
 		}
-- 
1.8.3.1

