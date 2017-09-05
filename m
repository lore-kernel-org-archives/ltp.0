From: Sandeep Patil <sspatil@google.com>
Date: Tue,  5 Sep 2017 15:55:47 -0700
Subject: [LTP] [PATCH v4] input/input06: Fix auto-repeat key test
Message-ID: <20170905225547.119211-1-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The test currently fails for various reasons.
- The wait in the parent process is not long enough for kernel
  to send the auto-repeated keys.
- The test also fails when kernel sends auto-repeat configuration
  events as it doesn't recognize them.

These problems are fixed by making sure we wait long enough (500ms) for
kernel to send auto-repeated key events. The test now also recognizes
the auto-repeat configuration events (EV_REP) reported through the
device to ensure it doesn't incorrectly fail.

Tested for both auto-repeat configuration events as well as for the key
press-repeat-release events.

Signed-off-by: Sandeep Patil <sspatil@google.com>
---
v3->v4
======
- Fixed the next_event() implementation for needless use of a local variable.
- Fixed some uncaught code-style issues (upstream checkpatch.pl --strict didn't
  catch the non-existence of a parameter in next_event() definition)
- Removed unnecessary checks for rep_keys_done, rep_config_done

v2->v3
======
- Change the commit msg to reflect exactly what is being done.
- Run checkpatch.pl on the patch to ensure there are no errors.
- Make sure we test auto-repeat keys by increasing the sleep time in the parent process.
- Make sure we test both the auto-repeat configuration AND KEY_X press-repeat-release.
- Remove unnecessary check_size() function.
- Add checks for EV_SYN events that were broken in PATCH v2. The value in an EV_SYN event is
  undefined, and  we were checking the value.

 testcases/kernel/input/input06.c | 137 ++++++++++++++++++++++++++++++---------
 1 file changed, 107 insertions(+), 30 deletions(-)

diff --git a/testcases/kernel/input/input06.c b/testcases/kernel/input/input06.c
index c4fc1ef57..a15d11225 100644
--- a/testcases/kernel/input/input06.c
+++ b/testcases/kernel/input/input06.c
@@ -37,6 +37,9 @@ static void cleanup(void);
 
 static int fd;
 static int fd2;
+struct input_event events[64];
+static int num_events;
+static int ev_iter;
 
 char *TCID = "input06";
 
@@ -95,8 +98,13 @@ static void send_events(void)
 	send_event(fd, EV_KEY, KEY_X, 1);
 	send_event(fd, EV_SYN, 0, 0);
 
-	/* sleep to keep the key pressed for some time (auto-repeat) */
-	usleep(1000);
+	/*
+	 * Sleep long enough to keep the key pressed for some time
+	 * (auto-repeat).  Default kernel delay to start auto-repeat is 250ms
+	 * and the period is 33ms. So, we wait for a generous 500ms to make
+	 * sure we get the auto-repeated keys
+	 */
+	usleep(500000);
 
 	send_event(fd, EV_KEY, KEY_X, 0);
 	send_event(fd, EV_SYN, 0, 0);
@@ -107,13 +115,14 @@ static int check_event(struct input_event *iev, int event, int code, int value)
 	return iev->type == event && iev->code == code && iev->value == value;
 }
 
-static int check_bound(unsigned int i, unsigned int rd)
+static int check_event_code(struct input_event *iev, int event, int code)
 {
-	return i <= rd / sizeof(struct input_event);
+	return iev->type == event && iev->code == code;
 }
 
-static void check_size(int rd)
+static void read_events(void)
 {
+	int rd = read(fd2, events, sizeof(events));
 	if (rd < 0)
 		tst_brkm(TBROK | TERRNO, cleanup, "read() failed");
 
@@ -121,45 +130,113 @@ static void check_size(int rd)
 		tst_brkm(TBROK, cleanup, "read size %i not multiple of %zu",
 		         rd, sizeof(struct input_event));
 	}
