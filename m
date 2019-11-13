From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 13 Nov 2019 20:58:38 +0100
Subject: [LTP] [PATCH] mbind04: terminate child processes
Message-ID: <51aabb2e4680d830b5ba7b7623e0c7697bcb6338.1573675056.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

verify_policy() forks a child, which continues to run
pass end of function and into same loop in verify_mbind()
as parent, effectively creating fork bomb. With 2 nodes,
there's 45 forked children. With 4 nodes, 765 processes.

Terminate child process at the end of verify_policy();

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/mbind/mbind04.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/mbind/mbind04.c b/testcases/kernel/syscalls/mbind/mbind04.c
index 6a7a2a2321a8..aaad8a988bad 100644
--- a/testcases/kernel/syscalls/mbind/mbind04.c
+++ b/testcases/kernel/syscalls/mbind/mbind04.c
@@ -47,6 +47,7 @@ static void verify_policy(unsigned int node, int mode, unsigned flag)
 	struct bitmask *bm = numa_allocate_nodemask();
 	unsigned int i;
 	void *ptr;
+	pid_t child;
 	unsigned long size = PAGES_ALLOCATED * page_size;
 
 	numa_bitmask_setbit(bm, node);
@@ -69,7 +70,8 @@ static void verify_policy(unsigned int node, int mode, unsigned flag)
 
 	const char *prefix = "child: ";
 
-	if (SAFE_FORK()) {
+	child = SAFE_FORK();
+	if (child) {
 		prefix = "parent: ";
 		tst_reap_children();
 	}
@@ -104,6 +106,9 @@ static void verify_policy(unsigned int node, int mode, unsigned flag)
 
 	if (fail)
 		tst_nodemap_print_counters(nodes);
+
+	if (!child)
+		exit(0);
 }
 
 static const int modes[] = {
-- 
1.8.3.1

