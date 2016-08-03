From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 3 Aug 2016 15:53:55 +0200
Subject: [LTP] [PATCH] tst_test: Allow to set timeout from test setup()
Message-ID: <20160803135355.GA30335@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

There are testcases that take runtime as a parameter. These needs to be
able to set the timeout dynamically in the test setup().

This commit places the timeout value into the struct results stored in
shared memory so that it can be changed from the test setup() that runs
in the child process.

We also reset the alarm() right after we finish setup() so that the new
value is actually used.

+ Added a few lines about test timeouts into the documentation.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 doc/test-writing-guidelines.txt | 11 ++++++++++
 include/tst_test.h              |  2 ++
 lib/tst_test.c                  | 45 +++++++++++++++++++++++++----------------
 3 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index db12d18..4990903 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -319,6 +319,10 @@ in range of [0, '.tcnt' - 1].
 
 IMPORTANT: Only one of '.test' and '.test_all' can be set at a time.
 
+Each test has a default timeout set to 300s. The default timeout can be
+overriden by setting '.timeout' in the test structure or by calling
+'tst_set_timeout()' in the test 'setup()'.
+
 A word about the cleanup() callback
 +++++++++++++++++++++++++++++++++++
 
@@ -438,6 +442,13 @@ Return the given errno number's corresponding string. Using this function to
 translate 'errno' values to strings is preferred. You should not use the
 'strerror()' function in the testcases.
 
+[source,c]
+-------------------------------------------------------------------------------
+void tst_set_timeout(unsigned int timeout);
+-------------------------------------------------------------------------------
+
+Allows for setting timeout per test iteration dymanically in the test setup(),
+the timeout is specified in seconds.
 
 2.2.3 Test temporary directory
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
diff --git a/include/tst_test.h b/include/tst_test.h
index c89e51f..c839178 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -133,6 +133,8 @@ const char *tst_strsig(int sig);
 
 static struct tst_test test;
 
+void tst_set_timeout(unsigned int timeout);
+
 int main(int argc, char *argv[])
 {
 	tst_run_tcases(argc, argv, &test);
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 26fff97..72d4696 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -46,6 +46,7 @@ struct results {
 	int skipped;
 	int failed;
 	int warnings;
+	unsigned int timeout;
 };
 
 static struct results *results;
@@ -635,6 +636,8 @@ static void testrun(void)
 
 	do_test_setup();
 
+	kill(getppid(), SIGUSR1);
+
 	if (duration > 0)
 		stop_time = get_time_ms() + (unsigned long long)(duration * 1000);
 
@@ -662,7 +665,6 @@ static void testrun(void)
 }
 
 static pid_t test_pid;
-static unsigned int timeout = 300;
 
 static void alarm_handler(int sig LTP_ATTRIBUTE_UNUSED)
 {
@@ -671,39 +673,48 @@ static void alarm_handler(int sig LTP_ATTRIBUTE_UNUSED)
 
 static void heartbeat_handler(int sig LTP_ATTRIBUTE_UNUSED)
 {
-	alarm(timeout);
+	alarm(results->timeout);
 }
 
-void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
+void tst_set_timeout(unsigned int timeout)
 {
-	int status;
-	char *mul;
-
-	lib_pid = getpid();
-	tst_test = self;
-	TCID = tst_test->tid;
-
-	do_setup(argc, argv);
+	char *mul = getenv("LTP_TIMEOUT_MUL");
 
-	if (tst_test->timeout)
-		timeout = tst_test->timeout;
+	results->timeout = timeout;
 
-	mul = getenv("LTP_TIMEOUT_MUL");
 	if (mul) {
 		float m = atof(mul);
 
 		if (m < 1)
 			tst_brk(TBROK, "Invalid timeout multiplier '%s'", mul);
 
-		timeout = timeout * m + 0.5;
+		results->timeout = results->timeout * m + 0.5;
 	}
 
-	tst_res(TINFO, "Timeout per run is %us", timeout);
+	tst_res(TINFO, "Timeout per run is %uh %02um %02us",
+		results->timeout/3600, (results->timeout%3600)/60,
+		results->timeout % 60);
+}
+
+void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
+{
+	int status;
+
+	lib_pid = getpid();
+	tst_test = self;
+	TCID = tst_test->tid;
+
+	do_setup(argc, argv);
+
+	if (tst_test->timeout)
+		tst_set_timeout(tst_test->timeout);
+	else
+		tst_set_timeout(300);
 
 	SAFE_SIGNAL(SIGALRM, alarm_handler);
 	SAFE_SIGNAL(SIGUSR1, heartbeat_handler);
 
-	alarm(timeout);
+	alarm(results->timeout);
 
 	test_pid = fork();
 	if (test_pid < 0)
-- 
2.7.3


-- 
Cyril Hrubis
chrubis@suse.cz
