From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon,  6 Jul 2020 08:33:03 +0530
Subject: [LTP] [PATCH] tst_test: Fix spelling mistake
Message-ID: <9f82f6280630838380c2db503343848d81c94bf5.1594004560.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fix few spelling mistakes.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 lib/tst_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index e93c88ba564a..175dea7c4ae9 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -363,7 +363,7 @@ static void check_child_status(pid_t pid, int status)
 	}
 
 	if (!(WIFEXITED(status)))
-		tst_brk(TBROK, "Child (%i) exited abnormaly", pid);
+		tst_brk(TBROK, "Child (%i) exited abnormally", pid);
 
 	ret = WEXITSTATUS(status);
 	switch (ret) {
@@ -673,7 +673,7 @@ static void print_failure_hints(void)
 				hint_printed = 1;
 				printf("\n");
 				print_colored("HINT: ");
-				printf("You _MAY_ be vunerable to CVE(s), see:\n\n");
+				printf("You _MAY_ be vulnerable to CVE(s), see:\n\n");
 			}
 
 			printf(CVE_DB_URL "%s\n", tags[i].value);
@@ -790,7 +790,7 @@ static void assert_test_fn(void)
 		cnt++;
 
 	if (!cnt)
-		tst_brk(TBROK, "No test function speficied");
+		tst_brk(TBROK, "No test function specified");
 
 	if (cnt != 1)
 		tst_brk(TBROK, "You can define only one test function");
-- 
2.25.0.rc1.19.g042ed3e048af

