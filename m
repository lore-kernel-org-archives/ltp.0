From: Steve Muckle <smuckle.linux@gmail.com>
Date: Fri, 14 Jul 2017 18:37:41 -0700
Subject: [LTP] [PATCH 2/2] syscalls/epoll_wait01: cleanup data structure
	usage
In-Reply-To: <20170715013741.102781-1-smuckle.linux@gmail.com>
References: <20170715013741.102781-1-smuckle.linux@gmail.com>
Message-ID: <20170715013741.102781-2-smuckle.linux@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The fds2 data structure is not used during the test, remove it.
Ensure the event structure that epoll_wait() writes into is cleared
prior to invoking the call so that the returned data is confidently
known.

Signed-off-by: Steve Muckle <smuckle.linux@gmail.com>
---
 .../kernel/syscalls/epoll_wait/epoll_wait01.c      | 58 +++++++++++-----------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
index 1ea1ca2ec..5aa34d5df 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
@@ -34,11 +34,10 @@
 char *TCID = "epoll_wait01";
 int TST_TOTAL = 3;
 
-static int write_size, epfd, fds[2], fds2[2];
-static struct epoll_event epevs[3] = {
+static int write_size, epfd, fds[2];
+static struct epoll_event epevs[2] = {
 	{.events = EPOLLIN},
 	{.events = EPOLLOUT},
-	{.events = EPOLLIN}
 };
 
 static void setup(void);
@@ -77,7 +76,6 @@ static void setup(void)
 	TEST_PAUSE;
 
 	SAFE_PIPE(NULL, fds);
-	SAFE_PIPE(cleanup, fds2);
 
 	write_size = get_writesize();
 
@@ -89,11 +87,9 @@ static void setup(void)
 
 	epevs[0].data.fd = fds[0];
 	epevs[1].data.fd = fds[1];
-	epevs[2].data.fd = fds2[0];
 
 	if (epoll_ctl(epfd, EPOLL_CTL_ADD, fds[0], &epevs[0]) ||
-	    epoll_ctl(epfd, EPOLL_CTL_ADD, fds[1], &epevs[1]) ||
-	    epoll_ctl(epfd, EPOLL_CTL_ADD, fds2[0], &epevs[2])) {
+	    epoll_ctl(epfd, EPOLL_CTL_ADD, fds[1], &epevs[1])) {
 		tst_brkm(TBROK | TERRNO, cleanup,
 			 "failed to register epoll target");
 	}
@@ -128,7 +124,9 @@ static int get_writesize(void)
 
 static void verify_epollout(void)
 {
-	TEST(epoll_wait(epfd, epevs, 3, -1));
+	struct epoll_event ret_evs = {.events = 0, .data.fd = 0};
+
+	TEST(epoll_wait(epfd, &ret_evs, 1, -1));
 
 	if (TEST_RETURN == -1) {
 		tst_resm(TFAIL | TTERRNO, "epoll_wait() epollout failed");
@@ -141,15 +139,15 @@ static void verify_epollout(void)
 		return;
 	}
 
-	if (epevs[0].data.fd != fds[1]) {
+	if (ret_evs.data.fd != fds[1]) {
 		tst_resm(TFAIL, "epoll.data.fd %i, expected %i",
-			 epevs[0].data.fd, fds[1]);
+			 ret_evs.data.fd, fds[1]);
 		return;
 	}
 
-	if (epevs[0].events != EPOLLOUT) {
+	if (ret_evs.events != EPOLLOUT) {
 		tst_resm(TFAIL, "epoll.events %x, expected EPOLLOUT %x",
-			 epevs[0].events, EPOLLOUT);
+			 ret_evs.events, EPOLLOUT);
 		return;
 	}
 
@@ -160,12 +158,13 @@ static void verify_epollin(void)
 {
 	char write_buf[write_size];
 	char read_buf[sizeof(write_buf)];
+	struct epoll_event ret_evs = {.events = 0, .data.fd = 0};
 
 	memset(write_buf, 'a', sizeof(write_buf));
 
 	SAFE_WRITE(cleanup, 1, fds[1], write_buf, sizeof(write_buf));
 
-	TEST(epoll_wait(epfd, epevs, 3, -1));
+	TEST(epoll_wait(epfd, &ret_evs, 1, -1));
 
 	if (TEST_RETURN == -1) {
 		tst_resm(TFAIL | TTERRNO, "epoll_wait() epollin failed");
@@ -178,15 +177,15 @@ static void verify_epollin(void)
 		goto end;
 	}
 
-	if (epevs[0].data.fd != fds[0]) {
+	if (ret_evs.data.fd != fds[0]) {
 		tst_resm(TFAIL, "epoll.data.fd %i, expected %i",
-			 epevs[0].data.fd, fds[0]);
+			 ret_evs.data.fd, fds[0]);
 		goto end;
 	}
 
-	if (epevs[0].events != EPOLLIN) {
+	if (ret_evs.events != EPOLLIN) {
 		tst_resm(TFAIL, "epoll.events %x, expected EPOLLIN %x",
-			 epevs[0].events, EPOLLIN);
+			 ret_evs.events, EPOLLIN);
 		goto end;
 	}
 
@@ -201,13 +200,15 @@ static void verify_epollio(void)
 	char write_buf[] = "Testing";
 	char read_buf[sizeof(write_buf)];
 	uint32_t events = EPOLLIN | EPOLLOUT;
+	struct epoll_event ret_evs[2];
 
 	SAFE_WRITE(cleanup, 1, fds[1], write_buf, sizeof(write_buf));
 
 	while (events) {
 		int events_returned = 0;
 
-		TEST(epoll_wait(epfd, epevs, 3, -1));
+		bzero(ret_evs, sizeof(ret_evs));
+		TEST(epoll_wait(epfd, ret_evs, 2, -1));
 
 		if (TEST_RETURN == -1) {
 			tst_resm(TFAIL | TTERRNO, "epoll_wait() epollio failed");
@@ -220,12 +221,17 @@ static void verify_epollio(void)
 			goto end;
 		}
 
-		if (has_event(epevs, 2, fds[0], EPOLLIN)) {
+		if (TEST_RETURN == 1 && (ret_evs[1].data.fd || ret_evs[1].events)) {
+			tst_resm(TFAIL, "epoll_wait() returns 1 with 2 events");
+			goto end;
+		}
+
+		if (has_event(ret_evs, 2, fds[0], EPOLLIN)) {
 			if (events & EPOLLIN) {
 				events &= ~EPOLLIN;
 				events_returned++;
 			} else {
-				dump_epevs(epevs, 2);
+				dump_epevs(ret_evs, 2);
 				tst_resm(TFAIL, "epoll_wait() returned %d "
 					 "and EPOLLIN %x twice", fds[0],
 					 EPOLLIN);
@@ -233,12 +239,12 @@ static void verify_epollio(void)
 			}
 		}
 
-		if (has_event(epevs, 2, fds[1], EPOLLOUT)) {
+		if (has_event(ret_evs, 2, fds[1], EPOLLOUT)) {
 			if (events & EPOLLOUT) {
 				events &= ~EPOLLOUT;
 				events_returned++;
 			} else {
-				dump_epevs(epevs, 2);
+				dump_epevs(ret_evs, 2);
 				tst_resm(TFAIL, "epoll_wait() returned %d "
 					 "and EPOLLOUT %x twice", fds[1],
 					 EPOLLOUT);
@@ -247,7 +253,7 @@ static void verify_epollio(void)
 		}
 
 		if (TEST_RETURN != events_returned) {
-			dump_epevs(epevs, 2);
+			dump_epevs(ret_evs, 2);
 			tst_resm(TFAIL,
 				 "epoll_wait() returned %li, expected %d",
 				 TEST_RETURN, events_returned);
@@ -294,10 +300,4 @@ static void cleanup(void)
 
 	if (close(fds[1]))
 		tst_resm(TWARN | TERRNO, "failed to close fds[1]");
-
-	if (fds2[0] > 0 && close(fds2[0]))
-		tst_resm(TWARN | TERRNO, "failed to close fds2[0]");
-
-	if (fds2[1] > 0 && close(fds2[1]))
-		tst_resm(TWARN | TERRNO, "failed to close fds2[1]");
 }
-- 
2.13.2.932.g7449e964c-goog

