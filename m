From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 18 Mar 2021 15:11:31 +0200
Subject: [LTP] [PATCH 5/8] syscalls/fanotify05: adjust test to tunable
 max_queued_events
In-Reply-To: <20210318131134.3562203-1-amir73il@gmail.com>
References: <20210318131134.3562203-1-amir73il@gmail.com>
Message-ID: <20210318131134.3562203-6-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Similar to test inotify05, check if there is a system tunable for
/proc/sys/fs/fanotify/max_queued_events and adjust the test according
to the system limit.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 testcases/kernel/syscalls/fanotify/fanotify05.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify05.c b/testcases/kernel/syscalls/fanotify/fanotify05.c
index 252f5cbf5..b7028f262 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify05.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify05.c
@@ -33,8 +33,12 @@
 #define FNAME_PREFIX_LEN 6
 #define PATH_PREFIX MOUNT_PATH "/" FNAME_PREFIX
 
-/* Currently this is fixed in kernel... */
-#define MAX_EVENTS 16384
+#define SYSFS_MAX_EVENTS "/proc/sys/fs/fanotify/max_queued_events"
+
+/* In older kernels this limit is fixed in kernel */
+#define DEFAULT_MAX_EVENTS 16384
+
+static int max_events;
 
 static struct tcase {
 	const char *tname;
@@ -100,7 +104,7 @@ static void test_fanotify(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
 	int len, nevents = 0, got_overflow = 0;
-	int num_files = MAX_EVENTS + 1;
+	int num_files = max_events + 1;
 	int expect_overflow = !(tc->init_flags & FAN_UNLIMITED_QUEUE);
 
 	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
@@ -186,6 +190,13 @@ static void setup(void)
 	/* Check for kernel fanotify support */
 	fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, O_RDONLY);
 	SAFE_CLOSE(fd);
+
+	/* In older kernels this limit is fixed in kernel */
+	if (access(SYSFS_MAX_EVENTS, F_OK) && errno == ENOENT)
+		max_events = DEFAULT_MAX_EVENTS;
+	else
+		SAFE_FILE_SCANF(SYSFS_MAX_EVENTS, "%d", &max_events);
+	tst_res(TINFO, "max_queued_events=%d", max_events);
 }
 
 static void cleanup(void)
-- 
2.25.1

