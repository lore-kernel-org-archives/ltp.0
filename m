Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1Pa9dk-0008HH-3C
	for ltp-list@lists.sourceforge.net; Tue, 04 Jan 2011 16:21:40 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1Pa9dg-0007PX-RL
	for ltp-list@lists.sourceforge.net; Tue, 04 Jan 2011 16:21:40 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id p04GLVrv004705
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Jan 2011 11:21:31 -0500
From: czhang@redhat.com
Date: Wed,  5 Jan 2011 00:21:11 +0800
Message-Id: <1294158071-18027-1-git-send-email-czhang@redhat.com>
Subject: [LTP] [PATCH v3] make pid_list dynamically sized with memory
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
problem was traced to the array pid_list[] went to overflow and
corrupted memory. This fix makes pid_list dynamically sized with
correct memory size to avoid overflow.

v2: not split into different bits when allocating pid_list.
v3: 1) fix optargs: -b and -p should not be used at the same time.
    2) pre_mem maybe not initialized before using if -p option not used.
    fix it by moving it outside ``if(maxpercent)'' block.

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 testcases/kernel/mem/mtest01/mtest01.c |   64 +++++++++++++++++++-------------
 1 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/testcases/kernel/mem/mtest01/mtest01.c b/testcases/kernel/mem/mtest01/mtest01.c
index aee0d51..2ea921e 100644
--- a/testcases/kernel/mem/mtest01/mtest01.c
+++ b/testcases/kernel/mem/mtest01/mtest01.c
@@ -44,6 +44,10 @@
 
 #include "test.h"
 
+#define FIVE_HUNDRED_KB (unsigned long long)(500*1024*1024)
+#define ONE_MEGABYTE    (unsigned long long)(1024*1024*1024)
+#define THREE_MEGABYTES (unsigned long long)(3*ONE_MEGABYTE)
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
@@ -73,9 +78,6 @@ int main(int argc, char* argv[]) {
   sigemptyset(&act.sa_mask);
   sigaction(SIGRTMIN,  &act, 0);
 
-  for (i=0;i<1000;i++)
-   pid_list[i]=(pid_t)0;
-
   while ((c=getopt(argc, argv, "c:b:p:wvh")) != EOF) {
     switch((char)c) {
       case 'c':
@@ -83,9 +85,17 @@ int main(int argc, char* argv[]) {
         break;
       case 'b':
         maxbytes = atoll(optarg);
+        if (maxpercent != 0) {
+            tst_resm(TFAIL, "ERROR: -b option cannot be used with -p option at the same time");
+            exit(1);
+        }
         break;
       case 'p':
         maxpercent = atoi(optarg);
+        if (maxbytes != 0) {
+            tst_resm(TFAIL, "ERROR: -p option cannot be used with -b option at the same time");
+            exit(1);
+        }
 	if (maxpercent <= 0) {
 	  tst_resm(TFAIL, "ERROR: -p option requires number greater than 0");
 	  exit(1);}
@@ -113,34 +123,37 @@ int main(int argc, char* argv[]) {
   }
 
   sysinfo(&sstats);
-  if (maxpercent) {
-    unsigned long long total_ram, total_free, D, C;
-    percent=(float)maxpercent/100.00;
+  total_ram = sstats.totalram + sstats.totalswap; 
+  total_free = sstats.freeram + sstats.freeswap;
+  /* Total Free Pre-Test RAM */
+  pre_mem = sstats.mem_unit*total_free;
 
-    total_ram=sstats.totalram;
-    total_ram=total_ram+sstats.totalswap;
+  max_pids = total_ram / FIVE_HUNDRED_KB + 1;
 
-    total_free=sstats.freeram;
-    total_free=total_free+sstats.freeswap;
+  if ((pid_list = malloc(max_pids * sizeof(pid_t))) == NULL)
+  {
+      tst_resm(TBROK|TERRNO, "malloc");
+      exit(1);
+  }
+  memset(pid_list, 0, max_pids * sizeof(pid_t));
 
-    /* Total memory used needed to reach maxpercent */
-    D = percent*(sstats.mem_unit*total_ram);
-    tst_resm(TINFO, "Total memory used needed to reach maxpercent = %llu kbytes", D/1024);
+  /* Currently used memory */
+  C = sstats.mem_unit*(total_ram-total_free);
+  tst_resm(TINFO, "Total memory already used on system = %llu kbytes", C/1024);
 
-    /* Total memory already used */
-    C = sstats.mem_unit*(total_ram-total_free);
-    tst_resm(TINFO, "Total memory already used on system = %llu kbytes", C/1024);
+  if (maxpercent) {
+    percent=(float)maxpercent/100.00;
 
-    /* Total Free Pre-Test RAM */
-    pre_mem = sstats.mem_unit*total_free;
+    /* Desired memory needed to reach maxpercent */
+    D = percent*(sstats.mem_unit*total_ram);
+    tst_resm(TINFO, "Total memory used needed to reach maxpercent = %llu kbytes", D/1024);
 
     /* Are we already using more than maxpercent? */
     if (C>D) {
       tst_resm(TFAIL, "More memory than the maximum amount you specified is already being used");
+      free(pid_list);
       exit(1);
     }
-    else
-      pre_mem = sstats.mem_unit*total_free;
 
     /* set maxbytes to the extra amount we want to allocate */
     maxbytes = D-C;
@@ -155,9 +168,6 @@ int main(int argc, char* argv[]) {
     pid_list[i]=pid;
 
 #if defined (_s390_) /* s390's 31bit addressing requires smaller chunks */
-#define FIVE_HUNDRED_KB	(500*1024*1024)
-#define ONE_MEGABYTE	(1024*1024*1024)
-#define THREE_MEGABYTES	(3*ONE_MEGABYTE)
   while (pid != 0 && maxbytes > FIVE_HUNDRED_KB)
   {
     i++;
@@ -212,6 +222,7 @@ int main(int argc, char* argv[]) {
     while (1) {
       if ((mem = (char*)malloc(chunksize)) == NULL) {
         tst_resm(TINFO, "stopped at %lu bytes", bytecount);
+        free(pid_list);
         exit(1);
       }
       if (dowrite)
@@ -262,5 +273,6 @@ int main(int argc, char* argv[]) {
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
