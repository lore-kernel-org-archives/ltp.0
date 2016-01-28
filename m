From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 28 Jan 2016 12:40:03 +0100
Subject: [LTP] [PATCH] numa_node_size: drop definition of numa_exit_on_error
Message-ID: <83f07ff547bd812f586777e944097bae0b410ca6.1453981115.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

numa_exit_on_error is defined by numactl library in libnuma.c,
at least since version 0.9. Re-defining it in test can cause
compile problems.

Reported-by: M.Srikanth Kumar <srikanth007m@gmail.com>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/numa/numa_node_size.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/testcases/kernel/numa/numa_node_size.c b/testcases/kernel/numa/numa_node_size.c
index 6338bc73c864..378a1d5d1e54 100644
--- a/testcases/kernel/numa/numa_node_size.c
+++ b/testcases/kernel/numa/numa_node_size.c
@@ -38,7 +38,6 @@
 #include <numa.h>
 #endif
 
-int numa_exit_on_error = 0;
 char *fmt_mem(unsigned long long mem, char *buf)
 {
 	if (mem == -1L)
-- 
1.8.3.1

