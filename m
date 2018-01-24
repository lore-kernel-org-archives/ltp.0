From: Michael Moese <mmoese@suse.de>
Date: Wed, 24 Jan 2018 14:03:06 +0100
Subject: [LTP] [PATCH 13/19] fix old style definition and unuses argc/argv
	in main() in cpuctl_test02.c
In-Reply-To: <20180124130312.7665-1-mmoese@suse.de>
References: <20180124130312.7665-1-mmoese@suse.de>
Message-ID: <20180124130312.7665-14-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 testcases/kernel/controllers/cpuctl/cpuctl_test02.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test02.c b/testcases/kernel/controllers/cpuctl/cpuctl_test02.c
index d775a3e9f..2a5cd4a11 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_test02.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_test02.c
@@ -71,7 +71,7 @@ int TST_TOTAL = 1;
 pid_t scriptpid;
 char path[] = "/dev/cpuctl";
 
-extern void cleanup()
+extern void cleanup(void)
 {
 	kill(scriptpid, SIGUSR1);	/* Inform the shell to do cleanup */
 	tst_exit();		/* Report exit status */
@@ -80,7 +80,7 @@ extern void cleanup()
 int migrate_task();
 volatile int timer_expired = 0;
 
-int main(int argc, char *argv[])
+int main(void)
 {
 
 	int test_num;
@@ -272,7 +272,7 @@ with %u(shares) in %lu (s) INTERVAL\n", mygroup_num, task_num, delta_cpu_time,
 	}			/* end while */
 }				/* end main */
 
-int migrate_task()
+int migrate_task(void)
 {
 	char target[32] = "/dev/cpuctl/group_2/tasks";	/* Hard coding..Will try dynamic */
 	pid_t pid = getpid();
-- 
2.13.6

