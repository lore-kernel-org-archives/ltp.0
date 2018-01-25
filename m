From: Michael Moese <mmoese@suse.de>
Date: Thu, 25 Jan 2018 16:23:03 +0100
Subject: [LTP] [PATCH 09/10] fix old-style-definition and unused parameter
	in ht_affinity.c
In-Reply-To: <20180125152304.32747-1-mmoese@suse.de>
References: <20180125152304.32747-1-mmoese@suse.de>
Message-ID: <20180125152304.32747-10-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 testcases/kernel/sched/hyperthreading/ht_affinity/ht_affinity.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/sched/hyperthreading/ht_affinity/ht_affinity.c b/testcases/kernel/sched/hyperthreading/ht_affinity/ht_affinity.c
index 5ac0fa23a..f6e9f2745 100644
--- a/testcases/kernel/sched/hyperthreading/ht_affinity/ht_affinity.c
+++ b/testcases/kernel/sched/hyperthreading/ht_affinity/ht_affinity.c
@@ -46,7 +46,7 @@ len - length in bytes of the bitmask pointed to by user_mask_ptr.
 #define AFFINITY_NAME "affinity"
 #define PROCFS_PATH "/proc/"
 
-int HT_SetAffinity()
+int HT_SetAffinity(void)
 {
 	unsigned int mask;
 	pid_t pid;
@@ -145,7 +145,7 @@ unsigned long get_porc_affinity(pid_t pid)
 	return atol(buf);
 }
 
-int HT_GetAffinity()
+int HT_GetAffinity(void)
 {
 	unsigned int mask[2], mask1[2];
 	pid_t pid;
@@ -177,7 +177,7 @@ int HT_GetAffinity()
 		return 0;
 }
 
-int HT_InheritAffinity()
+int HT_InheritAffinity(void)
 {
 	unsigned int mask[2];
 	pid_t pid;
@@ -211,7 +211,7 @@ int HT_InheritAffinity()
 }
 
 // return 0 means Pass, return 1 means Fail
-int main(int argc, char *argv[])
+int main(void)
 {
 
 #if (!defined __i386__ && !defined __x86_64__)
-- 
2.13.6

