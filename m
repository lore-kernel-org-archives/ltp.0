From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 13 Nov 2017 14:45:04 +0800
Subject: [LTP] [PATCH v3] kernel/input: fix failure on an old kernel
In-Reply-To: <20171109134523.GA23734@rei>
References: <20171109134523.GA23734@rei>
Message-ID: <1510555504-6103-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

1) On some old kernels(e.g. v2.6.32), we always triggered the following
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
   EV_SYN instead of a kernel bug, so we ignore stray sync events on older
   kernels.

2) We move the check_event_code and check_sync_event() helpers to the
   library so that we can use them.

3) Fix compiler warning, as below:
   ------------------------------------------------------------------------
   input06.c:213: warning: ‘ret’ may be used uninitialized in this function
   ------------------------------------------------------------------------

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/input/input02.c      |  2 +-
 testcases/kernel/input/input04.c      |  2 +-
 testcases/kernel/input/input05.c      |  2 +-
 testcases/kernel/input/input06.c      | 18 ++++--------------
 testcases/kernel/input/input_helper.c | 34 +++++++++++++++++++++++++++++-----
 testcases/kernel/input/input_helper.h |  4 +++-
 6 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/testcases/kernel/input/input02.c b/testcases/kernel/input/input02.c
index df3b257..6964ed7 100644
--- a/testcases/kernel/input/input02.c
+++ b/testcases/kernel/input/input02.c
@@ -61,7 +61,7 @@ int main(int ac, char **av)
 		case -1:
 			tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
 		default:
-			if (no_events_queued(fd2))
+			if (no_events_queued(fd2, 0))
 				tst_resm(TPASS, "No data received in eventX");
 			else
 				tst_resm(TFAIL, "Data received in eventX");
diff --git a/testcases/kernel/input/input04.c b/testcases/kernel/input/input04.c
index 4b16ca7..e57b76b 100644
--- a/testcases/kernel/input/input04.c
+++ b/testcases/kernel/input/input04.c
@@ -57,7 +57,7 @@ int main(int ac, char **av)
 		case -1:
 			tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
 		default:
-			if (no_events_queued(fd2))
+			if (no_events_queued(fd2, 1))
 				tst_resm(TPASS,
 					"No data received in /dev/inputX");
 			else
diff --git a/testcases/kernel/input/input05.c b/testcases/kernel/input/input05.c
index 5ca01d8..46b4fe8 100644
--- a/testcases/kernel/input/input05.c
+++ b/testcases/kernel/input/input05.c
@@ -63,7 +63,7 @@ int main(int ac, char **av)
 		case -1:
 			tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
 		default:
-			if (no_events_queued(fd2))
+			if (no_events_queued(fd2, 1))
 				tst_resm(TPASS, "No data received in eventX");
 			else
 				tst_resm(TFAIL, "Data received in eventX");
diff --git a/testcases/kernel/input/input06.c b/testcases/kernel/input/input06.c
index 4c5f1a8..14141b7 100644
--- a/testcases/kernel/input/input06.c
+++ b/testcases/kernel/input/input06.c
@@ -115,11 +115,6 @@ static int check_event(struct input_event *iev, int event, int code, int value)
 	return iev->type == event && iev->code == code && iev->value == value;
 }
 
-static int check_event_code(struct input_event *iev, int event, int code)
-{
-	return iev->type == event && iev->code == code;
-}
-
 static void read_events(void)
 {
 	int rd = read(fd2, events, sizeof(events));
@@ -151,11 +146,6 @@ static struct input_event *next_event(void)
 	return &events[ev_iter++];
 }
 
