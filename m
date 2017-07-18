From: Li Wang <liwang@redhat.com>
Date: Tue, 18 Jul 2017 16:23:00 +0800
Subject: [LTP] [PATCH v3 03/15] mem/oom: disable timeouts for testcase in
	demand
In-Reply-To: <20170718082312.3946-1-liwang@redhat.com>
References: <20170718082312.3946-1-liwang@redhat.com>
Message-ID: <20170718082312.3946-4-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

OOM spend time is depending on amount of RAM+Swap, it's hard to get
a standard to measure how long it takes, so that we cann't setting
tst_test->timeout easily.

In this patch, we add functionality to disable timeouts for these,
i.e. set the .timeout to -1 and change the test library so that the
alarm() is not set in such case.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 lib/tst_test.c                   | 4 ++--
 testcases/kernel/mem/oom/oom01.c | 1 +
 testcases/kernel/mem/oom/oom02.c | 1 +
 testcases/kernel/mem/oom/oom03.c | 1 +
 testcases/kernel/mem/oom/oom04.c | 1 +
 testcases/kernel/mem/oom/oom05.c | 1 +
 6 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 16ea64f..6c67afe 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -917,9 +917,9 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 	SAFE_SIGNAL(SIGALRM, alarm_handler);
 	SAFE_SIGNAL(SIGUSR1, heartbeat_handler);
 
-	if (tst_test->timeout)
+	if (tst_test->timeout > 0)
 		tst_set_timeout(tst_test->timeout);
-	else
+	else if (tst_test->timeout == 0)
 		tst_set_timeout(300);
 
 	SAFE_SIGNAL(SIGINT, sigint_handler);
diff --git a/testcases/kernel/mem/oom/oom01.c b/testcases/kernel/mem/oom/oom01.c
index 955642c..3d05860 100644
--- a/testcases/kernel/mem/oom/oom01.c
+++ b/testcases/kernel/mem/oom/oom01.c
@@ -61,6 +61,7 @@ static void cleanup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
+	.timeout = -1,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_oom,
diff --git a/testcases/kernel/mem/oom/oom02.c b/testcases/kernel/mem/oom/oom02.c
index dab8874..3434a34 100644
--- a/testcases/kernel/mem/oom/oom02.c
+++ b/testcases/kernel/mem/oom/oom02.c
@@ -65,6 +65,7 @@ static void cleanup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
+	.timeout = -1,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_oom,
diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
index b384e2b..f883bc0 100644
--- a/testcases/kernel/mem/oom/oom03.c
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -78,6 +78,7 @@ static void cleanup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
+	.timeout = -1,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_oom,
diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index 8043097..e4e70e2 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -87,6 +87,7 @@ static void cleanup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
+	.timeout = -1,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_oom,
diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
index 600e8d9..d2e631a 100644
--- a/testcases/kernel/mem/oom/oom05.c
+++ b/testcases/kernel/mem/oom/oom05.c
@@ -115,6 +115,7 @@ void cleanup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
+	.timeout = -1,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_oom,
-- 
2.9.3

