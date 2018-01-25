From: Michael Moese <mmoese@suse.de>
Date: Thu, 25 Jan 2018 16:23:04 +0100
Subject: [LTP] [PATCH 10/10] fix unused-parameter and old-style-definition
	in ht_interrupt.c
In-Reply-To: <20180125152304.32747-1-mmoese@suse.de>
References: <20180125152304.32747-1-mmoese@suse.de>
Message-ID: <20180125152304.32747-11-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 testcases/kernel/sched/hyperthreading/ht_interrupt/ht_interrupt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/sched/hyperthreading/ht_interrupt/ht_interrupt.c b/testcases/kernel/sched/hyperthreading/ht_interrupt/ht_interrupt.c
index cab968c9f..38f235ec8 100644
--- a/testcases/kernel/sched/hyperthreading/ht_interrupt/ht_interrupt.c
+++ b/testcases/kernel/sched/hyperthreading/ht_interrupt/ht_interrupt.c
@@ -24,7 +24,7 @@ int TST_TOTAL = 1;
 
 #define INTERRUPT_NAME	"/proc/interrupts"
 
-int HT_InterruptDistribution()
+int HT_InterruptDistribution(void)
 {
 	FILE *pFile;
 	int ci[32], cj[32];
@@ -91,7 +91,7 @@ int HT_InterruptDistribution()
 }
 
 // return 0 means Pass, return 1 means Fail.
-int main(int argc, char *argv[])
+int main(void)
 {
 	tst_resm(TINFO, "Begin: HyperThreading Interrupt");
 
-- 
2.13.6

