From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 28 Jul 2017 12:19:03 +0200
Subject: [LTP] [PATCH] [COMMITTED] syscalls/epoll_wait01: Convert to new
	library.
Message-ID: <20170728101903.3619-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../kernel/syscalls/epoll_wait/epoll_wait01.c      | 205 ++++++++++-----------
 1 file changed, 94 insertions(+), 111 deletions(-)

diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
index 01c669a5f..7d28b5fbc 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
@@ -28,98 +28,83 @@
 #include <string.h>
 #include <errno.h>
 
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "epoll_wait01";
-int TST_TOTAL = 3;
+#include "tst_test.h"
 
 static int write_size, epfd, fds[2];
-static struct epoll_event epevs[2] = {
-	{.events = EPOLLIN},
-	{.events = EPOLLOUT},
-};
-
-static void setup(void);
-static int get_writesize(void);
-static void verify_epollout(void);
-static void verify_epollin(void);
-static void verify_epollio(void);
-static int has_event(struct epoll_event *, int, int, uint32_t);
-static void dump_epevs(struct epoll_event *, int);
-static void cleanup(void);
 
-int main(int ac, char **av)
+static int get_writesize(void)
 {
-	int lc;
+	int nfd, write_size = 0;
+	char buf[4096];
+
+	struct pollfd pfd[] = {
+		{.fd = fds[1], .events = POLLOUT},
+	};
 
-	tst_parse_opts(ac, av, NULL, NULL);
+	memset(buf, 'a', sizeof(buf));
 
-	setup();
+	do {
+		write_size += SAFE_WRITE(0, fds[1], buf, sizeof(buf));
+		nfd = poll(pfd, 1, 1);
+		if (nfd == -1)
+			tst_brk(TBROK | TERRNO, "poll() failed");
+	} while (nfd > 0);
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
+	char read_buf[write_size];
 
-		verify_epollout();
-		verify_epollin();
-		verify_epollio();
-	}
+	SAFE_READ(1, fds[0], read_buf, sizeof(read_buf));
 
-	cleanup();
-	tst_exit();
+	tst_res(TINFO, "Pipe buffer size is %i bytes", write_size);
+
+	return write_size;
 }
 
 static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	static struct epoll_event epevs[2] = {
+		{.events = EPOLLIN},
+		{.events = EPOLLOUT},
+	};
 
-	TEST_PAUSE;
+	SAFE_PIPE(fds);
 
-	SAFE_PIPE(NULL, fds);
+	epevs[0].data.fd = fds[0];
+	epevs[1].data.fd = fds[1];
 
 	write_size = get_writesize();
 
 	epfd = epoll_create(3);
-	if (epfd == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "failed to create epoll instance");
-	}
+	if (epfd == -1)
+		tst_brk(TBROK | TERRNO, "epoll_create() failed");
 
-	epevs[0].data.fd = fds[0];
-	epevs[1].data.fd = fds[1];
 
 	if (epoll_ctl(epfd, EPOLL_CTL_ADD, fds[0], &epevs[0]) ||
 	    epoll_ctl(epfd, EPOLL_CTL_ADD, fds[1], &epevs[1])) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "failed to register epoll target");
+		tst_brk(TBROK | TERRNO, "epoll_ctl() failed");
 	}
 }
 
-static int get_writesize(void)
+static int has_event(struct epoll_event *epevs, int epevs_len,
+		     int fd, uint32_t events)
 {
-	int nfd, write_size = 0;
-	char buf[4096];
-
-	struct pollfd pfd[] = {
-		{.fd = fds[1], .events = POLLOUT},
-	};
-
-	memset(buf, 'a', sizeof(buf));
-
-	do {
-		write_size += SAFE_WRITE(cleanup, 0, fds[1], buf, sizeof(buf));
-		nfd = poll(pfd, 1, 1);
-		if (nfd == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "poll failed");
-	} while (nfd > 0);
+	int i;
 
-	char read_buf[write_size];
+	for (i = 0; i < epevs_len; i++) {
+		if ((epevs[i].data.fd == fd) && (epevs[i].events == events))
+			return 1;
+	}
 
-	SAFE_READ(cleanup, 1, fds[0], read_buf, sizeof(read_buf));
+	return 0;
+}
 
