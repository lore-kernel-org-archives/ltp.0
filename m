From: Michael Moese <mmoese@suse.de>
Date: Wed, 24 Jan 2018 14:03:05 +0100
Subject: [LTP] [PATCH 12/19] fix old style definition in cpuctl_test01.c
In-Reply-To: <20180124130312.7665-1-mmoese@suse.de>
References: <20180124130312.7665-1-mmoese@suse.de>
Message-ID: <20180124130312.7665-13-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 testcases/kernel/controllers/cpuctl/cpuctl_test01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test01.c b/testcases/kernel/controllers/cpuctl/cpuctl_test01.c
index 0cd587c3a..d7be1c80c 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_test01.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_test01.c
@@ -73,7 +73,7 @@ char *TCID = "cpuctl_test01";
 int TST_TOTAL = 1;
 pid_t scriptpid;
 char path[] = "/dev/cpuctl";
-extern void cleanup()
+extern void cleanup(void)
 {
 	kill(scriptpid, SIGUSR1);	/* Inform the shell to do cleanup */
 	tst_exit();		/* Report exit status */
-- 
2.13.6

