From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 29 Nov 2018 17:29:30 +0100
Subject: [LTP] [PATCH] syscalls/migrate_pages03: skip migratition of shared
	pages
Message-ID: <12d3ccf40055c225b97a4a94ed1c6a46d4fd2048.1543508512.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes: #431

Migrating shared pages (as root) includes also executable pages
(glibc, etc.) Kernel might need to invalidate icache, which can
be an expensive operation on some architectures (arm64).

This test is repeating migration thousands of times, and because
migration (and icache flush) runs for each page, it all stacks
up and test is hitting a timeout.

It's enough for this reproducer to migrate pages it allocates
and merges (via KSM), so do the migration as unprivileged user
and we can avoid the overhead of migrating everything. Such
scenario is already covered by migrate_pages02.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/migrate_pages/migrate_pages03.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
index ecfc55288691..7317b11283d8 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
@@ -33,6 +33,7 @@
 #include <errno.h>
 #include <unistd.h>
 #include <stdlib.h>
+#include <pwd.h>
 
 #include "tst_test.h"
 #include "lapi/syscalls.h"
@@ -52,6 +53,8 @@ static void *test_pages[N_PAGES];
 static int num_nodes, max_node;
 static int *nodes;
 static unsigned long *new_nodes[2];
+static const char nobody_uid[] = "nobody";
+static struct passwd *ltpuser;
 
 static void setup(void)
 {
@@ -69,6 +72,8 @@ static void setup(void)
 			TEST_NODES);
 	}
 
+	ltpuser = SAFE_GETPWNAM(nobody_uid);
+
 	max_node = LTP_ALIGN(get_max_node(), sizeof(unsigned long) * 8);
 	nodemask_size = max_node / 8;
 	new_nodes[0] = SAFE_MALLOC(nodemask_size);
@@ -125,6 +130,7 @@ static void migrate_test(void)
 {
 	int loop, i, ret;
 
+	SAFE_SETEUID(ltpuser->pw_uid);
 	for (loop = 0; loop < N_LOOPS; loop++) {
 		i = loop % 2;
 		ret = tst_syscall(__NR_migrate_pages, 0, max_node,
@@ -134,6 +140,7 @@ static void migrate_test(void)
 			return;
 		}
 	}
+	SAFE_SETEUID(0);
 
 	tst_res(TPASS, "migrate_pages() passed");
 }
-- 
1.8.3.1

