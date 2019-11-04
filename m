From: Jan Stancek <jstancek@redhat.com>
Date: Mon,  4 Nov 2019 18:09:07 +0100
Subject: [LTP] [PATCH 1/2] read_all: move blacklist to source
Message-ID: <2086f9d5a3ce152780833993e6e21d3fbd074441.1572887015.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

library doesn't support multiple parameters for same option.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 runtest/fs                              |  2 +-
 testcases/kernel/fs/read_all/read_all.c | 28 ++++++++++++++++++++++++----
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/runtest/fs b/runtest/fs
index 07d6e2b67964..46318575653e 100644
--- a/runtest/fs
+++ b/runtest/fs
@@ -71,7 +71,7 @@ proc01 proc01 -m 128
 
 read_all_dev read_all -d /dev -p -q -r 10
 read_all_proc read_all -d /proc -q -r 10
-read_all_sys read_all -d /sys -q -r 10 -e /sys/power/wakeup_count
+read_all_sys read_all -d /sys -q -r 10
 
 #Run the File System Race Condition Check tests as well
 fs_racer fs_racer.sh -t 5
diff --git a/testcases/kernel/fs/read_all/read_all.c b/testcases/kernel/fs/read_all/read_all.c
index 4edccff03a4f..cef55e20d671 100644
--- a/testcases/kernel/fs/read_all/read_all.c
+++ b/testcases/kernel/fs/read_all/read_all.c
@@ -81,6 +81,11 @@ static long max_workers = 15;
 static struct worker *workers;
 static char *drop_privs;
 
+static char *blacklist[] = {
+	"/sys/power/wakeup_count",
+};
+static unsigned int blacklist_sz = ARRAY_SIZE(blacklist);
+
 static struct tst_option options[] = {
 	{"v", &verbose,
 	 "-v       Print information about successful reads."},
@@ -182,17 +187,32 @@ static void sanitize_str(char *buf, ssize_t count)
 		strcpy(buf + MAX_DISPLAY, "...");
 }
 
+static int is_blacklisted(const char *path)
+{
+	unsigned int i;
+	char *bstr;
+
+	for (i = 0; i < blacklist_sz + 1; i++) {
+		bstr = i < blacklist_sz ? blacklist[i] : exclude;
+
+		if (bstr && !fnmatch(bstr, path, FNM_EXTMATCH)) {
+			if (verbose)
+				tst_res(TINFO, "Ignoring %s", path);
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
 static void read_test(const char *path)
 {
 	char buf[BUFFER_SIZE];
 	int fd;
 	ssize_t count;
 
-	if (exclude && !fnmatch(exclude, path, FNM_EXTMATCH)) {
-		if (verbose)
-			tst_res(TINFO, "Ignoring %s", path);
+	if (is_blacklisted(path))
 		return;
-	}
 
 	if (verbose)
 		tst_res(TINFO, "%s(%s)", __func__, path);
-- 
1.8.3.1

