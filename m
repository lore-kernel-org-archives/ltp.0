From: Michael Moese <mmoese@suse.de>
Date: Thu, 25 Jan 2018 16:23:02 +0100
Subject: [LTP] [PATCH 08/10] fix old-style-definition in ht_utils.c
In-Reply-To: <20180125152304.32747-1-mmoese@suse.de>
References: <20180125152304.32747-1-mmoese@suse.de>
Message-ID: <20180125152304.32747-9-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 testcases/kernel/sched/hyperthreading/ht_interrupt/ht_utils.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/sched/hyperthreading/ht_interrupt/ht_utils.c b/testcases/kernel/sched/hyperthreading/ht_interrupt/ht_utils.c
index bd2d373e5..66bf69212 100644
--- a/testcases/kernel/sched/hyperthreading/ht_interrupt/ht_utils.c
+++ b/testcases/kernel/sched/hyperthreading/ht_interrupt/ht_utils.c
@@ -41,7 +41,7 @@ int is_cmdline_para(const char *para)
 	return 0;
 }
 
-int is_ht_kernel()
+int is_ht_kernel(void)
 {
 	FILE *fp;
 
@@ -59,7 +59,7 @@ int is_ht_kernel()
 	return 0;
 }
 
-int is_ht_cpu()
+int is_ht_cpu(void)
 {
 	/*Number of logic processor in a physical processor */
 	int smp_num_siblings = -1;
@@ -79,7 +79,7 @@ int is_ht_cpu()
 	}
 }
 
-int is_ht_enabled()
+int is_ht_enabled(void)
 {
 	int cpu_map[MAX_CPU_NUM];
 	/*A bit-map shows whether a 'logic' processor has ht flag */
@@ -176,7 +176,7 @@ int is_ht_enabled()
 // return 1 means ht is not enabled,
 // return 2 means CPU is not support ht,
 // return 3 mean kernel is not support ht.
-int check_ht_capability()
+int check_ht_capability(void)
 {
 	int result;
 
@@ -201,7 +201,7 @@ int check_ht_capability()
 
 char buf[256];
 
-int get_cpu_count()
+int get_cpu_count(void)
 {
 	FILE *pfile;
 	int count;
-- 
2.13.6