-	tst_resm(TINFO, "Pipe buffer size is %i bytes", write_size);
+static void dump_epevs(struct epoll_event *epevs, int epevs_len)
+{
+	int i;
 
-	return write_size;
+	for (i = 0; i < epevs_len; i++) {
+		tst_res(TINFO, "epevs[%d]: epoll.data.fd %d, epoll.events %x",
+			i, epevs[i].data.fd, epevs[i].events);
+	}
 }
 
 static void verify_epollout(void)
@@ -129,29 +114,29 @@ static void verify_epollout(void)
 	TEST(epoll_wait(epfd, &ret_evs, 1, -1));
 
 	if (TEST_RETURN == -1) {
-		tst_resm(TFAIL | TTERRNO, "epoll_wait() epollout failed");
+		tst_res(TFAIL | TTERRNO, "epoll_wait() epollout failed");
 		return;
 	}
 
 	if (TEST_RETURN != 1) {
-		tst_resm(TFAIL, "epoll_wait() returned %li, expected 1",
-			 TEST_RETURN);
+		tst_res(TFAIL, "epoll_wait() returned %li, expected 1",
+			TEST_RETURN);
 		return;
 	}
 
 	if (ret_evs.data.fd != fds[1]) {
-		tst_resm(TFAIL, "epoll.data.fd %i, expected %i",
-			 ret_evs.data.fd, fds[1]);
+		tst_res(TFAIL, "epoll.data.fd %i, expected %i",
+			ret_evs.data.fd, fds[1]);
 		return;
 	}
 
 	if (ret_evs.events != EPOLLOUT) {
-		tst_resm(TFAIL, "epoll.events %x, expected EPOLLOUT %x",
-			 ret_evs.events, EPOLLOUT);
+		tst_res(TFAIL, "epoll.events %x, expected EPOLLOUT %x",
+			ret_evs.events, EPOLLOUT);
 		return;
 	}
 
-	tst_resm(TPASS, "epoll_wait() epollout");
+	tst_res(TPASS, "epoll_wait() epollout");
 }
 
 static void verify_epollin(void)
@@ -162,37 +147,37 @@ static void verify_epollin(void)
 
 	memset(write_buf, 'a', sizeof(write_buf));
 
-	SAFE_WRITE(cleanup, 1, fds[1], write_buf, sizeof(write_buf));
+	SAFE_WRITE(1, fds[1], write_buf, sizeof(write_buf));
 
 	TEST(epoll_wait(epfd, &ret_evs, 1, -1));
 
 	if (TEST_RETURN == -1) {
-		tst_resm(TFAIL | TTERRNO, "epoll_wait() epollin failed");
+		tst_res(TFAIL | TTERRNO, "epoll_wait() epollin failed");
 		goto end;
 	}
 
 	if (TEST_RETURN != 1) {
-		tst_resm(TFAIL, "epoll_wait() returned %li, expected 1",
-			 TEST_RETURN);
+		tst_res(TFAIL, "epoll_wait() returned %li, expected 1",
+			TEST_RETURN);
 		goto end;
 	}
 
 	if (ret_evs.data.fd != fds[0]) {
-		tst_resm(TFAIL, "epoll.data.fd %i, expected %i",
-			 ret_evs.data.fd, fds[0]);
+		tst_res(TFAIL, "epoll.data.fd %i, expected %i",
+			ret_evs.data.fd, fds[0]);
 		goto end;
 	}
 
 	if (ret_evs.events != EPOLLIN) {
-		tst_resm(TFAIL, "epoll.events %x, expected EPOLLIN %x",
-			 ret_evs.events, EPOLLIN);
+		tst_res(TFAIL, "epoll.events %x, expected EPOLLIN %x",
+			ret_evs.events, EPOLLIN);
 		goto end;
 	}
 
