From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 18 Mar 2021 15:11:27 +0200
Subject: [LTP] [PATCH 1/8] syscalls/fanotify05: Fix test output when not
 getting overflow
In-Reply-To: <20210318131134.3562203-1-amir73il@gmail.com>
References: <20210318131134.3562203-1-amir73il@gmail.com>
Message-ID: <20210318131134.3562203-2-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When test does not get an overflow event, errno for empty queue was not
tested correctly and test printed a generic error instead of the intended
message about not getting an overflow event.

Use a helper function to generate events and add info prints about the
time it takes fill up the events queue and number of read events.
---
 .../kernel/syscalls/fanotify/fanotify05.c     | 50 +++++++++++++------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify05.c b/testcases/kernel/syscalls/fanotify/fanotify05.c
index 66ac4cbc3..6be593add 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify05.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify05.c
@@ -21,11 +21,14 @@
 #include <string.h>
 #include <sys/syscall.h>
 #include "tst_test.h"
+#include "tst_timer.h"
 
 #ifdef HAVE_SYS_FANOTIFY_H
 #include "fanotify.h"
 
 #define MOUNT_PATH "fs_mnt"
+#define FNAME_PREFIX "fname_"
+#define PATH_PREFIX MOUNT_PATH "/" FNAME_PREFIX
 
 /* Currently this is fixed in kernel... */
 #define MAX_EVENTS 16384
@@ -36,37 +39,52 @@ static int fd, fd_notify;
 
 struct fanotify_event_metadata event;
 
-void test01(void)
+static void generate_events(int num_files)
 {
+	long long elapsed_ms;
 	int i;
-	int len;
 
-	/*
-	 * generate events
-	 */
-	for (i = 0; i < MAX_EVENTS + 1; i++) {
-		sprintf(fname, MOUNT_PATH"/fname_%d", i);
+	tst_timer_start(CLOCK_MONOTONIC);
+
+	for (i = 0; i < num_files; i++) {
+		sprintf(fname, PATH_PREFIX "%d", i);
 		fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0644);
 		SAFE_CLOSE(fd);
 	}
 
+	tst_timer_stop();
+
+	elapsed_ms = tst_timer_elapsed_ms();
+
+	tst_res(TINFO, "Created %d files in %llims", i, elapsed_ms);
+}
+
+void test01(void)
+{
+	int len, nevents = 0;
+	int num_files = MAX_EVENTS + 1;
+
+	/*
+	 * Generate events on unique files so they won't be merged
+	 */
+	generate_events(num_files);
+
 	while (1) {
 		/*
 		 * get list on events
 		 */
 		len = read(fd_notify, &event, sizeof(event));
 		if (len < 0) {
-			if (errno == -EAGAIN) {
-				tst_res(TFAIL, "Overflow event not "
-					"generated!\n");
-				break;
+			if (errno != EAGAIN) {
+				tst_brk(TBROK | TERRNO,
+					"read of notification event failed");
 			}
-			tst_brk(TBROK | TERRNO,
-				"read of notification event failed");
+			tst_res(TFAIL, "Overflow event not generated!\n");
 			break;
 		}
 		if (event.fd != FAN_NOFD)
 			close(event.fd);
+		nevents++;
 
 		/*
 		 * check events
@@ -92,12 +110,12 @@ void test01(void)
 				break;
 			}
 			tst_res(TPASS,
-				"got event: mask=%llx pid=%u fd=%d",
-				(unsigned long long)event.mask,
+				"Got an overflow event: pid=%u fd=%d",
 				(unsigned)event.pid, event.fd);
-				break;
+			break;
 		}
 	}
+	tst_res(TINFO, "Got %d events", nevents);
 }
 
 static void setup(void)
-- 
2.25.1

