From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 18 May 2017 10:57:07 +0200
Subject: [LTP] [RFC] [PATCH] tst_test: Be more verbose on timeout
Message-ID: <20170518085707.30523-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

I've recently stumbled upon a test that caused deadlock in the kernel
and the test processes could not be killed because of that. This was
while testing fanotify07 testcase on unpatched kernel.

In that case the test library just slept in the waitpid() call forever without
producing any output. That was since the alarm handler that sends the SIGKILL
to the test processes has fired but the processes stayed alive due to the
kernel bug.

This patch makes this situation more verbose we:

* Print a message that we are about to kill the test process once it has
  timeouted so that the user knows that something unexpected is
  happening

* We retry 10 times with 5 second delay between tries

* And finally if we are out of retries and if the test processes are
  stil alive we congratulate user on hitting a kernel bug and exit
  uncleanly with TFAIL

Example test output:

$ ./fanotify07
tst_test.c:862: INFO: Timeout per run is 0h 05m 00s
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Cannot kill test processes!
Congratulation, likely test hit a kernel bug.
Exitting uncleanly...
$ echo $?
1

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_test.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index fa1417f..14a47d6 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -805,24 +805,39 @@ static void testrun(void)
 
 static pid_t test_pid;
 
+
+static volatile sig_atomic_t sigkill_retries;
+
+#define WRITE_MSG(msg) do { \
+	if (write(2, msg, sizeof(msg) - 1)) { \
+		/* https://gcc.gnu.org/bugzilla/show_bug.cgi?id=66425 */ \
+	} \
+} while (0)
+
 static void alarm_handler(int sig LTP_ATTRIBUTE_UNUSED)
 {
+	WRITE_MSG("Test timeouted, sending SIGKILL!\n");
 	kill(-test_pid, SIGKILL);
+	alarm(5);
+
+	if (++sigkill_retries > 10) {
+		WRITE_MSG("Cannot kill test processes!\n");
+		WRITE_MSG("Congratulation, likely test hit a kernel bug.\n");
+		WRITE_MSG("Exitting uncleanly...\n");
+		_exit(TFAIL);
+	}
 }
 
 static void heartbeat_handler(int sig LTP_ATTRIBUTE_UNUSED)
 {
 	alarm(results->timeout);
+	sigkill_retries = 0;
 }
 
-#define SIGINT_MSG "Sending SIGKILL to test process...\n"
-
 static void sigint_handler(int sig LTP_ATTRIBUTE_UNUSED)
 {
 	if (test_pid > 0) {
-		if (write(2, SIGINT_MSG, sizeof(SIGINT_MSG) - 1)) {
-			/* https://gcc.gnu.org/bugzilla/show_bug.cgi?id=66425 */
-		}
+		WRITE_MSG("Sending SIGKILL to test process...\n");
 		kill(-test_pid, SIGKILL);
 	}
 }
-- 
2.10.2

