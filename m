From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 18 Mar 2021 15:11:29 +0200
Subject: [LTP] [PATCH 3/8] syscalls/fanotify05: Verify getting a single
 overflow event
In-Reply-To: <20210318131134.3562203-1-amir73il@gmail.com>
References: <20210318131134.3562203-1-amir73il@gmail.com>
Message-ID: <20210318131134.3562203-4-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Instead of generating just one extra event, generate many events after
filling events queue. The result should remain the same - just one
overflow event is expected.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify05.c     | 26 ++++++++++++-------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify05.c b/testcases/kernel/syscalls/fanotify/fanotify05.c
index 1ca427caa..60bcb4774 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify05.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify05.c
@@ -61,7 +61,7 @@ static void event_res(struct fanotify_event_metadata *event, int i)
 	}
 }
 
-static void generate_events(int num_files)
+static void generate_events(int open_flags, int num_files)
 {
 	long long elapsed_ms;
 	int i;
@@ -70,7 +70,7 @@ static void generate_events(int num_files)
 
 	for (i = 0; i < num_files; i++) {
 		sprintf(fname, PATH_PREFIX "%d", i);
-		fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0644);
+		fd = SAFE_OPEN(fname, open_flags, 0644);
 		SAFE_CLOSE(fd);
 	}
 
@@ -78,18 +78,24 @@ static void generate_events(int num_files)
 
 	elapsed_ms = tst_timer_elapsed_ms();
 
-	tst_res(TINFO, "Created %d files in %llims", i, elapsed_ms);
+	tst_res(TINFO, "%s %d files in %llims",
+		(open_flags & O_CREAT) ? "Created" : "Opened", i, elapsed_ms);
 }
 
 void test01(void)
 {
-	int len, nevents = 0;
+	int len, nevents = 0, got_overflow = 0;
 	int num_files = MAX_EVENTS + 1;
 
 	/*
 	 * Generate events on unique files so they won't be merged
 	 */
-	generate_events(num_files);
+	generate_events(O_RDWR | O_CREAT, num_files);
+
+	/*
+	 * Generate more events on the same files that me be merged
+	 */
+	generate_events(O_RDONLY, num_files);
 
 	while (1) {
 		/*
@@ -101,7 +107,8 @@ void test01(void)
 				tst_brk(TBROK | TERRNO,
 					"read of notification event failed");
 			}
-			tst_res(TFAIL, "Overflow event not generated!\n");
+			if (!got_overflow)
+				tst_res(TFAIL, "Overflow event not generated!\n");
 			break;
 		}
 		if (event.fd != FAN_NOFD) {
@@ -129,10 +136,11 @@ void test01(void)
 			break;
 		}
 		if (event.mask == FAN_Q_OVERFLOW) {
-			if (event.fd != FAN_NOFD) {
+			if (got_overflow || event.fd != FAN_NOFD) {
 				tst_res(TFAIL,
-					"invalid overflow event: "
+					"%s overflow event: "
 					"mask=%llx pid=%u fd=%d",
+					got_overflow ? "unexpected" : "invalid",
 					(unsigned long long)event.mask,
 					(unsigned)event.pid,
 					event.fd);
@@ -141,7 +149,7 @@ void test01(void)
 			tst_res(TPASS,
 				"Got an overflow event: pid=%u fd=%d",
 				(unsigned)event.pid, event.fd);
-			break;
+			got_overflow = 1;
 		}
 	}
 	tst_res(TINFO, "Got %d events", nevents);
-- 
2.25.1

