From: Steve Muckle <smuckle.linux@gmail.com>
Date: Fri, 14 Jul 2017 18:37:40 -0700
Subject: [LTP] [PATCH 1/2] syscalls/epoll_*: allow for epoll_wait returning
	a subset of events
Message-ID: <20170715013741.102781-1-smuckle.linux@gmail.com>
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
 testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c  | 67 +++++++++++++------
 .../kernel/syscalls/epoll_wait/epoll_wait01.c      | 75 ++++++++++++++--------
 2 files changed, 97 insertions(+), 45 deletions(-)

diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c
index 0fa1ab25f..c68b39471 100644
--- a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c
+++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c
@@ -85,7 +85,7 @@ static int has_event(struct epoll_event *epvs, int len,
 static void check_epoll_ctl(int opt, int exp_num)
 {
 	int res;
-
+	unsigned int events;
 	char write_buf[] = "test";
 	char read_buf[sizeof(write_buf)];
 
@@ -94,32 +94,59 @@ static void check_epoll_ctl(int opt, int exp_num)
 		{.events = 0, .data.fd = 0}
 	};
 
+	events = EPOLLIN;
+	if (exp_num == 2)
+		events |= EPOLLOUT;
+
 	SAFE_WRITE(1, fd[1], write_buf, sizeof(write_buf));
 
-	res = epoll_wait(epfd, res_evs, 2, -1);
-	if (res == -1)
-		tst_brk(TBROK | TERRNO, "epoll_wait() fails");
+	while (events) {
+		int events_returned = 0;
 
-	if (res != exp_num) {
-		tst_res(TFAIL, "epoll_wait() returns %i, expected %i",
-			res, exp_num);
-		goto end;
-	}
+		bzero(res_evs, sizeof(res_evs));
+		res = epoll_wait(epfd, res_evs, 2, -1);
+		if (res == -1)
+			tst_brk(TBROK | TERRNO, "epoll_wait() fails");
 
-	if (exp_num == 1) {
-		if (!has_event(res_evs, 2, fd[0], EPOLLIN) ||
-		    !has_event(res_evs, 2, 0, 0)) {
-			tst_res(TFAIL, "epoll_wait() fails to "
-				"get expected fd and event");
+		if (res == 0) {
+			tst_res(TFAIL, "epoll_wait() returns 0, expected %s",
+				events == (EPOLLIN|EPOLLOUT) ? "1 or 2" : "1");
 			goto end;
 		}
-	}
 
-	if (exp_num == 2) {
-		if (!has_event(res_evs, 2, fd[0], EPOLLIN) ||
-		    !has_event(res_evs, 2, fd[1], EPOLLOUT)) {
-			tst_res(TFAIL, "epoll_wait() fails to "
-				"get expected fd and event");
+		if (res == 1 && (res_evs[1].data.fd || res_evs[1].events)) {
+			tst_res(TFAIL,
+				"epoll_wait() returns 1 with 2 events");
+			goto end;
+		}
+
+		if (has_event(res_evs, 2, fd[0], EPOLLIN)) {
+			if (events & EPOLLIN) {
+				events &= ~EPOLLIN;
+				events_returned++;
+			} else {
+				tst_res(TFAIL, "epoll_wait() returned %d "
+					"and EPOLLIN %x twice", fd[0],
+					EPOLLIN);
+				goto end;
+			}
+		}
+
+		if (has_event(res_evs, 2, fd[1], EPOLLOUT)) {
+			if (events & EPOLLOUT) {
+				events &= ~EPOLLOUT;
+				events_returned++;
+			} else {
+				tst_res(TFAIL, "epoll_wait() returned %d "
+					"and EPOLLOUT %x twice", fd[1],
+					EPOLLOUT);
+				goto end;
+			}
+		}
+
+		if (res != events_returned) {
+			tst_res(TFAIL, "epoll_wait() returned %d, expected %d",
+				res, events_returned);
 			goto end;
 		}
 	}
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
index c8c55720f..1ea1ca2ec 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
@@ -200,34 +200,59 @@ static void verify_epollio(void)
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
+		int events_returned = 0;
+
+		TEST(epoll_wait(epfd, epevs, 3, -1));
+
+		if (TEST_RETURN == -1) {
+			tst_resm(TFAIL | TTERRNO, "epoll_wait() epollio failed");
+			goto end;
+		}
+
+		if (TEST_RETURN == 0) {
+			tst_resm(TFAIL, "epoll_wait() returned 0, expected %s",
+				 events == (EPOLLIN|EPOLLOUT) ? "1 or 2" : "1");
+			goto end;
+		}
+
+		if (has_event(epevs, 2, fds[0], EPOLLIN)) {
+			if (events & EPOLLIN) {
+				events &= ~EPOLLIN;
+				events_returned++;
+			} else {
+				dump_epevs(epevs, 2);
+				tst_resm(TFAIL, "epoll_wait() returned %d "
+					 "and EPOLLIN %x twice", fds[0],
+					 EPOLLIN);
+				goto end;
+			}
+		}
+
+		if (has_event(epevs, 2, fds[1], EPOLLOUT)) {
+			if (events & EPOLLOUT) {
+				events &= ~EPOLLOUT;
+				events_returned++;
+			} else {
+				dump_epevs(epevs, 2);
+				tst_resm(TFAIL, "epoll_wait() returned %d "
+					 "and EPOLLOUT %x twice", fds[1],
+					 EPOLLOUT);
+				goto end;
+			}
+		}
+
+		if (TEST_RETURN != events_returned) {
+			dump_epevs(epevs, 2);
+			tst_resm(TFAIL,
+				 "epoll_wait() returned %li, expected %d",
+				 TEST_RETURN, events_returned);
+			goto end;
+		}
 	}
 
 	tst_resm(TPASS, "epoll_wait() epollio");
-- 
2.13.2.932.g7449e964c-goog

