From: Michael Moese <mmoese@suse.de>
Date: Thu,  8 Mar 2018 11:57:04 +0100
Subject: [LTP] [PATCH] Add tst_flush() library function
Message-ID: <20180308105704.7823-1-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add a library function to flush stderr and stdout streams:
void tst_flush(void)

This function flushes stderr and stdout streams. In case of an
error, the test is aborted with TBROK and an error message is
printed.

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 doc/test-writing-guidelines.txt |  8 ++++++++
 include/tst_test.h              |  3 +++
 lib/tst_test.c                  | 15 +++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 739b295b8..4c60cd66b 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -465,6 +465,14 @@ Allows for setting timeout per test iteration dymanically in the test setup(),
 the timeout is specified in seconds. There are a few testcases whose runtime
 can vary arbitrarily, these can disable timeouts by setting it to -1.
 
+[source,c]
+------------------------------------------------------------------------------
+void tst_flush(void);
+-------------------------------------------------------------------------------
+
+Flush stderr and stdout streams, handling errors appropriately.
+You should not use fflush() for stderr or stdout.
+
 2.2.3 Test temporary directory
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/include/tst_test.h b/include/tst_test.h
index af97b8983..54ff306d9 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -70,6 +70,9 @@ void tst_brk_(const char *file, const int lineno, int ttype,
 #define tst_brk(ttype, arg_fmt, ...) \
 	tst_brk_(__FILE__, __LINE__, (ttype), (arg_fmt), ##__VA_ARGS__)
 
+/* flush stderr and stdout */
+void tst_flush(void);
+
 pid_t safe_fork(const char *filename, unsigned int lineno);
 #define SAFE_FORK() \
 	safe_fork(__FILE__, __LINE__)
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 2cf35ed66..9b4f43828 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1085,3 +1085,18 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 
 	do_exit(ret);
 }
+
+
+void tst_flush(void)
+{
+	int rval;
+
+	rval = fflush(stderr);
+	if (rval != 0)
+		tst_brk(TBROK | TERRNO, "fflush(stderr) failed");
+
+	rval = fflush(stderr);
+	if (rval != 0)
+		tst_brk(TBROK | TERRNO, "fflush(stdout) failed");
+
+}
-- 
2.13.6