+
+	ev_iter = 0;
+	num_events = rd / sizeof(struct input_event);
 }
 
-static int check_events(void)
+static int have_events(void)
+{
+	return num_events && ev_iter < num_events;
+}
+
+static struct input_event *next_event(void)
+{
+	if (!have_events())
+		read_events();
+
+	return &events[ev_iter++];
+}
+
+static int check_sync_event(void)
+{
+	return check_event_code(next_event(), EV_SYN, SYN_REPORT);
+}
+
+static int parse_autorepeat_config(struct input_event *iev)
+{
+	if (!check_event_code(iev, EV_REP, REP_DELAY)) {
+		tst_resm(TFAIL,
+			 "Didn't get EV_REP configuration with code REP_DELAY");
+		return 0;
+	}
+
+	if (!check_event_code(next_event(), EV_REP, REP_PERIOD)) {
+		tst_resm(TFAIL,
+			 "Didn't get EV_REP configuration with code REP_PERIOD");
+		return 0;
+	}
+
+	return 1;
+}
+
+static int parse_key(struct input_event *iev)
 {
-	struct input_event iev[64];
-	unsigned int i;
-	int nb;
-	int rd;
+	int autorep_count = 0;
+
+	if (!check_event(iev, EV_KEY, KEY_X, 1) || !check_sync_event()) {
+		tst_resm(TFAIL, "Didn't get expected key press for KEY_X");
+		return 0;
+	}
 
-	i = 0;
-	nb = 0;
+	iev = next_event();
+	while (check_event(iev, EV_KEY, KEY_X, 2) && check_sync_event()) {
+		autorep_count++;
+		iev = next_event();
+	}
 
-	rd = read(fd2, iev, sizeof(iev));
+	/* make sure we have atleast one auto-repeated key event */
+	if (!autorep_count) {
+		tst_resm(TFAIL,
+			 "Didn't get autorepeat events for the key - KEY_X");
+		return 0;
+	}
 
-	check_size(rd);
+	if (!check_event(iev, EV_KEY, KEY_X, 0) || !check_sync_event()) {
+		tst_resm(TFAIL,
+			 "Didn't get expected key release for KEY_X");
+		return 0;
+	}
 
-	if (rd > 0 && check_event(&iev[i], EV_KEY, KEY_X, 1))
-		i++;
+	tst_resm(TINFO,
+		 "Received %d repititions for KEY_X", autorep_count);
 
-	while (check_bound(i, rd) && !check_event(&iev[i], EV_KEY, KEY_X, 0)) {
+	return 1;
+}
 
-		if (iev[i].type != EV_SYN
-			&& !check_event(&iev[i], EV_KEY, KEY_X, 2)) {
-			tst_resm(TINFO,
-				"Didn't receive EV_KEY KEY_X with value 2");
+static int check_events(void)
+{
+	struct input_event *iev;
+	int ret;
+	int rep_config_done = 0;
+	int rep_keys_done = 0;
+
+	read_events();
+
+	while (have_events()) {
+		iev = next_event();
+		switch (iev->type) {
+		case EV_REP:
+			ret = parse_autorepeat_config(iev);
+			rep_config_done = 1;
+			break;
+		case EV_KEY:
+			ret = parse_key(iev);
+			rep_keys_done = 1;
+			break;
+		default:
+			tst_resm(TFAIL,
+				 "Unexpected event type '0x%04x' received",
+				iev->type);
+			ret = 0;
 			break;
 		}
-		i++;
-		nb++;
 
-		if (i == rd / sizeof(struct input_event)) {
-			i = 0;
-			rd = read(fd2, iev, sizeof(iev));
-			check_size(rd);
-		}
+		if (!ret || (rep_config_done && rep_keys_done))
+			break;
 	}
 
-	return (nb > 0 && check_bound(i, rd)
-		&& check_event(&iev[i], EV_KEY, KEY_X, 0));
+	return ret;
 }
 
 static void cleanup(void)
-- 
2.14.1.581.gf28d330327-goog

