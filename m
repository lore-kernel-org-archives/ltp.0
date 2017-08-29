From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 29 Aug 2017 08:43:08 +0200
Subject: [LTP] [PATCH 1/2] numa_helper: Fix compiler warnings
Message-ID: <20170829064309.14383-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

about comparison between signed and unsigned integer

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/lib/numa_helper.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/lib/numa_helper.c b/testcases/kernel/lib/numa_helper.c
index a852f152f..afc09b8db 100644
--- a/testcases/kernel/lib/numa_helper.c
+++ b/testcases/kernel/lib/numa_helper.c
@@ -60,7 +60,7 @@ unsigned long get_max_node(void)
 static void get_nodemask_allnodes(nodemask_t * nodemask, unsigned long max_node)
 {
 	unsigned long nodemask_size = max_node / 8;
-	int i;
+	unsigned int i;
 	char fn[64];
 	struct stat st;
 
@@ -95,7 +95,7 @@ static int filter_nodemask_mem(nodemask_t * nodemask, unsigned long max_node)
 		return -2;
 	}
 #else
-	int i;
+	unsigned int i;
 	/*
 	 * old libnuma/kernel don't have MPOL_F_MEMS_ALLOWED, so let's assume
 	 * that we can use any node with memory > 0
@@ -112,7 +112,7 @@ static int filter_nodemask_mem(nodemask_t * nodemask, unsigned long max_node)
 
 static int cpumask_has_cpus(char *cpumask, size_t len)
 {
-	int j;
+	unsigned int j;
 	for (j = 0; j < len; j++)
 		if (cpumask[j] == '\0')
 			return 0;
@@ -129,7 +129,8 @@ static void filter_nodemask_cpu(nodemask_t * nodemask, unsigned long max_node)
 	char fn[64];
 	FILE *f;
 	size_t len;
-	int i, ret;
+	unsigned int i;
+	int ret;
 
 	for (i = 0; i < max_node; i++) {
 		if (!nodemask_isset(nodemask, i))
@@ -164,7 +165,7 @@ int get_allowed_nodes_arr(int flag, int *num_nodes, int **nodes)
 {
 	int ret = 0;
 #if HAVE_NUMA_H
-	int i;
+	unsigned int i;
 	nodemask_t *nodemask = NULL;
 #endif
 	*num_nodes = 0;
-- 
2.14.0

