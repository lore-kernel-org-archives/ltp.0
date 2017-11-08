From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 8 Nov 2017 18:37:10 +0800
Subject: [LTP] [PATCH v2] kernel/input: fix failure on an old kernel
In-Reply-To: <20171107142043.GA32659@rei.lan>
References: <20171107142043.GA32659@rei.lan>
Message-ID: <1510137430-25555-1-git-send-email-yangx.jy@cn.fujitsu.com>
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
EV_SYN instead of a kernel bug, so we ignore stray sync events on older
kernels.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/input/input02.c      |  2 +-
 testcases/kernel/input/input04.c      |  5 +++-
 testcases/kernel/input/input05.c      |  6 +++-
 testcases/kernel/input/input_helper.c | 53 ++++++++++++++++++++++++++++++++---
 testcases/kernel/input/input_helper.h |  3 +-
 5 files changed, 61 insertions(+), 8 deletions(-)

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
index 4b16ca7..94d39c1 100644
--- a/testcases/kernel/input/input04.c
+++ b/testcases/kernel/input/input04.c
@@ -35,6 +35,7 @@ static void send_events(void);
 static void cleanup(void);
 
 static int fd, fd2;
+static int sync_events_ignored;
 
 char *TCID = "input04";
 
@@ -57,7 +58,7 @@ int main(int ac, char **av)
 		case -1:
 			tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
 		default:
-			if (no_events_queued(fd2))
+			if (no_events_queued(fd2, sync_events_ignored))
 				tst_resm(TPASS,
 					"No data received in /dev/inputX");
 			else
@@ -82,6 +83,8 @@ static void setup(void)
 	create_device(fd);
 
 	fd2 = open_device();
+
+	sync_events_ignored = check_single_sync_event(fd, fd2);
 }
 
 static void send_events(void)
diff --git a/testcases/kernel/input/input05.c b/testcases/kernel/input/input05.c
index 5ca01d8..af6d862 100644
--- a/testcases/kernel/input/input05.c
+++ b/testcases/kernel/input/input05.c
@@ -42,6 +42,8 @@ static void cleanup(void);
 static int fd;
 static int fd2;
 
+static int sync_events_ignored;
+
 char *TCID = "input05";
 
 int main(int ac, char **av)
@@ -63,7 +65,7 @@ int main(int ac, char **av)
 		case -1:
 			tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
 		default:
-			if (no_events_queued(fd2))
+			if (no_events_queued(fd2, sync_events_ignored))
 				tst_resm(TPASS, "No data received in eventX");
 			else
 				tst_resm(TFAIL, "Data received in eventX");
@@ -89,6 +91,8 @@ static void setup(void)
 	create_device(fd);
 
 	fd2 = open_device();
+
+	sync_events_ignored = check_single_sync_event(fd, fd2);
 }
 
 static void send_events(void)
diff --git a/testcases/kernel/input/input_helper.c b/testcases/kernel/input/input_helper.c
index 08fa81c..eb9aaec 100644
--- a/testcases/kernel/input/input_helper.c
+++ b/testcases/kernel/input/input_helper.c
@@ -229,7 +229,14 @@ void destroy_device(int fd)
 		unload_uinput();
 }
 
-int no_events_queued(int fd)
+/*
+ * the value of sync_events_ignored:
+ * 0: cannot ignore EV_SYN/SYN_REPORT events received in /dev/input/eventX
+ * 1: ignore EV_SYN/SYN_REPORT events received in /dev/input/eventX
+ * On an old kernel(before v3.7.0), EV_SYN/SYN_REPORT events are always
+ * received even though we send empty moves.
+ */
+int no_events_queued(int fd, int sync_events_ignored)
 {
 	struct pollfd fds = {.fd = fd, .events = POLLIN};
 	int ret, res;
@@ -241,9 +248,14 @@ int no_events_queued(int fd)
 		res = read(fd, &ev, sizeof(ev));
 
 		if (res == sizeof(ev)) {
-			tst_resm(TINFO,
-			         "Unexpected ev type=%i code=%i value=%i",
-			         ev.type, ev.code, ev.value);
+			if (sync_events_ignored && !ev.type &&
+			    !ev.code && !ev.value) {
+				ret = 0;
+			} else {
+				tst_resm(TINFO,
+					 "Unexpected ev type=%i code=%i value=%i",
+					 ev.type, ev.code, ev.value);
+			}
 		}
 	}
 
@@ -264,7 +276,40 @@ static int check_device(void)
 			return 1;
 	}
 
+
 	fclose(file);
 
 	return 0;
 }
+
+/*
+ * Use this function to check if the current kernel can get single
+ * EV_SYN/SYN_REPORT events.
+ */
+int check_single_sync_event(int fd1, int fd2)
+{
+	pid_t pid;
+	struct pollfd fds = {.fd = fd2, .events = POLLIN};
+	struct input_event ev;
+	int ret, ignored;
+
+	pid = tst_fork();
+
+	if (pid == -1)
+		tst_brkm(TBROK | TERRNO, NULL, "fork() failed");
+
+	if (!pid) {
+		send_event(fd1, EV_SYN, 0, 0);
+		exit(0);
+	}
+
+	ret = poll(&fds, 1, 30);
+	if (ret > 0 && SAFE_READ(NULL, 1, fd2, &ev, sizeof(ev)) == sizeof(ev)) {
+		if (!ev.type && !ev.code && !ev.value)
+			ignored = 1;
+	}
+
+	SAFE_WAITPID(NULL, pid, NULL, 0);
+
+	return ignored;
+}
diff --git a/testcases/kernel/input/input_helper.h b/testcases/kernel/input/input_helper.h
index 9b85dc9..1ef4d32 100644
--- a/testcases/kernel/input/input_helper.h
+++ b/testcases/kernel/input/input_helper.h
@@ -29,6 +29,7 @@ int open_uinput(void);
 void create_device(int fd);
 void setup_mouse_events(int fd);
 void destroy_device(int fd);
-int no_events_queued(int fd);
+int no_events_queued(int fd, int sync_events_ignored);
+int check_single_sync_event(int fd1, int fd2);
 
 #endif /* INPUT_HELPER_H */
-- 
1.8.3.1



