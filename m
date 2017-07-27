From: Steve Muckle <smuckle.linux@gmail.com>
Date: Thu, 27 Jul 2017 12:06:46 -0700
Subject: [LTP] [PATCH v2 1/2] syscalls/epoll_*: allow for epoll_wait
	returning a subset of events
Message-ID: <20170727190647.116088-1-smuckle.linux@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The epoll_wait syscall is not guaranteed to return all pending events -
a subset may be returned. Modify the epoll_wait01 and epoll_ctl01
testcases to allow for that.

CC: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: Steve Muckle <smuckle.linux@gmail.com>
---
 testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c  | 52 ++++++++++----------
 .../kernel/syscalls/epoll_wait/epoll_wait01.c      | 55 ++++++++++++----------
 2 files changed, 57 insertions(+), 50 deletions(-)

diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c
index 0fa1ab25f..f3599de50 100644
--- a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c
+++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c
@@ -85,41 +85,43 @@ static int has_event(struct epoll_event *epvs, int len,
 static void check_epoll_ctl(int opt, int exp_num)
 {
 	int res;
-
+	unsigned int events;
 	char write_buf[] = "test";
 	char read_buf[sizeof(write_buf)];
+	struct epoll_event res_evs[2];
 
-	struct epoll_event res_evs[2] = {
-		{.events = 0, .data.fd = 0},
-		{.events = 0, .data.fd = 0}
-	};
+	events = EPOLLIN;
+	if (exp_num == 2)
+		events |= EPOLLOUT;
 
 	SAFE_WRITE(1, fd[1], write_buf, sizeof(write_buf));
 
-	res = epoll_wait(epfd, res_evs, 2, -1);
-	if (res == -1)
-		tst_brk(TBROK | TERRNO, "epoll_wait() fails");
-
-	if (res != exp_num) {
-		tst_res(TFAIL, "epoll_wait() returns %i, expected %i",
-			res, exp_num);
-		goto end;
-	}
+	while (events) {
+		int events_matched = 0;
+		bzero(res_evs, sizeof(res_evs));
 
-	if (exp_num == 1) {
-		if (!has_event(res_evs, 2, fd[0], EPOLLIN) ||
-		    !has_event(res_evs, 2, 0, 0)) {
-			tst_res(TFAIL, "epoll_wait() fails to "
-				"get expected fd and event");
+		res = epoll_wait(epfd, res_evs, 2, -1);
+		if (res <= 0) {
+			tst_res(TFAIL | TERRNO, "epoll_wait() returned %i",
+				res);
 			goto end;
 		}
-	}
 
-	if (exp_num == 2) {
-		if (!has_event(res_evs, 2, fd[0], EPOLLIN) ||
-		    !has_event(res_evs, 2, fd[1], EPOLLOUT)) {
-			tst_res(TFAIL, "epoll_wait() fails to "
-				"get expected fd and event");
+		if ((events & EPOLLIN) &&
+		    has_event(res_evs, 2, fd[0], EPOLLIN)) {
+			events_matched++;
+			events &= ~EPOLLIN;
+		}
+
+		if ((events & EPOLLOUT) &&
+		    has_event(res_evs, 2, fd[1], EPOLLOUT)) {
+			events_matched++;
+			events &= ~EPOLLOUT;
+		}
+
+		if (res != events_matched) {
+			tst_res(TFAIL,
+				"epoll_wait() returned unexpected events");
 			goto end;
 		}
 	}
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
index c8c55720f..10f8b6ca6 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
@@ -200,34 +200,39 @@ static void verify_epollio(void)
 {
 	char write_buf[] = "Testing";
 	char read_buf[sizeof(write_buf)];
+	uint32_t events = EPOLLIN | EPOLLOUT;
 
 	SAFE_WRITE(cleanup, 1, fds[1], write_buf, sizeof(write_buf));
 
-	TEST(epoll_wait(epfd, epevs, 3, -1));
-
-	if (TEST_RETURN == -1) {
-		tst_resm(TFAIL | TTERRNO, "epoll_wait() epollio failed");
-		goto end;
-	}
-
-	if (TEST_RETURN != 2) {
-		tst_resm(TFAIL, "epoll_wait() returned %li, expected 2",
-			 TEST_RETURN);
-		goto end;
-	}
-
-	if (!has_event(epevs, 2, fds[0], EPOLLIN)) {
-		dump_epevs(epevs, 2);
-		tst_resm(TFAIL, "epoll_wait() expected %d and EPOLLIN %x",
-			 fds[0], EPOLLIN);
-		goto end;
-	}
-
-	if (!has_event(epevs, 2, fds[1], EPOLLOUT)) {
-		dump_epevs(epevs, 2);
-		tst_resm(TFAIL, "epoll_wait() expected %d and EPOLLOUT %x",
-			 fds[1], EPOLLOUT);
-		goto end;
+	while (events) {
+		int events_matched = 0;
+
+		TEST(epoll_wait(epfd, epevs, 3, -1));
+
+		if (TEST_RETURN <= 0) {
+			tst_resm(TFAIL | TTERRNO, "epoll_wait() returned %i",
+				 TEST_RETURN);
+			goto end;
+		}
+
+		if ((events & EPOLLIN) &&
+		    has_event(epevs, 2, fds[0], EPOLLIN)) {
+			events_matched++;
+			events &= ~EPOLLIN;
+		}
+
+		if ((events & EPOLLOUT) &&
+		    has_event(epevs, 2, fds[1], EPOLLOUT)) {
+			events_matched++;
+			events &= ~EPOLLOUT;
+		}
+
+		if (TEST_RETURN != events_matched) {
+			tst_resm(TFAIL,
+				 "epoll_wait() returned unexpected events");
+			dump_epevs(epevs, 2);
+			goto end;
+		}
 	}
 
 	tst_resm(TPASS, "epoll_wait() epollio");
-- 
2.14.0.rc0.400.g1c36432dff-goog

