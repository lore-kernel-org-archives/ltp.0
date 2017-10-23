From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 23 Oct 2017 14:18:44 +0200
Subject: [LTP] [PATCH 3/3] kmsg01: use lower timeout for test_read_block()
In-Reply-To: <0994c420a161f2bf97de060396abd915502fca4f.1508760897.git.jstancek@redhat.com>
References: <0994c420a161f2bf97de060396abd915502fca4f.1508760897.git.jstancek@redhat.com>
Message-ID: <2b7d8d133fa22483ab594e31aa4e3b6454eea04f.1508760897.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test is currently expecting that read will block for ~5 seconds.
This is a problem for busy systems, where there are many messages
periodically generated. One example is ie31200_edac module,
which periodically generates a message every second on debug
kernels.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/logging/kmsg/kmsg01.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/logging/kmsg/kmsg01.c b/testcases/kernel/logging/kmsg/kmsg01.c
index b81c077cbd23..7f077c9a3f4c 100644
--- a/testcases/kernel/logging/kmsg/kmsg01.c
+++ b/testcases/kernel/logging/kmsg/kmsg01.c
@@ -51,7 +51,6 @@
 #define NUM_READ_MSGS 3
 #define NUM_READ_RETRY 10
 #define NUM_OVERWRITE_MSGS 1024
-#define READ_TIMEOUT 5000000
 #define PRINTK "/proc/sys/kernel/printk"
 #define CONSOLE_LOGLEVEL_QUIET   4
 
@@ -252,7 +251,7 @@ static void test_read_nonblock(void)
 	tst_res(TINFO, "TEST: nonblock read");
 	fd = SAFE_OPEN("/dev/kmsg", O_RDONLY | O_NONBLOCK);
 
-	TEST(timed_read_kmsg(fd, READ_TIMEOUT));
+	TEST(timed_read_kmsg(fd, 5000000));
 	if (TEST_RETURN == -1 && TEST_ERRNO == EAGAIN)
 		tst_res(TPASS, "non-block read returned EAGAIN");
 	else
@@ -268,7 +267,7 @@ static void test_read_block(void)
 	tst_res(TINFO, "TEST: blocking read");
 	fd = SAFE_OPEN("/dev/kmsg", O_RDONLY);
 
-	TEST(timed_read_kmsg(fd, READ_TIMEOUT));
+	TEST(timed_read_kmsg(fd, 500000));
 	if (TEST_RETURN == -2)
 		tst_res(TPASS, "read blocked");
 	else
-- 
1.8.3.1

