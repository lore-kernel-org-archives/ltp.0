From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  7 Nov 2017 11:40:53 +0100
Subject: [LTP] [COMMITTED] [PATCH 1/2] syscalls/poll01: Convert to the new
	library.
Message-ID: <20171107104053.28656-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/poll/poll01.c | 63 ++++++++++++++-------------------
 1 file changed, 27 insertions(+), 36 deletions(-)

diff --git a/testcases/kernel/syscalls/poll/poll01.c b/testcases/kernel/syscalls/poll/poll01.c
index c641f5224..f11022b19 100644
--- a/testcases/kernel/syscalls/poll/poll01.c
+++ b/testcases/kernel/syscalls/poll/poll01.c
@@ -28,19 +28,12 @@
 #include <sys/wait.h>
 #include <sys/poll.h>
 
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 
 #define BUF_SIZE	512
 
-char *TCID = "poll01";
-int TST_TOTAL = 2;
-
 static int fildes[2];
 
-static void setup(void);
-static void cleanup(void);
-
 static void verify_pollout(void)
 {
 	struct pollfd outfds[] = {
@@ -50,16 +43,16 @@ static void verify_pollout(void)
 	TEST(poll(outfds, 1, -1));
 
 	if (TEST_RETURN == -1) {
-		tst_resm(TFAIL | TTERRNO, "poll() POLLOUT failed");
+		tst_res(TFAIL | TTERRNO, "poll() POLLOUT failed");
 		return;
 	}
 
 	if (outfds[0].revents != POLLOUT) {
-		tst_resm(TFAIL | TTERRNO, "poll() failed to set POLLOUT");
+		tst_res(TFAIL | TTERRNO, "poll() failed to set POLLOUT");
 		return;
 	}
 
-	tst_resm(TPASS, "poll() POLLOUT");
+	tst_res(TPASS, "poll() POLLOUT");
 }
 
 static void verify_pollin(void)
@@ -71,58 +64,56 @@ static void verify_pollin(void)
 		{.fd = fildes[0], .events = POLLIN},
 	};
 
-	SAFE_WRITE(cleanup, 1, fildes[1], write_buf, sizeof(write_buf));
+	SAFE_WRITE(1, fildes[1], write_buf, sizeof(write_buf));
 
 	TEST(poll(infds, 1, -1));
 
 	if (TEST_RETURN == -1) {
-		tst_resm(TFAIL | TTERRNO, "poll() POLLIN failed");
+		tst_res(TFAIL | TTERRNO, "poll() POLLIN failed");
 		goto end;
 	}
 
 	if (infds[0].revents != POLLIN) {
-		tst_resm(TFAIL, "poll() failed to set POLLIN");
+		tst_res(TFAIL, "poll() failed to set POLLIN");
 		goto end;
 	}
 
 
-	tst_resm(TPASS, "poll() POLLIN");
+	tst_res(TPASS, "poll() POLLIN");
 
 end:
-	SAFE_READ(cleanup, 1, fildes[0], read_buf, sizeof(write_buf));
+	SAFE_READ(1, fildes[0], read_buf, sizeof(write_buf));
 }
 
-int main(int ac, char **av)
+void verify_poll(unsigned int n)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	switch (n) {
+	case 0:
 		verify_pollout();
+	break;
+	case 1:
 		verify_pollin();
+	break;
 	}
-
-	cleanup();
-	tst_exit();
 }
 
 static void setup(void)
 {
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	SAFE_PIPE(NULL, fildes);
+	SAFE_PIPE(fildes);
 }
 
 static void cleanup(void)
 {
-	if (close(fildes[0]))
-		tst_resm(TWARN | TERRNO, "failed to close fildes[0]");
+	if (fildes[0] > 0)
+		SAFE_CLOSE(fildes[0]);
 
-	if (close(fildes[1]))
-		tst_resm(TWARN | TERRNO, "failed to close fildes[1]");
+	if (fildes[1] > 0)
+		SAFE_CLOSE(fildes[1]);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_poll,
+	.tcnt = 2,
+};
-- 
2.13.5

