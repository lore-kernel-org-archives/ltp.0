Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <cristian@regolo.cc>) id 1PgNfI-0005tz-UI
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 20:33:00 +0000
Received: from aiolia.regolo.cc ([178.79.135.37])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PgNfI-0000OI-23
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 20:33:00 +0000
Received: from regolo (93-46-29-194.ip105.fastwebnet.it [93.46.29.194])
	by aiolia.regolo.cc (Postfix) with ESMTPSA id 9F7C470
	for <ltp-list@lists.sourceforge.net>;
	Fri, 21 Jan 2011 21:32:53 +0100 (CET)
Date: Fri, 21 Jan 2011 21:32:50 +0100
From: Cristian Greco <cristian@regolo.cc>
Message-ID: <20110121213250.54f2e4f2@regolo>
Mime-Version: 1.0
Subject: [LTP] [PATCH] Trivial fix for defines in mtest01.c.
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Hi,

this is a trivial fix.


Signed-off-by: Cristian Greco <cristian@regolo.cc>
---
 testcases/kernel/mem/mtest01/mtest01.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/mem/mtest01/mtest01.c b/testcases/kernel/mem/mtest01/mtest01.c
index 4c9390c..1afd78d 100644
--- a/testcases/kernel/mem/mtest01/mtest01.c
+++ b/testcases/kernel/mem/mtest01/mtest01.c
@@ -44,9 +44,9 @@
 
 #include "test.h"
 
-#define FIVE_HUNDRED_KB (unsigned long long)(500*1024*1024)
-#define ONE_MEGABYTE	(unsigned long long)(1024*1024*1024)
-#define THREE_MEGABYTES (unsigned long long)(3*ONE_MEGABYTE)
+#define FIVE_HUNDRED_MB (unsigned long long)(500*1024*1024)
+#define ONE_GIGABYTE	(unsigned long long)(1024*1024*1024)
+#define THREE_GIGABYTES (unsigned long long)(3*ONE_GIGABYTE)
 
 char *TCID = "mtest01";
 int TST_TOTAL = 1;
@@ -128,7 +128,7 @@ int main(int argc, char* argv[])
 	total_free = sstats.freeram + sstats.freeswap;
 	/* Total Free Pre-Test RAM */
 	pre_mem = sstats.mem_unit * total_free;   
-	max_pids = total_ram / (unsigned long)FIVE_HUNDRED_KB + 1;
+	max_pids = total_ram / (unsigned long)FIVE_HUNDRED_MB + 1;
  
 	if ((pid_list = malloc(max_pids * sizeof(pid_t))) == NULL)
 		tst_brkm(TBROK|TERRNO, NULL, "malloc failed.");
@@ -171,47 +171,47 @@ int main(int argc, char* argv[])
 	pid_list[i] = pid;
 
 #if defined (_s390_) /* s390's 31bit addressing requires smaller chunks */
-	while (pid != 0 && maxbytes > FIVE_HUNDRED_KB) {
+	while (pid != 0 && maxbytes > FIVE_HUNDRED_MB) {
 		i++;
-		maxbytes -= FIVE_HUNDRED_KB;
+		maxbytes -= FIVE_HUNDRED_MB;
 		pid = fork();
 		if (pid != 0) {
 			pid_cntr++;
 			pid_list[i] = pid;
 		}
 	}
-	if (maxbytes > FIVE_HUNDRED_KB)
-		alloc_bytes = FIVE_HUNDRED_KB;
+	if (maxbytes > FIVE_HUNDRED_MB)
+		alloc_bytes = FIVE_HUNDRED_MB;
 	else
 		alloc_bytes = (unsigned long) maxbytes;
 	
 #elif __WORDSIZE == 32
-	while (pid != 0 && maxbytes > ONE_MEGABYTE) {
+	while (pid != 0 && maxbytes > ONE_GIGABYTE) {
 		i++;
-		maxbytes -= ONE_MEGABYTE;
+		maxbytes -= ONE_GIGABYTE;
 		pid = fork();
 		if (pid != 0) {
 			pid_cntr++;
 			pid_list[i]=pid;
 		}
 	}
-	if (maxbytes > ONE_MEGABYTE)
-		alloc_bytes = ONE_MEGABYTE;
+	if (maxbytes > ONE_GIGABYTE)
+		alloc_bytes = ONE_GIGABYTE;
 	else
 		alloc_bytes = (unsigned long)maxbytes;
 	
 #elif __WORDSIZE == 64
-	while (pid != 0 && maxbytes > THREE_MEGABYTES) {
+	while (pid != 0 && maxbytes > THREE_GIGABYTES) {
 		i++;
-		maxbytes -= THREE_MEGABYTES;
+		maxbytes -= THREE_GIGABYTES;
 		pid = fork();
 		if (pid != 0) {
 			pid_cntr++;
 			pid_list[i] = pid;
 		}
 	}
-	if (maxbytes > THREE_MEGABYTES)
-		alloc_bytes = THREE_MEGABYTES;
+	if (maxbytes > THREE_GIGABYTES)
+		alloc_bytes = THREE_GIGABYTES;
 	else
 		alloc_bytes = maxbytes;
 #endif
-- 
1.7.2.3



Thanks,
--
Cristian Greco
GPG key ID: 0xCF4D32E4

------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
