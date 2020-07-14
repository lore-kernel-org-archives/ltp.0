From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 Jul 2020 16:28:43 +0200
Subject: [LTP] [PATCH V3] syscalls/timer_settime01: Make sure the timer
 fires
In-Reply-To: <47e40724c2a7a9612aca0265e493e62c69d65996.1594204153.git.viresh.kumar@linaro.org>
References: <ede8d1c6a1ad1b23d8dca2297c740c301b329e37.1593743927.git.viresh.kumar@linaro.org>
 <47e40724c2a7a9612aca0265e493e62c69d65996.1594204153.git.viresh.kumar@linaro.org>
Message-ID: <20200714142843.GA14905@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, thanks.

Among other fixes I've moved the signal check from the signal handler to
the clear_signal() function, since the tst_res() function is not
signal-async-safe...

diff --git a/testcases/kernel/syscalls/timer_settime/timer_settime01.c b/testcases/kernel/syscalls/timer_settime/timer_settime01.c
index f9d1456da..76f283b81 100644
--- a/testcases/kernel/syscalls/timer_settime/timer_settime01.c
+++ b/testcases/kernel/syscalls/timer_settime/timer_settime01.c
@@ -10,7 +10,7 @@
 /*
  * This tests the timer_settime(2) syscall under various conditions:
  *
- * 1) General initialization: No old_value, no flags, 5-second-timer
+ * 1) General initialization: No old_value, no flags
  * 2) Setting a pointer to a itimerspec struct as old_set parameter
  * 3) Using a periodic timer
  * 4) Using absolute time
@@ -38,10 +38,10 @@ static struct testcase {
 	int			flag;
 	char			*description;
 } tcases[] = {
-	{NULL, 100000, 0, 0, "general initialization"},
-	{&old_set, 100000, 0, 0, "setting old_value"},
-	{&old_set, 100000, 100000, 0, "using periodic timer"},
-	{&old_set, 100000, 0, TIMER_ABSTIME, "using absolute time"},
+	{NULL, 50000, 0, 0, "general initialization"},
+	{&old_set, 50000, 0, 0, "setting old_value"},
+	{&old_set, 50000, 50000, 0, "using periodic timer"},
+	{&old_set, 50000, 0, TIMER_ABSTIME, "using absolute time"},
 };
 
 static struct test_variants {
@@ -71,15 +71,17 @@ static void clear_signal(void)
 	 */
 	while (!caught_signal);
 
+	if (caught_signal != SIGALRM) {
+		tst_res(TFAIL, "Received incorrect signal: %s",
+			tst_strsig(caught_signal));
+	}
+
 	caught_signal = 0;
 }
 
 static void sighandler(int sig)
 {
-	if (sig != SIGALRM)
-		tst_res(TFAIL, "Received incorrect signal: %d", sig);
-
-	caught_signal = 1;
+	caught_signal = sig;
 }
 
 static void setup(void)

-- 
Cyril Hrubis
chrubis@suse.cz