-	tst_resm(TPASS, "epoll_wait() epollin");
+	tst_res(TPASS, "epoll_wait() epollin");
 
 end:
-	SAFE_READ(cleanup, 1, fds[0], read_buf, sizeof(write_buf));
+	SAFE_READ(1, fds[0], read_buf, sizeof(write_buf));
 }
 
 static void verify_epollio(void)
@@ -202,7 +187,7 @@ static void verify_epollio(void)
 	uint32_t events = EPOLLIN | EPOLLOUT;
 	struct epoll_event ret_evs[2];
 
-	SAFE_WRITE(cleanup, 1, fds[1], write_buf, sizeof(write_buf));
+	SAFE_WRITE(1, fds[1], write_buf, sizeof(write_buf));
 
 	while (events) {
 		int events_matched = 0;
@@ -211,8 +196,8 @@ static void verify_epollio(void)
 		TEST(epoll_wait(epfd, ret_evs, 2, -1));
 
 		if (TEST_RETURN <= 0) {
-			tst_resm(TFAIL | TTERRNO, "epoll_wait() returned %li",
-				 TEST_RETURN);
+			tst_res(TFAIL | TTERRNO, "epoll_wait() returned %li",
+				TEST_RETURN);
 			goto end;
 		}
 
@@ -229,50 +214,48 @@ static void verify_epollio(void)
 		}
 
 		if (TEST_RETURN != events_matched) {
-			tst_resm(TFAIL,
-				 "epoll_wait() returned unexpected events");
+			tst_res(TFAIL,
+				"epoll_wait() returned unexpected events");
 			dump_epevs(ret_evs, 2);
 			goto end;
 		}
 	}
 
-	tst_resm(TPASS, "epoll_wait() epollio");
+	tst_res(TPASS, "epoll_wait() epollio");
 
 end:
-	SAFE_READ(cleanup, 1, fds[0], read_buf, sizeof(write_buf));
+	SAFE_READ(1, fds[0], read_buf, sizeof(write_buf));
 }
 
-static int has_event(struct epoll_event *epevs, int epevs_len,
-	int fd, uint32_t events)
+static void cleanup(void)
 {
-	int i;
+	if (epfd > 0)
+		SAFE_CLOSE(epfd);
 
-	for (i = 0; i < epevs_len; i++) {
-		if ((epevs[i].data.fd == fd) && (epevs[i].events == events))
-			return 1;
+	if (fds[0]) {
+		SAFE_CLOSE(fds[0]);
+		SAFE_CLOSE(fds[1]);
 	}
-
-	return 0;
 }
 
-static void dump_epevs(struct epoll_event *epevs, int epevs_len)
+static void do_test(unsigned int n)
 {
-	int i;
-
-	for (i = 0; i < epevs_len; i++) {
-		tst_resm(TINFO, "epevs[%d]: epoll.data.fd %d, epoll.events %x",
-			 i, epevs[i].data.fd, epevs[i].events);
+	switch (n) {
+	case 0:
+		verify_epollout();
+	break;
+	case 1:
+		verify_epollin();
+	break;
+	case 2:
+		verify_epollio();
+	break;
 	}
 }
 
-static void cleanup(void)
-{
-	if (epfd > 0 && close(epfd))
-		tst_resm(TWARN | TERRNO, "failed to close epfd");
-
-	if (close(fds[0]))
-		tst_resm(TWARN | TERRNO, "failed to close fds[0]");
-
-	if (close(fds[1]))
-		tst_resm(TWARN | TERRNO, "failed to close fds[1]");
-}
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = do_test,
+	.tcnt = 3,
+};
-- 
2.13.0

