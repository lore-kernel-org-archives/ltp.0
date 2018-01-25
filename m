From: Michael Moese <mmoese@suse.de>
Date: Thu, 25 Jan 2018 16:23:00 +0100
Subject: [LTP] [PATCH 06/10] fix old-style-definition in ht_utils.c
In-Reply-To: <20180125152304.32747-1-mmoese@suse.de>
References: <20180125152304.32747-1-mmoese@suse.de>
Message-ID: <20180125152304.32747-7-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 testcases/kernel/sched/hyperthreading/ht_affinity/ht_utils.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/sched/hyperthreading/ht_affinity/ht_utils.c b/testcases/kernel/sched/hyperthreading/ht_affinity/ht_utils.c
index d6f3ef523..18f0862cb 100644
--- a/testcases/kernel/sched/hyperthreading/ht_affinity/ht_utils.c
+++ b/testcases/kernel/sched/hyperthreading/ht_affinity/ht_utils.c
@@ -16,7 +16,7 @@
 
 char buffer[BUFF_SIZE];
 
-int is_ht_cpu()
+int is_ht_cpu(void)
 {
 	/*Number of logic processor in a physical processor */
 	int smp_num_siblings = -1;
@@ -39,7 +39,7 @@ int is_ht_cpu()
 
 /* return 0 means Pass,
  return 1 means ht is not enabled,*/
-int check_ht_capability()
+int check_ht_capability(void)
 {
 	int result;
 	if (is_ht_cpu())
@@ -57,7 +57,7 @@ int check_ht_capability()
 
 char buf[256];
 
-int get_cpu_count()
+int get_cpu_count(void)
 {
 	FILE *pfile;
 	int count;
-- 
2.13.6

