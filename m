From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 9 Oct 2017 17:57:03 +0800
Subject: [LTP] [PATCH] kernel/input: fix failure on an old kernel
Message-ID: <1507543023-21605-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On some old kernels(e.g. v2.6.32), we always triggered the following
error when running input04 and input05:
--------------------------------------------------------------------
TINFO  :  Found uinput dev at /dev/uinput
TINFO  :  Unexpected ev type=0 code=0 value=0
TFAIL  :  Data received /dev/inputX
---------------------------------------------------------------------

After investigation, the single EV_SYN event can be processed on an
old kernel.  However, the EV_SYN event handling has been modfied by
the following patch:
'4369c64c79a2("Input: Send events one packet at a time")'

The patch is designed to reduce the time taken for processing a lot of
events.  As a side effect, the single EV_SYN event handling depends on
one or more other events(e.g. EV_REL), so it should be processed
together with others, since this action is atomic.

Only when the number of queued events(include EV_SYN) is greater than
one can these events be processed.
Please see the kenrel code in drivers/input/input.c, as below:
--------------------------------------------------------------------
static void input_handle_event(struct input_dev *dev,
...
    if (disposition & INPUT_FLUSH) {
            // num_vals: number of values queued in the current frame
            if (dev->num_vals >= 2)
                    input_pass_values(dev, dev->vals, dev->num_vals);
                    dev->num_vals = 0;
...
--------------------------------------------------------------------

For example, steps to send an empty move and EV_SYN:
-----------------------------------------------------
send_event(fd, EV_REL, REL_X, 0);
send_event(fd, EV_SYN, 0, 0);
-----------------------------------------------------

On an old kernel(before v3.7.0), the EV_SYN/SYN_REPORT event can be
processed independently, so it is passed into /dev/input/eventX.

On a new kernel(since v3.7.0), the EV_SYN/SYN_REPORT event depends on
EV_REL/REL_X which is an empty move, so it is ignored.

We feel this failure is due to the different mechanism of processing
EV_SYN instead of a kernel bug, so we update no_events_queued() to
fix it.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/input/input02.c      |  2 +-
 testcases/kernel/input/input04.c      |  2 +-
 testcases/kernel/input/input05.c      |  2 +-
 testcases/kernel/input/input_helper.c | 26 +++++++++++++++++++++-----
 testcases/kernel/input/input_helper.h |  2 +-
 5 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/input/input02.c b/testcases/kernel/input/input02.c
index df3b257..4f77758 100644
--- a/testcases/kernel/input/input02.c
+++ b/testcases/kernel/input/input02.c
@@ -61,7 +61,7 @@ int main(int ac, char **av)
 		case -1:
 			tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
 		default:
-			if (no_events_queued(fd2))
+			if (no_events_queued(fd2, 1))
 				tst_resm(TPASS, "No data received in eventX");
 			else
 				tst_resm(TFAIL, "Data received in eventX");
diff --git a/testcases/kernel/input/input04.c b/testcases/kernel/input/input04.c
index 4b16ca7..e20b4f6 100644
--- a/testcases/kernel/input/input04.c
+++ b/testcases/kernel/input/input04.c
@@ -57,7 +57,7 @@ int main(int ac, char **av)
 		case -1:
 			tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
 		default:
-			if (no_events_queued(fd2))
+			if (no_events_queued(fd2, 0))
 				tst_resm(TPASS,
 					"No data received in /dev/inputX");
 			else
diff --git a/testcases/kernel/input/input05.c b/testcases/kernel/input/input05.c
index 5ca01d8..e8251a3 100644
--- a/testcases/kernel/input/input05.c
+++ b/testcases/kernel/input/input05.c
@@ -63,7 +63,7 @@ int main(int ac, char **av)
 		case -1:
 			tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
 		default:
-			if (no_events_queued(fd2))
+			if (no_events_queued(fd2, 0))
 				tst_resm(TPASS, "No data received in eventX");
 			else
 				tst_resm(TFAIL, "Data received in eventX");
diff --git a/testcases/kernel/input/input_helper.c b/testcases/kernel/input/input_helper.c
index 08fa81c..68b8b5f 100644
--- a/testcases/kernel/input/input_helper.c
+++ b/testcases/kernel/input/input_helper.c
@@ -229,7 +229,15 @@ void destroy_device(int fd)
 		unload_uinput();
 }
 
-int no_events_queued(int fd)
+/*
+ * the value of no_syn_evs_strict:
+ * 1: check that nothing is received in /dev/input/eventX
+ * 0: check that nothing or a EV_SYN/SYN_REPORT event is
+ *    received in /dev/input/eventX
+ * On an old kernel(before v3.7.0), a EV_SYN/SYN_REPORT event
+ * is always received even though we send empty events
+ */
+int no_events_queued(int fd, int no_syn_evs_strict)
 {
 	struct pollfd fds = {.fd = fd, .events = POLLIN};
 	int ret, res;
@@ -241,13 +249,21 @@ int no_events_queued(int fd)
 		res = read(fd, &ev, sizeof(ev));
 
 		if (res == sizeof(ev)) {
-			tst_resm(TINFO,
-			         "Unexpected ev type=%i code=%i value=%i",
-			         ev.type, ev.code, ev.value);
+			if (no_syn_evs_strict) {
+				tst_resm(TINFO, "Unexpected ev type=%i code=%i "
+					"value=%i", ev.type, ev.code, ev.value);
+				return 0;
+			}
+
+			if (!no_syn_evs_strict && ev.type != EV_SYN) {
+				tst_resm(TINFO, "Unexpected event type %i "
+					"expected %i", ev.type, EV_SYN);
+				return 0;
+			}
 		}
 	}
 
-	return ret == 0;
+	return 1;
 }
 
 static int check_device(void)
diff --git a/testcases/kernel/input/input_helper.h b/testcases/kernel/input/input_helper.h
index 9b85dc9..95c20f2 100644
--- a/testcases/kernel/input/input_helper.h
+++ b/testcases/kernel/input/input_helper.h
@@ -29,6 +29,6 @@ int open_uinput(void);
 void create_device(int fd);
 void setup_mouse_events(int fd);
 void destroy_device(int fd);
-int no_events_queued(int fd);
+int no_events_queued(int fd, int no_syn_evs_strict);
 
 #endif /* INPUT_HELPER_H */
-- 
1.8.3.1



