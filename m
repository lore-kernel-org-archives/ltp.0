From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 23 Oct 2017 14:18:42 +0200
Subject: [LTP] [PATCH 1/3] kmsg01: set/restore console log level
Message-ID: <0994c420a161f2bf97de060396abd915502fca4f.1508760897.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

commit 497564c77836 "kmsg01: lower the volume of message going to console"
lowered message priority for the flood of messages that try to overwrite
whole buffer. This works only for default console_loglevel. If anything
increases console_loglevel (for example a call to console_verbose()
via lockdep) system starts flooding also console. This causes a failure
on systems with slower serial console, because test is unable to
complete in 5 minutes.

Before patch:
  <timeout>

After patch:
  real	0m9.219s
  user	0m0.289s
  sys	0m4.027s

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/logging/kmsg/kmsg01.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/testcases/kernel/logging/kmsg/kmsg01.c b/testcases/kernel/logging/kmsg/kmsg01.c
index 294d0a2d1495..393acdcc71c6 100644
--- a/testcases/kernel/logging/kmsg/kmsg01.c
+++ b/testcases/kernel/logging/kmsg/kmsg01.c
@@ -52,7 +52,10 @@
 #define NUM_READ_RETRY 10
 #define NUM_OVERWRITE_MSGS 1024
 #define READ_TIMEOUT 5
+#define PRINTK "/proc/sys/kernel/printk"
+#define CONSOLE_LOGLEVEL_QUIET   4
 
+static int console_loglevel = -1;
 
 /*
  * inject_msg - write message to /dev/kmsg
@@ -571,7 +574,23 @@ static void test_kmsg(void)
 	test_seek();
 }
 
+static void setup(void)
+{
+	if (access(PRINTK, F_OK) == 0) {
+		SAFE_FILE_SCANF(PRINTK, "%d", &console_loglevel);
+		SAFE_FILE_PRINTF(PRINTK, "%d", CONSOLE_LOGLEVEL_QUIET);
+	}
+}
+
+static void cleanup(void)
+{
+	if (console_loglevel != -1)
+		SAFE_FILE_PRINTF(PRINTK, "%d", console_loglevel);
+}
+
 static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
 	.needs_root = 1,
 	.test_all = test_kmsg,
 	.min_kver = "3.5.0"
-- 
1.8.3.1

