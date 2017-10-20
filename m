From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 20 Oct 2017 10:32:29 +0200
Subject: [LTP] [PATCH] clone08: don't treat EWOULDBLOCK as failure
Message-ID: <3d13f6b0963589472e7fb85b3a4a9ff75c48a004.1508488263.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

futex() and clone() are racing in test_clone_thread().
If clone() changes ctid first, then futex() reports
EWOULDBLOCK and test treats that as failure.

We don't need to eliminate the race, since all we
care about is that ctid is changed/cleared by clone().

Also fix a small warning from unused variable.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/clone/clone08.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/clone/clone08.c b/testcases/kernel/syscalls/clone/clone08.c
index 58f9be0e20bf..a228b2f73762 100644
--- a/testcases/kernel/syscalls/clone/clone08.c
+++ b/testcases/kernel/syscalls/clone/clone08.c
@@ -133,9 +133,7 @@ static int child_clone_parent(void *arg LTP_ATTRIBUTE_UNUSED)
 
 static void test_clone_tid(int t)
 {
-	pid_t child;
-
-	child = clone_child(&test_cases[t]);
+	clone_child(&test_cases[t]);
 	tst_reap_children();
 }
 
@@ -206,11 +204,22 @@ static void test_clone_thread(int t)
 
 		clone_child(&test_cases[t]);
 
-		if (syscall(SYS_futex, &ctid, FUTEX_WAIT, -1, &timeout))
-			tst_res(TFAIL | TERRNO, "futex failed");
-		else
-			tst_res(TPASS, "futex exit on ctid change");
-
+		if (syscall(SYS_futex, &ctid, FUTEX_WAIT, -1, &timeout)) {
+			/*
+			 * futex here is racing with clone() above.
+			 * Which means we can get EWOULDBLOCK if
+			 * ctid has been already changed by clone()
+			 * before we make the call. As long as ctid
+			 * changes we should not report error when
+			 * futex returns EWOULDBLOCK.
+			 */
+			if (errno != EWOULDBLOCK || ctid == -1) {
+				tst_res(TFAIL | TERRNO,
+					"futex failed, ctid: %d", ctid);
+				_exit(0);
+			}
+		}
+		tst_res(TPASS, "futex exit on ctid change, ctid: %d", ctid);
 		_exit(0);
 	}
 
-- 
1.8.3.1

