From: naresh.kamboju@linaro.org <naresh.kamboju@linaro.org>
Date: Fri,  2 Sep 2016 16:12:33 +0530
Subject: [LTP] [v2] readahead02: fix read_ahead_kb file not found
Message-ID: <1472812953-30811-1-git-send-email-naresh.kamboju@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Naresh Kamboju <naresh.kamboju@linaro.org>

Test case is looking for read_ahead_kb file on a partition device (8:2) and
not on block device (8:0/8:16/8:32/8:48). The appropriate block device that
holds the partition can be found at queue/read_ahead_kb entry.

Before patch readahead02 test broken,
readahead02    1  TBROK  :  safe_file_ops.c:144: Failed to open FILE
'/sys/dev/block/8:2/queue/read_ahead_kb' for reading at
readahead02.c:197: errno=ENOENT(2): No such file or directory

After applying patch,
readahead02    0  TINFO  :  creating test file of size: 67108864
readahead02    0  TINFO  :  max readahead size is: 131072
readahead02    0  TINFO  :  read_testfile(0)
readahead02    0  TINFO  :  max readahead size is: 131072
readahead02    0  TINFO  :  read_testfile(1)
readahead02    0  TINFO  :  max readahead size is: 131072
readahead02    1  TPASS  :  expected ret success - returned value = 0
readahead02    2  TPASS  :  offset is still at 0 as expected
readahead02    0  TINFO  :  read_testfile(0) took: 1437202 usec
readahead02    0  TINFO  :  read_testfile(1) took: 1361915 usec
readahead02    0  TINFO  :  read_testfile(0) read: 67108864 bytes
readahead02    0  TINFO  :  read_testfile(1) read: 0 bytes
readahead02    3  TPASS  :  readahead saved some I/O
readahead02    0  TINFO  :  cache can hold at least: 157404 kB
readahead02    0  TINFO  :  read_testfile(0) used cache: 65332 kB
readahead02    0  TINFO  :  read_testfile(1) used cache: 65636 kB
readahead02    4  TPASS  :  using cache as expected

Patch tested on aarch64 and x86_64.

Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
---
 testcases/kernel/syscalls/readahead/readahead02.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index 53278be..97ab0a8 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -192,8 +192,13 @@ static long get_device_readahead(const char *fname)
 
 	if (stat(fname, &st) == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "stat");
-	snprintf(buf, sizeof(buf), "/sys/dev/block/%d:%d/queue/read_ahead_kb",
-		 major(st.st_dev), minor(st.st_dev));
+	if (minor(st.st_dev)) {
+		snprintf(buf, sizeof(buf), "/sys/dev/block/%d:%d/../queue/read_ahead_kb",
+			major(st.st_dev), minor(st.st_dev));
+	} else {
+		snprintf(buf, sizeof(buf), "/sys/dev/block/%d:%d/queue/read_ahead_kb",
+			major(st.st_dev), minor(st.st_dev));
+	}
 	SAFE_FILE_SCANF(cleanup, buf, "%ld", &ra_kb);
 
 	return ra_kb * 1024;
-- 
1.9.1

