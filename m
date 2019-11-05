From: Jan Stancek <jstancek@redhat.com>
Date: Tue,  5 Nov 2019 13:23:42 +0100
Subject: [LTP] [PATCH v2 1/2] read_all: move blacklist to source
Message-ID: <4647b3bced96c66c040078a32c13dab65558816d.1572956488.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

library doesn't support multiple parameters for same option.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 runtest/fs                              |  2 +-
 testcases/kernel/fs/read_all/read_all.c | 28 ++++++++++++++++++++++------
 2 files changed, 23 insertions(+), 7 deletions(-)

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
index 4edccff03a4f..46f88af2270c 100644
--- a/testcases/kernel/fs/read_all/read_all.c
+++ b/testcases/kernel/fs/read_all/read_all.c
@@ -71,7 +71,6 @@ enum dent_action {
 static char *verbose;
 static char *quiet;
 static char *root_dir;
-static char *exclude;
 static char *str_reads;
 static int reads = 1;
 static char *str_worker_count;
@@ -81,6 +80,11 @@ static long max_workers = 15;
 static struct worker *workers;
 static char *drop_privs;
 
+static char *blacklist[] = {
+	NULL, /* reserved for -e parameter */
+	"/sys/power/wakeup_count",
+};
+
 static struct tst_option options[] = {
 	{"v", &verbose,
 	 "-v       Print information about successful reads."},
@@ -88,7 +92,7 @@ static struct tst_option options[] = {
 	 "-q       Don't print file read or open errors."},
 	{"d:", &root_dir,
 	 "-d path  Path to the directory to read from, defaults to /sys."},
-	{"e:", &exclude,
+	{"e:", &blacklist[0],
 	 "-e pattern Ignore files which match an 'extended' pattern, see fnmatch(3)."},
 	{"r:", &str_reads,
 	 "-r count The number of times to schedule a file for reading."},
@@ -182,17 +186,29 @@ static void sanitize_str(char *buf, ssize_t count)
 		strcpy(buf + MAX_DISPLAY, "...");
 }
 
+static int is_blacklisted(const char *path)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(blacklist); i++) {
+		if (blacklist[i] && !fnmatch(blacklist[i], path, FNM_EXTMATCH)) {
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

