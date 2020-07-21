From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 21 Jul 2020 14:22:02 +0530
Subject: [LTP] [PATCH V2 1/3] syscalls: sigwaitinfo: Suppress all warnings
 around unused parameter
In-Reply-To: <cover.1595321086.git.viresh.kumar@linaro.org>
References: <cover.1595321086.git.viresh.kumar@linaro.org>
Message-ID: <cbc237432704066f3e394c3e40943ddfd90bcbc6.1595321086.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Suppress the warnings using LTP_ATTRIBUTE_UNUSED.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../kernel/syscalls/sigwaitinfo/sigwaitinfo01.c    | 26 +++++++++++++---------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c b/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
index 05e62999ca6c..86fce4427a6d 100644
--- a/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
+++ b/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
@@ -50,7 +50,7 @@ static void report_success_cond(const char *func, int line,
 #define REPORT_SUCCESS(exp_return, exp_errno)					\
 	REPORT_SUCCESS_COND(exp_return, exp_errno, 1, "");
 
-static void empty_handler(int sig)
+static void empty_handler(int sig LTP_ATTRIBUTE_UNUSED)
 {
 }
 
@@ -74,7 +74,7 @@ static int my_sigwait(const sigset_t * set, siginfo_t * info,
 
 #ifdef TEST_SIGWAITINFO
 static int my_sigwaitinfo(const sigset_t * set, siginfo_t * info,
-			  void *timeout)
+			  void *timeout LTP_ATTRIBUTE_UNUSED)
 {
 	return sigwaitinfo(set, info);
 }
@@ -106,7 +106,8 @@ static int my_rt_sigtimedwait_time64(const sigset_t * set, siginfo_t * info,
 #endif
 #endif
 
-void test_empty_set(swi_func sigwaitinfo, int signo, enum tst_ts_type type)
+void test_empty_set(swi_func sigwaitinfo, int signo,
+		    enum tst_ts_type type LTP_ATTRIBUTE_UNUSED)
 {
 	sigset_t sigs;
 	siginfo_t si;
@@ -150,7 +151,7 @@ void test_timeout(swi_func sigwaitinfo, int signo, enum tst_ts_type type)
  * by POSIX; but works for non-ignored signals under Linux
  */
 void test_unmasked_matching(swi_func sigwaitinfo, int signo,
-			    enum tst_ts_type type)
+			    enum tst_ts_type type LTP_ATTRIBUTE_UNUSED)
 {
 	sigset_t sigs;
 	siginfo_t si;
@@ -172,7 +173,7 @@ void test_unmasked_matching(swi_func sigwaitinfo, int signo,
 }
 
 void test_unmasked_matching_noinfo(swi_func sigwaitinfo, int signo,
-				   enum tst_ts_type type)
+				   enum tst_ts_type type LTP_ATTRIBUTE_UNUSED)
 {
 	sigset_t sigs;
 	pid_t child;
@@ -190,7 +191,7 @@ void test_unmasked_matching_noinfo(swi_func sigwaitinfo, int signo,
 }
 
 void test_masked_matching(swi_func sigwaitinfo, int signo,
-			  enum tst_ts_type type)
+			  enum tst_ts_type type LTP_ATTRIBUTE_UNUSED)
 {
 	sigset_t sigs, oldmask;
 	siginfo_t si;
@@ -229,7 +230,7 @@ void test_masked_matching(swi_func sigwaitinfo, int signo,
 }
 
 void test_masked_matching_rt(swi_func sigwaitinfo, int signo,
-			     enum tst_ts_type type)
+			     enum tst_ts_type type LTP_ATTRIBUTE_UNUSED)
 {
 	sigset_t sigs, oldmask;
 	siginfo_t si;
@@ -281,7 +282,7 @@ void test_masked_matching_rt(swi_func sigwaitinfo, int signo,
 }
 
 void test_masked_matching_noinfo(swi_func sigwaitinfo, int signo,
-				 enum tst_ts_type type)
+				 enum tst_ts_type type LTP_ATTRIBUTE_UNUSED)
 {
 	sigset_t sigs, oldmask;
 	pid_t child;
@@ -316,7 +317,8 @@ void test_masked_matching_noinfo(swi_func sigwaitinfo, int signo,
 	SAFE_WAIT(NULL);
 }
 
-void test_bad_address(swi_func sigwaitinfo, int signo, enum tst_ts_type type)
+void test_bad_address(swi_func sigwaitinfo, int signo,
+		      enum tst_ts_type type LTP_ATTRIBUTE_UNUSED)
 {
 	sigset_t sigs, oldmask;
 	pid_t child;
@@ -345,7 +347,8 @@ void test_bad_address(swi_func sigwaitinfo, int signo, enum tst_ts_type type)
 	SAFE_WAIT(NULL);
 }
 
-void test_bad_address2(swi_func sigwaitinfo, int signo, enum tst_ts_type type)
+void test_bad_address2(swi_func sigwaitinfo, int signo LTP_ATTRIBUTE_UNUSED,
+		       enum tst_ts_type type LTP_ATTRIBUTE_UNUSED)
 {
 	pid_t pid;
 	int status;
@@ -391,7 +394,8 @@ void test_bad_address2(swi_func sigwaitinfo, int signo, enum tst_ts_type type)
 	}
 }
 
-void test_bad_address3(swi_func sigwaitinfo, int signo, enum tst_ts_type type)
+void test_bad_address3(swi_func sigwaitinfo, int signo LTP_ATTRIBUTE_UNUSED,
+		       enum tst_ts_type type LTP_ATTRIBUTE_UNUSED)
 {
 	sigset_t sigs;
 	SUCCEED_OR_DIE(sigemptyset, "sigemptyset failed", &sigs);
-- 
2.14.1

