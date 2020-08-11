From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 11 Aug 2020 15:05:01 +0200
Subject: [LTP] [PATCH 3/4] Simplify syscalls/bind06 using new taint check API
In-Reply-To: <20200811130502.12010-1-mdoucha@suse.cz>
References: <20200811130502.12010-1-mdoucha@suse.cz>
Message-ID: <20200811130502.12010-3-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The bug causes kernel crash when the process that performed the race exits.
Now that taint checks are integrated in the LTP library, forking a child is no
longer necessary.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/bind/bind06.c | 46 ++++++++-----------------
 1 file changed, 14 insertions(+), 32 deletions(-)

diff --git a/testcases/kernel/syscalls/bind/bind06.c b/testcases/kernel/syscalls/bind/bind06.c
index 47351ddbd..e971a8940 100644
--- a/testcases/kernel/syscalls/bind/bind06.c
+++ b/testcases/kernel/syscalls/bind/bind06.c
@@ -23,7 +23,6 @@
 #include <sched.h>
 #include "tst_test.h"
 #include "tst_fuzzy_sync.h"
-#include "tst_taint.h"
 
 static volatile int fd = -1;
 static struct sockaddr_ll addr1, addr2;
@@ -35,8 +34,6 @@ static void setup(void)
 	int real_gid = getgid();
 	struct ifreq ifr;
 
-	tst_taint_init(TST_TAINT_W | TST_TAINT_D);
-
 	SAFE_UNSHARE(CLONE_NEWUSER);
 	SAFE_UNSHARE(CLONE_NEWNET);
 	SAFE_FILE_PRINTF("/proc/self/setgroups", "deny");
@@ -51,9 +48,18 @@ static void setup(void)
 	addr1.sll_family = AF_PACKET;
 	addr1.sll_ifindex = ifr.ifr_ifindex;
 	addr2.sll_family = AF_PACKET;
+
+	fzsync_pair.exec_loops = 10000;
+	tst_fzsync_pair_init(&fzsync_pair);
 }
 
-static void do_bind(void) {
+static void cleanup(void)
+{
+	tst_fzsync_pair_cleanup(&fzsync_pair);
+}
+
+static void do_bind(void)
+{
 	bind(fd, (struct sockaddr *)&addr1, sizeof(addr1));
 	bind(fd, (struct sockaddr *)&addr2, sizeof(addr2));
 }
@@ -69,12 +75,10 @@ static void *thread_run(void *arg)
 	return arg;
 }
 
-static void child_run(void)
+static void run(void)
 {
 	struct ifreq ifr;
 
-	fzsync_pair.exec_loops = 10000;
-	tst_fzsync_pair_init(&fzsync_pair);
 	tst_fzsync_pair_reset(&fzsync_pair, thread_run);
 	strcpy(ifr.ifr_name, "lo");
 
@@ -87,39 +91,17 @@ static void child_run(void)
 		ioctl(fd, SIOCSIFFLAGS, &ifr);
 		tst_fzsync_end_race_a(&fzsync_pair);
 		SAFE_CLOSE(fd);
-
-	}
-
-	tst_fzsync_pair_cleanup(&fzsync_pair);
-}
-
-static void run(void)
-{
-	pid_t child;
-
-	/* The kernel crash is triggered on process exit. */
-	child = SAFE_FORK();
-
-	if (!child) {
-		child_run();
-		exit(0);
-	}
-
-	SAFE_WAITPID(child, NULL, 0);
-
-	if (tst_taint_check()) {
-		tst_res(TFAIL, "Kernel is vulnerable");
-		return;
 	}
 
-	tst_res(TPASS, "Nothing bad happened, probably");
+	tst_res(TPASS, "Nothing bad happened (yet)");
 }
 
 static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
+	.cleanup = cleanup,
 	.timeout = 600,
-	.forks_child = 1,
+	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_USER_NS=y",
 		"CONFIG_NET_NS=y",
-- 
2.27.0

