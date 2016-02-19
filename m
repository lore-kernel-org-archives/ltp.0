From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 19 Feb 2016 16:02:18 +0100
Subject: [LTP] [PATCH] numa_helper: don't break is_numa() with TCONF
Message-ID: <d0fb0cdbb9db3b4a1421b0b097b82997a8d6ed3f.1455893957.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Li reported, that some oom tests on aarch64 exit with TCONF
during is_numa() call, because get_mempolicy syscall is not
implemented. And because numa_helper used ltp_syscall() it
terminated the test in all instances.

Switch to syscall() and let the tests decide what should happen
if system doesn't support NUMA.

Reported-by: Li Wang <liwang@redhat.com>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/lib/numa_helper.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/lib/numa_helper.c b/testcases/kernel/lib/numa_helper.c
index 0074180991ec..91214fcd85d9 100644
--- a/testcases/kernel/lib/numa_helper.c
+++ b/testcases/kernel/lib/numa_helper.c
@@ -76,14 +76,22 @@ static int filter_nodemask_mem(nodemask_t * nodemask, unsigned long max_node)
 {
 #if MPOL_F_MEMS_ALLOWED
 	unsigned long nodemask_size = max_node / 8;
+	int ret;
+
 	memset(nodemask, 0, nodemask_size);
 	/*
 	 * avoid numa_get_mems_allowed(), because of bug in getpol()
 	 * utility function in older versions:
 	 * http://www.spinics.net/lists/linux-numa/msg00849.html
 	 */
-	if (ltp_syscall(__NR_get_mempolicy, NULL, nodemask->n,
-		    max_node, 0, MPOL_F_MEMS_ALLOWED) < 0)
+	ret = syscall(__NR_get_mempolicy, NULL, nodemask->n,
+		    max_node, 0, MPOL_F_MEMS_ALLOWED);
+	/*
+	 * If we don't have __NR_get_mempolicy assume we can use all
+	 * present nodes. It is likely this is a system, that doesn't
+	 * support NUMA and there's just 1 node.
+	 */
+	if (ret < 0 && errno != ENOSYS)
 		return -2;
 #else
 	int i;
-- 
1.8.3.1

