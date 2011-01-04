Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1PZxsD-0000Qg-Ng
	for ltp-list@lists.sourceforge.net; Tue, 04 Jan 2011 03:47:49 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PZxsC-0001AC-Is
	for ltp-list@lists.sourceforge.net; Tue, 04 Jan 2011 03:47:49 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id p043lg3T029733
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Jan 2011 22:47:42 -0500
From: czhang@redhat.com
Date: Tue,  4 Jan 2011 11:47:15 +0800
Message-Id: <1294112835-15883-1-git-send-email-czhang@redhat.com>
Subject: [LTP] [PATCH v2] make pid_list dynamically sized with memory
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Caspar Zhang <czhang@redhat.com>

From: Caspar Zhang <czhang@redhat.com>

We get segfaults during testing mtest01 on a 5TB memory machine, the
problem was traced to the array pdi_list[] went to overflow and
corrupted memory. This fix makes pid_list[] dynamically sized with
correct memory size to avoid overflow.

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 testcases/kernel/mem/mtest01/mtest01.c |   26 +++++++++++++++++---------
 1 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/mem/mtest01/mtest01.c b/testcases/kernel/mem/mtest01/mtest01.c
index aee0d51..0140938 100644
--- a/testcases/kernel/mem/mtest01/mtest01.c
+++ b/testcases/kernel/mem/mtest01/mtest01.c
@@ -44,6 +44,10 @@
 
 #include "test.h"
 
+#define FIVE_HUNDRED_KB	(500*1024*1024)
+#define ONE_MEGABYTE	(1024*1024*1024)
+#define THREE_MEGABYTES	(3*ONE_MEGABYTE)
+
 char *TCID = "mtest01";
 int TST_TOTAL = 1;
 
@@ -58,14 +62,15 @@ int main(int argc, char* argv[]) {
   char* mem;
   float percent;
   unsigned int maxpercent=0, dowrite=0, verbose=0, j, c;
-  unsigned long bytecount, alloc_bytes;
+  unsigned long bytecount, alloc_bytes, max_pids;
   unsigned long long original_maxbytes,maxbytes=0;
   unsigned long long pre_mem, post_mem;
+  unsigned long long total_ram, total_free, D, C;
   extern char* optarg;
   int chunksize = 1024*1024; /* one meg at a time by default */
   struct sysinfo sstats;
   int i,pid_cntr;
-  pid_t pid,pid_list[1000];
+  pid_t pid,*pid_list;
   struct sigaction act;
 
   act.sa_handler = handler;
@@ -73,8 +78,14 @@ int main(int argc, char* argv[]) {
   sigemptyset(&act.sa_mask);
   sigaction(SIGRTMIN,  &act, 0);
 
-  for (i=0;i<1000;i++)
-   pid_list[i]=(pid_t)0;
+  sysinfo(&sstats);
+  total_ram=sstats.totalram;
+  total_ram=total_ram+sstats.totalswap;
+  max_pids = total_ram / FIVE_HUNDRED_KB + 1;
+
+  if ((pid_list = malloc(max_pids * sizeof(pid_t))) == NULL)
+      tst_brkm(TBROK|TERRNO, cleanup, "malloc");
+  memset(pid_list, 0, max_pids * sizeof(pid_t));
 
   while ((c=getopt(argc, argv, "c:b:p:wvh")) != EOF) {
     switch((char)c) {
@@ -114,7 +125,6 @@ int main(int argc, char* argv[]) {
 
   sysinfo(&sstats);
   if (maxpercent) {
-    unsigned long long total_ram, total_free, D, C;
     percent=(float)maxpercent/100.00;
 
     total_ram=sstats.totalram;
@@ -155,9 +165,6 @@ int main(int argc, char* argv[]) {
     pid_list[i]=pid;
 
 #if defined (_s390_) /* s390's 31bit addressing requires smaller chunks */
-#define FIVE_HUNDRED_KB	(500*1024*1024)
-#define ONE_MEGABYTE	(1024*1024*1024)
-#define THREE_MEGABYTES	(3*ONE_MEGABYTE)
   while (pid != 0 && maxbytes > FIVE_HUNDRED_KB)
   {
     i++;
@@ -262,5 +269,6 @@ int main(int argc, char* argv[]) {
     else
       tst_resm(TPASS, "%llu kbytes allocated only.", original_maxbytes/1024);
   }
+  free(pid_list);
   exit(0);
-}
\ No newline at end of file
+}
-- 
1.7.3.4


------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
