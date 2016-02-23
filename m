From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 23 Feb 2016 11:00:31 +0100
Subject: [LTP] [PATCH v2 1/2] numa_helper: don't break is_numa() with TCONF
Message-ID: <83c57fb26e06f81d4b71cb89dfcd36706bf28093.1456220777.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Li reported, that some oom tests on aarch64 exit with TCONF
during is_numa() call, because get_mempolicy syscall is not
implemented. And because numa_helper used ltp_syscall() it
terminated the test in all instances.

Make sure we check that NUMA is available first with
numa_available(). In case it's not supported return empty
set of nodes.

Also ignore ENOSYS from get_mempolicy. At the moment this is
redundant, because numa_available() implementation is based
on availability of get_mempolicy as well, but extra check
doesn't hurt in case it would change in future.

Reported-by: Li Wang <liwang@redhat.com>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/lib/numa_helper.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/lib/numa_helper.c b/testcases/kernel/lib/numa_helper.c
index 0074180991ec..82b1978f7d8a 100644
--- a/testcases/kernel/lib/numa_helper.c
+++ b/testcases/kernel/lib/numa_helper.c
@@ -81,10 +81,19 @@ static int filter_nodemask_mem(nodemask_t * nodemask, unsigned long max_node)
 	 * avoid numa_get_mems_allowed(), because of bug in getpol()
 	 * utility function in older versions:
 	 * http://www.spinics.net/lists/linux-numa/msg00849.html
+	 *
+	 * At the moment numa_available() implementation also uses
+	 * get_mempolicy, but let's make explicit check for ENOSYS
+	 * here as well in case it changes in future. Silent ignore
+	 * of ENOSYS is OK, because without NUMA caller gets empty
+	 * set of nodes anyway.
 	 */
-	if (ltp_syscall(__NR_get_mempolicy, NULL, nodemask->n,
-		    max_node, 0, MPOL_F_MEMS_ALLOWED) < 0)
+	if (syscall(__NR_get_mempolicy, NULL, nodemask->n,
+		    max_node, 0, MPOL_F_MEMS_ALLOWED) < 0) {
+		if (errno == ENOSYS)
+			return 0;
 		return -2;
+	}
 #else
 	int i;
 	/*
@@ -163,9 +172,13 @@ int get_allowed_nodes_arr(int flag, int *num_nodes, int **nodes)
 		*nodes = NULL;
 
 #if HAVE_NUMA_H
-	unsigned long max_node = LTP_ALIGN(get_max_node(),
-						sizeof(unsigned long)*8);
-	unsigned long nodemask_size = max_node / 8;
+	unsigned long max_node, nodemask_size;
+
+	if (numa_available() == -1)
+		return 0;
+
+	max_node = LTP_ALIGN(get_max_node(), sizeof(unsigned long)*8);
+	nodemask_size = max_node / 8;
 
 	nodemask = malloc(nodemask_size);
 	if (nodes)
-- 
1.8.3.1

