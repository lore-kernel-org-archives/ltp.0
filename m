From: Jan Stancek <jstancek@redhat.com>
Date: Mon,  4 Mar 2019 23:16:25 +0100
Subject: [LTP] [PATCH] syscalls/fanotify03: skip events from other pids when
	testing MOUNT|FILESYSTEM
Message-ID: <6e7bb2a78eea357c564b908a224e23e8231b18ef.1551737546.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

FAN_MARK_MOUNT and FAN_MARK_FILESYSTEM sets up monitoring that can
cover entire root "/". So a random background process can interfere
with test.

For example run test while running following on another terminal
to reproduce:
  while [ True ]; do ls -la /root > /dev/null; done

Test fails and hangs until timeout:
  tst_test.c:1085: INFO: Timeout per run is 0h 05m 00s
  fanotify03.c:168: INFO: Test #0: inode mark permission events
  fanotify03.c:236: PASS: got event: mask=10000 pid=7317 fd=7
  fanotify03.c:236: PASS: got event: mask=20000 pid=7317 fd=7
  fanotify03.c:136: PASS: child exited correctly
  fanotify03.c:168: INFO: Test #1: mount mark permission events
  fanotify03.c:236: PASS: got event: mask=10000 pid=7318 fd=7
  fanotify03.c:231: FAIL: got event: mask=20000 pid=7306 (expected 7318) fd=7
  fanotify03.c:223: FAIL: got event: mask=20000 (expected 0) pid=7318 fd=7
  Test timeouted, sending SIGKILL!
  tst_test.c:1125: INFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
  tst_test.c:1126: BROK: Test killed! (timeout?)

Skip events that are not from our child when testing FAN_MARK_MOUNT and
FAN_MARK_FILESYSTEM. If these are permission events, allow everything.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/fanotify/fanotify03.c | 36 +++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
index ae240a0eb505..81f1b8f76d9c 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify03.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
@@ -292,6 +292,38 @@ static void test_fanotify(unsigned int n)
 		 * reported should exactly match the event mask within the
 		 * event set.
 		 */
+
+		/* When testing MOUNT or FILESYSTEM, there is a chance
+		 * we get event that is not from our child, skip it */
+		if ((tc->mark.flag & (FAN_MARK_MOUNT | FAN_MARK_FILESYSTEM))
+			&& (event->pid != child_pid)) {
+			struct fanotify_response resp;
+
+			tst_res(TINFO,
+				"skipping event: mask=%llx pid=%u fd=%d "
+				"event->fd: %d child_pid=%u ",
+				(unsigned long long)event->mask,
+				(unsigned)event->pid, event->fd,
+				event->fd, (unsigned)child_pid);
+
+			if ((event->mask & LTP_ALL_PERM_EVENTS) == 0)
+				goto next;
+
+			resp.fd = event->fd;
+			resp.response = FAN_ALLOW;
+
+			/* We could be racing with child_handler() here,
+			 * so ignore EBADF from write() */
+			TEST(write(fd_notify, &resp, sizeof(resp)));
+			if (TST_RET == -1) {
+				if (TST_ERR != EBADF)
+					tst_brk(TBROK | TTERRNO, "write failed");
+			} else if (TST_RET != sizeof(resp)) {
+				tst_brk(TBROK, "write short: %ld", TST_RET);
+			}
+			goto next;
+		}
+
 		if (event->mask != event_set[test_num].mask) {
 			tst_res(TFAIL,
 				"got event: mask=%llx (expected %llx) "
@@ -323,12 +355,12 @@ static void test_fanotify(unsigned int n)
 			SAFE_WRITE(1, fd_notify, &resp, sizeof(resp));
 		}
 
+		test_num++;
+next:
 		i += event->event_len;
 
 		if (event->fd != FAN_NOFD)
 			SAFE_CLOSE(event->fd);
-
-		test_num++;
 	}
 
 	for (; test_num < tc->event_count; test_num++) {
-- 
1.8.3.1