-static int check_sync_event(void)
-{
-	return check_event_code(next_event(), EV_SYN, SYN_REPORT);
-}
-
 static int parse_autorepeat_config(struct input_event *iev)
 {
 	if (!check_event_code(iev, EV_REP, REP_DELAY)) {
@@ -177,13 +167,13 @@ static int parse_key(struct input_event *iev)
 {
 	int autorep_count = 0;
 
-	if (!check_event(iev, EV_KEY, KEY_X, 1) || !check_sync_event()) {
+	if (!check_event(iev, EV_KEY, KEY_X, 1) || !check_sync_event(next_event())) {
 		tst_resm(TFAIL, "Didn't get expected key press for KEY_X");
 		return 0;
 	}
 
 	iev = next_event();
-	while (check_event(iev, EV_KEY, KEY_X, 2) && check_sync_event()) {
+	while (check_event(iev, EV_KEY, KEY_X, 2) && check_sync_event(next_event())) {
 		autorep_count++;
 		iev = next_event();
 	}
@@ -195,7 +185,7 @@ static int parse_key(struct input_event *iev)
 		return 0;
 	}
 
-	if (!check_event(iev, EV_KEY, KEY_X, 0) || !check_sync_event()) {
+	if (!check_event(iev, EV_KEY, KEY_X, 0) || !check_sync_event(next_event())) {
 		tst_resm(TFAIL,
 			 "Didn't get expected key release for KEY_X");
 		return 0;
@@ -210,7 +200,7 @@ static int parse_key(struct input_event *iev)
 static int check_events(void)
 {
 	struct input_event *iev;
-	int ret;
+	int ret = 0;
 	int rep_config_done = 0;
 	int rep_keys_done = 0;
 
diff --git a/testcases/kernel/input/input_helper.c b/testcases/kernel/input/input_helper.c
index 08fa81c..13a6cd8 100644
--- a/testcases/kernel/input/input_helper.c
+++ b/testcases/kernel/input/input_helper.c
@@ -229,21 +229,45 @@ void destroy_device(int fd)
 		unload_uinput();
 }
 
-int no_events_queued(int fd)
+int check_event_code(struct input_event *iev, int event, int code)
+{
+	return iev->type == event && iev->code == code;
+}
+
+int check_sync_event(struct input_event *iev)
+{
+	return check_event_code(iev, EV_SYN, SYN_REPORT);
+}
+
+/*
+ * the value of stray_sync_event:
+ * 0: EV_SYN/SYN_REPORT events should not be received in /dev/input/eventX
+ * 1: EV_SYN/SYN_REPORT events may be received in /dev/input/eventX
+ * On an old kernel(before v3.7.0), EV_SYN/SYN_REPORT events are always
+ * received even though we send empty moves.
+ */
+int no_events_queued(int fd, int stray_sync_event)
 {
 	struct pollfd fds = {.fd = fd, .events = POLLIN};
-	int ret, res;
+	int ret, res, sync_event_ignored;
 	struct input_event ev;
 
+	if (tst_kvercmp(3, 7, 0) < 0 && stray_sync_event)
+		sync_event_ignored = 1;
+
 	ret = poll(&fds, 1, 30);
 
 	if (ret > 0) {
 		res = read(fd, &ev, sizeof(ev));
 
 		if (res == sizeof(ev)) {
-			tst_resm(TINFO,
-			         "Unexpected ev type=%i code=%i value=%i",
-			         ev.type, ev.code, ev.value);
+			if (sync_event_ignored && check_sync_event(&ev)) {
+				ret = 0;
+			} else {
+				tst_resm(TINFO,
+					 "Unexpected ev type=%i code=%i value=%i",
+					 ev.type, ev.code, ev.value);
+			}
 		}
 	}
 
diff --git a/testcases/kernel/input/input_helper.h b/testcases/kernel/input/input_helper.h
index 9b85dc9..7f61be1 100644
--- a/testcases/kernel/input/input_helper.h
+++ b/testcases/kernel/input/input_helper.h
@@ -29,6 +29,8 @@ int open_uinput(void);
 void create_device(int fd);
 void setup_mouse_events(int fd);
 void destroy_device(int fd);
-int no_events_queued(int fd);
+int check_event_code(struct input_event *iev, int event, int code);
+int check_sync_event(struct input_event *iev);
+int no_events_queued(int fd, int stray_sync_event);
 
 #endif /* INPUT_HELPER_H */
-- 
1.8.3.1



