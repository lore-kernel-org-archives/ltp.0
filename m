From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 22 Jun 2021 12:35:09 +0100
Subject: [LTP] [PATCH 3/8] hotplug: Fix uninitialized var
In-Reply-To: <20210622113514.22284-1-rpalethorpe@suse.com>
References: <20210622113514.22284-1-rpalethorpe@suse.com>
Message-ID: <20210622113514.22284-4-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This assumes glctx is the correct thing to use as in every other
function.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/hotplug/memory_hotplug/commands.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/testcases/kernel/hotplug/memory_hotplug/commands.c b/testcases/kernel/hotplug/memory_hotplug/commands.c
index 6655d3553..78f46fbca 100644
--- a/testcases/kernel/hotplug/memory_hotplug/commands.c
+++ b/testcases/kernel/hotplug/memory_hotplug/commands.c
@@ -438,16 +438,11 @@ static int get_arg_nodeid_list(char *args, unsigned int *list)
  */
 static int get_current_nodeid_list(unsigned int *fromids)
 {
-	/*
-	 * FIXME (garrcoop): gcp is uninitialized and shortly hereafter used in
-	 * an initialization statement..... UHHHHHHH... test writer fail?
-	 */
-	glctx_t *gcp;
+	glctx_t *gcp = &glctx;
 	nodemask_t my_allowed_nodes;
 	int nr_nodes = 0, max_node = gcp->numa_max_node;
 	int node;
 
-	gcp = &glctx;
 	my_allowed_nodes = numa_get_membind_compat();
 	for (node = 0; node <= max_node; ++node) {
 		if (nodemask_isset(&my_allowed_nodes, node))
-- 
2.31.1

