From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 18 Mar 2021 15:11:30 +0200
Subject: [LTP] [PATCH 4/8] syscalls/fanotify05: Add a test case for
 unlimited queue
In-Reply-To: <20210318131134.3562203-1-amir73il@gmail.com>
References: <20210318131134.3562203-1-amir73il@gmail.com>
Message-ID: <20210318131134.3562203-5-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The existing test case verifies getting an overflow event when
events cannot fit in events queue.

Add a test case to verify that no overflow is generated when
events queue size is unlimited.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify05.c     | 41 +++++++++++++++----
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify05.c b/testcases/kernel/syscalls/fanotify/fanotify05.c
index 60bcb4774..252f5cbf5 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify05.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify05.c
@@ -36,6 +36,20 @@
 /* Currently this is fixed in kernel... */
 #define MAX_EVENTS 16384
 
+static struct tcase {
+	const char *tname;
+	unsigned int init_flags;
+} tcases[] = {
+	{
+		"Limited queue",
+		FAN_CLASS_NOTIF,
+	},
+	{
+		"Unlimited queue",
+		FAN_CLASS_NOTIF | FAN_UNLIMITED_QUEUE,
+	},
+};
+
 #define BUF_SIZE 256
 static char fname[BUF_SIZE];
 static char symlnk[BUF_SIZE];
@@ -82,10 +96,19 @@ static void generate_events(int open_flags, int num_files)
 		(open_flags & O_CREAT) ? "Created" : "Opened", i, elapsed_ms);
 }
 
-void test01(void)
+static void test_fanotify(unsigned int n)
 {
+	struct tcase *tc = &tcases[n];
 	int len, nevents = 0, got_overflow = 0;
 	int num_files = MAX_EVENTS + 1;
+	int expect_overflow = !(tc->init_flags & FAN_UNLIMITED_QUEUE);
+
+	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
+
+	fd_notify = SAFE_FANOTIFY_INIT(tc->init_flags | FAN_NONBLOCK, O_RDONLY);
+
+	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_MOUNT | FAN_MARK_ADD, FAN_OPEN,
+			   AT_FDCWD, MOUNT_PATH);
 
 	/*
 	 * Generate events on unique files so they won't be merged
@@ -108,7 +131,7 @@ void test01(void)
 					"read of notification event failed");
 			}
 			if (!got_overflow)
-				tst_res(TFAIL, "Overflow event not generated!\n");
+				tst_res(expect_overflow ? TFAIL : TPASS, "Overflow event not generated!\n");
 			break;
 		}
 		if (event.fd != FAN_NOFD) {
@@ -146,22 +169,23 @@ void test01(void)
 					event.fd);
 				break;
 			}
-			tst_res(TPASS,
+			tst_res(expect_overflow ? TPASS : TFAIL,
 				"Got an overflow event: pid=%u fd=%d",
 				(unsigned)event.pid, event.fd);
 			got_overflow = 1;
 		}
 	}
 	tst_res(TINFO, "Got %d events", nevents);
+	SAFE_CLOSE(fd_notify);
 }
 
 static void setup(void)
 {
-	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF | FAN_NONBLOCK,
-			O_RDONLY);
+	int fd;
 
-	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_MOUNT | FAN_MARK_ADD, FAN_OPEN,
-			  AT_FDCWD, MOUNT_PATH);
+	/* Check for kernel fanotify support */
+	fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, O_RDONLY);
+	SAFE_CLOSE(fd);
 }
 
 static void cleanup(void)
@@ -171,7 +195,8 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.test_all = test01,
+	.test = test_fanotify,
+	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_root = 1,
-- 
2.25.1

