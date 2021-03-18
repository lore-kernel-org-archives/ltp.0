From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 18 Mar 2021 15:11:28 +0200
Subject: [LTP] [PATCH 2/8] syscalls/fanotify05: Verify events are received
 by queue order
In-Reply-To: <20210318131134.3562203-1-amir73il@gmail.com>
References: <20210318131134.3562203-1-amir73il@gmail.com>
Message-ID: <20210318131134.3562203-3-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When all events are generated on unique objects, re-ordering no
events are expected to be merged and therefore no event re-order
is expected. Verify that events are received in the order that
they were generated.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify05.c     | 31 ++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify05.c b/testcases/kernel/syscalls/fanotify/fanotify05.c
index 6be593add..1ca427caa 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify05.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify05.c
@@ -18,6 +18,8 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <errno.h>
+#include <libgen.h>
+#include <stdlib.h>
 #include <string.h>
 #include <sys/syscall.h>
 #include "tst_test.h"
@@ -28,6 +30,7 @@
 
 #define MOUNT_PATH "fs_mnt"
 #define FNAME_PREFIX "fname_"
+#define FNAME_PREFIX_LEN 6
 #define PATH_PREFIX MOUNT_PATH "/" FNAME_PREFIX
 
 /* Currently this is fixed in kernel... */
@@ -35,10 +38,29 @@
 
 #define BUF_SIZE 256
 static char fname[BUF_SIZE];
+static char symlnk[BUF_SIZE];
+static char fdpath[BUF_SIZE];
 static int fd, fd_notify;
 
 struct fanotify_event_metadata event;
 
+static void event_res(struct fanotify_event_metadata *event, int i)
+{
+	int len = 0;
+	const char *filename;
+	sprintf(symlnk, "/proc/self/fd/%d", event->fd);
+	len = readlink(symlnk, fdpath, sizeof(fdpath));
+	if (len < 0)
+		len = 0;
+	fdpath[len] = 0;
+	filename = basename(fdpath);
+	if (len > FNAME_PREFIX_LEN && atoi(filename + FNAME_PREFIX_LEN) != i) {
+		tst_res(TFAIL, "Got event #%d out of order filename=%s", i, filename);
+	} else if (i == 0) {
+		tst_res(TINFO, "Got event #%d filename=%s", i, filename);
+	}
+}
+
 static void generate_events(int num_files)
 {
 	long long elapsed_ms;
@@ -82,8 +104,15 @@ void test01(void)
 			tst_res(TFAIL, "Overflow event not generated!\n");
 			break;
 		}
-		if (event.fd != FAN_NOFD)
+		if (event.fd != FAN_NOFD) {
+			/*
+			 * Verify that events generated on unique files
+			 * are received by the same order they were generated.
+			 */
+			if (nevents < num_files)
+				event_res(&event, nevents);
 			close(event.fd);
+		}
 		nevents++;
 
 		/*
-- 
2.25.1

