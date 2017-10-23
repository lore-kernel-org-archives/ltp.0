From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 23 Oct 2017 14:18:43 +0200
Subject: [LTP] [PATCH 2/3] kmsg01: specify read timeout in usec
In-Reply-To: <0994c420a161f2bf97de060396abd915502fca4f.1508760897.git.jstancek@redhat.com>
References: <0994c420a161f2bf97de060396abd915502fca4f.1508760897.git.jstancek@redhat.com>
Message-ID: <4701d2391df11a1e65e8c6bc1d3f027f20617719.1508760897.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/logging/kmsg/kmsg01.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/logging/kmsg/kmsg01.c b/testcases/kernel/logging/kmsg/kmsg01.c
index 393acdcc71c6..b81c077cbd23 100644
--- a/testcases/kernel/logging/kmsg/kmsg01.c
+++ b/testcases/kernel/logging/kmsg/kmsg01.c
@@ -51,7 +51,7 @@
 #define NUM_READ_MSGS 3
 #define NUM_READ_RETRY 10
 #define NUM_OVERWRITE_MSGS 1024
-#define READ_TIMEOUT 5
+#define READ_TIMEOUT 5000000
 #define PRINTK "/proc/sys/kernel/printk"
 #define CONSOLE_LOGLEVEL_QUIET   4
 
@@ -148,14 +148,14 @@ static int get_msg_fields(const char *msg, unsigned long *prio,
 /*
  * timed_read - if possible reads from fd or times out
  * @fd:           fd to read from
- * @timeout_sec:  timeout in seconds
+ * @timeout_usec: timeout in useconds
  *
  * RETURNS:
  *   read bytes on successful read
  *  -1 on read() error, errno reflects read() errno
  *  -2 on timeout
  */
-static int timed_read(int fd, int timeout_sec)
+static int timed_read(int fd, long timeout_usec)
 {
 	int ret, tmp;
 	struct timeval timeout;
@@ -163,8 +163,8 @@ static int timed_read(int fd, int timeout_sec)
 
 	FD_ZERO(&read_fds);
 	FD_SET(fd, &read_fds);
-	timeout.tv_sec = timeout_sec;
-	timeout.tv_usec = 0;
+	timeout.tv_sec = timeout_usec / 1000000;
+	timeout.tv_usec = timeout_usec % 1000000;
 
 	ret = select(fd + 1, &read_fds, 0, 0, &timeout);
 	switch (ret) {
@@ -183,14 +183,14 @@ static int timed_read(int fd, int timeout_sec)
  *                   read fails or times out. This ignores any
  *                   EPIPE errors.
  * @fd:           fd to read from
- * @timeout_sec:  timeout in seconds for every read attempt
+ * @timeout_usec: timeout in useconds for every read attempt
  *
  * RETURNS:
  *     0 on read reaching eof
  *    -1 on read error, errno reflects read() errno
  *    -2 on timeout
  */
-static int timed_read_kmsg(int fd, int timeout_sec)
+static int timed_read_kmsg(int fd, long timeout_usec)
 {
 	int child, status, ret = 0;
 	int pipefd[2];
@@ -226,7 +226,7 @@ static int timed_read_kmsg(int fd, int timeout_sec)
 
 	/* parent reads pipe until it reaches eof or until read times out */
 	do {
-		TEST(timed_read(pipefd[0], timeout_sec));
+		TEST(timed_read(pipefd[0], timeout_usec));
 	} while (TEST_RETURN > 0);
 	SAFE_CLOSE(pipefd[0]);
 
-- 
1.8.3.1

