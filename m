From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Thu, 18 Mar 2021 16:41:17 +0800
Subject: [LTP] [PATCH] cleanup: Replace libc functions with safe_macros
Message-ID: <20210318084117.5663-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

For those:
	testcases/kernel/syscalls/fanotify01.c
	testcases/kernel/syscalls/fanotify03.c
	testcases/kernel/syscalls/fanotify07.c

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 .../kernel/syscalls/fanotify/fanotify01.c      |  2 +-
 .../kernel/syscalls/fanotify/fanotify03.c      | 18 +++++++-----------
 .../kernel/syscalls/fanotify/fanotify07.c      | 15 ++++++---------
 3 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify01.c b/testcases/kernel/syscalls/fanotify/fanotify01.c
index 990bda140..2fe4a9457 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify01.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
@@ -167,7 +167,7 @@ static void test_fanotify(unsigned int n)
 			EVENT_BUF_LEN - len);
 	len += ret;

-	lseek(fd, 0, SEEK_SET);
+	SAFE_LSEEK(fd, 0, SEEK_SET);
 	/* Generate modify event to clear ignore mask */
 	SAFE_WRITE(1, fd, fname, 1);
 	event_set[tst_count] = FAN_MODIFY;
diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
index a5a384ee7..c191ed61f 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify03.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
@@ -128,17 +128,13 @@ static void generate_events(void)
 	/*
 	 * Generate sequence of events
 	 */
-	if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1)
-		exit(1);
-	if (write(fd, fname, 1) == -1)
-		exit(2);
+	fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0700);

-	lseek(fd, 0, SEEK_SET);
-	if (read(fd, buf, BUF_SIZE) != -1)
-		exit(3);
+	SAFE_WRITE(fd, fname, 1);
+	SAFE_LSEEK(fd, 0, SEEK_SET);

-	if (close(fd) == -1)
-		exit(4);
+	SAFE_READ(fd, buf, BUF_SIZE);
+	SAFE_CLOSE(fd);

 	if (execve(FILE_EXEC_PATH, argv, environ) != -1)
 		exit(5);
@@ -151,7 +147,7 @@ static void child_handler(int tmp)
 	 * Close notification fd so that we cannot block while reading
 	 * from it
 	 */
-	close(fd_notify);
+	SAFE_CLOSE(fd_notify);
 	fd_notify = -1;
 }

@@ -172,7 +168,7 @@ static void run_child(void)

 	if (child_pid == 0) {
 		/* Child will generate events now */
-		close(fd_notify);
+		SAFE_CLOSE(fd_notify);
 		generate_events();
 		exit(0);
 	}
diff --git a/testcases/kernel/syscalls/fanotify/fanotify07.c b/testcases/kernel/syscalls/fanotify/fanotify07.c
index 830af32b6..cd3bdb129 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify07.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify07.c
@@ -53,14 +53,12 @@ static void generate_events(void)
 	/*
 	 * generate sequence of events
 	 */
-	if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1)
-		exit(1);
+	fd = SAFE_OPEN(FNAME, O_RDWR | O_CREAT, 0700);

 	/* Run until killed... */
 	while (1) {
-		lseek(fd, 0, SEEK_SET);
-		if (read(fd, buf, BUF_SIZE) == -1)
-			exit(3);
+		SAFE_LSEEK(fd, 0, SEEK_SET);
+		SAFE_READ(fd, buf, BUF_SIZE);
 	}
 }

@@ -72,7 +70,7 @@ static void run_children(void)
 		child_pid[i] = SAFE_FORK();
 		if (!child_pid[i]) {
 			/* Child will generate events now */
-			close(fd_notify);
+			SAFE_CLOSE(fd_notify);
 			generate_events();
 			exit(0);
 		}
@@ -159,9 +157,8 @@ static void test_fanotify(void)
 	 * unanswered fanotify events block notification subsystem.
 	 */
 	newfd = setup_instance();
-	if (close(newfd)) {
-		tst_brk(TBROK | TERRNO, "close(%d) failed", newfd);
-	}
+
+	SAFE_CLOSE(newfd);

 	tst_res(TPASS, "second instance destroyed successfully");

--
2.17.1

