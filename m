From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 14 Sep 2016 15:50:48 +0200
Subject: [LTP] [PATCH] readahead02: fix path for read_ahead_kb on raw
	partitions
Message-ID: <dcf8a988ac73c339e05a9f3e326c596065ce5d02.1473860921.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Path to read_ahead_kb is not consistent for all block devices,
for example for LVM it's:
  /sys/dev/block/$maj:$min/queue/read_ahead_kb
but for raw partitions "queue" is only in "parent" device:
  /sys/dev/block/$maj:$min/../queue/read_ahead_kb

This patch checks both types and reads first one it can find.
Tested on LVM and raw partitions with 4.7.3.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/readahead/readahead02.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index 53278be7d84c..2517a333680e 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -194,6 +194,12 @@ static long get_device_readahead(const char *fname)
 		tst_brkm(TBROK | TERRNO, cleanup, "stat");
 	snprintf(buf, sizeof(buf), "/sys/dev/block/%d:%d/queue/read_ahead_kb",
 		 major(st.st_dev), minor(st.st_dev));
+	if (access(buf, F_OK)) {
+		snprintf(buf, sizeof(buf),
+			"/sys/dev/block/%d:%d/../queue/read_ahead_kb",
+			major(st.st_dev), minor(st.st_dev));
+	}
+	tst_resm(TINFO, "Reading %s", buf);
 	SAFE_FILE_SCANF(cleanup, buf, "%ld", &ra_kb);
 
 	return ra_kb * 1024;
-- 
1.8.3.1

