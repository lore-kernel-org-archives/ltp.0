Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1PUzD7-0002cQ-5q
	for ltp-list@lists.sourceforge.net; Tue, 21 Dec 2010 10:12:49 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PUzD6-00064a-66
	for ltp-list@lists.sourceforge.net; Tue, 21 Dec 2010 10:12:49 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id oBLACgw2003270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 21 Dec 2010 05:12:42 -0500
From: Caspar Zhang <czhang@redhat.com>
Date: Tue, 21 Dec 2010 18:12:00 +0800
Message-Id: <1292926320-7079-1-git-send-email-czhang@redhat.com>
In-Reply-To: <czhang@redhat.com>
References: <czhang@redhat.com>
Subject: [LTP] [PATCH] make pid_list dynamically sized with memory
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

We get segfaults during testing mtest01 on a 5TB memory machine, the
problem was traced to the array pdi_list[] went to overflow and
corrupted memory. This fix makes pid_list[] dynamically sized with
correct memory size to avoid overflow.

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 testcases/kernel/mem/mtest01/mtest01.c |   50 +++++++++++++++++++------------
 1 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/testcases/kernel/mem/mtest01/mtest01.c b/testcases/kernel/mem/mtest01/mtest01.c
index e4e9a56..1362e08 100644
--- a/testcases/kernel/mem/mtest01/mtest01.c
+++ b/testcases/kernel/mem/mtest01/mtest01.c
@@ -44,6 +44,10 @@
 
 #include "test.h"
 
+#define MAX_31BIT_SIZE (unsigned long)(500*1024*1024)
+#define MAX_32BIT_SIZE (unsigned long)(1024*1024*1024)
+#define MAX_64BIT_SIZE (unsigned long long)(3*1024*1024*1024)
+
 char *TCID = "mtest01";
 int TST_TOTAL = 1;
 
@@ -62,11 +66,12 @@ int main(int argc, char* argv[]) {
   unsigned long bytecount, alloc_bytes;
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
@@ -74,8 +79,18 @@ int main(int argc, char* argv[]) {
   sigemptyset(&act.sa_mask);
   sigaction(SIGRTMIN,  &act, 0);
 
-  for (i=0;i<1000;i++)
-   pid_list[i]=(pid_t)0;
+  sysinfo(&sstats);
+  total_ram=sstats.totalram;
+  total_ram=total_ram+sstats.totalswap;
+#if defined (_s390_)
+  pidlist_sz = total_ram / MAX_31BIT_SIZE + 1;
+#elif __WORDSIZE==32
+  pidlist_sz = total_ram / MAX_32BIT_SIZE + 1;
+#elif __WORDSIZE==64
+  pidlist_sz = total_ram / MAX_64BIT_SIZE + 1;
+#endif
+  pid_list = (pid_t *)malloc(sizeof(pid_t) * pidlist_sz);
+  memset(pid_list, 0, sizeof(pid_t) * pidlist_sz);
 
   while ((c=getopt(argc, argv, "c:b:p:wvh")) != EOF) {
     switch((char)c) {
@@ -115,12 +130,8 @@ int main(int argc, char* argv[]) {
 
   sysinfo(&sstats);
   if (maxpercent) {
-    unsigned long long total_ram, total_free, D, C;
     percent=(float)maxpercent/100.00;
 
-    total_ram=sstats.totalram;
-    total_ram=total_ram+sstats.totalswap;
-
     total_free=sstats.freeram;
     total_free=total_free+sstats.freeswap;
 
@@ -157,47 +168,47 @@ int main(int argc, char* argv[]) {
     pid_list[i]=pid;
 
 #if defined (_s390_) /* s390's 31bit addressing requires smaller chunks */
-  while ( (pid!=0) && (maxbytes > 500*1024*1024) )
+  while ((pid!=0) && (maxbytes > MAX_31BIT_SIZE))
   {
     i++;
-    maxbytes=maxbytes-(500*1024*1024);
+    maxbytes -= MAX_31BIT_SIZE;
     pid=fork();
     if (pid != 0)
       pid_cntr++;
       pid_list[i]=pid;
   }
-  if ( maxbytes > 500*1024*1024 )
-    alloc_bytes=500*1024*1024;
+  if (maxbytes > MAX_31BIT_SIZE)
+    alloc_bytes = MAX_31BIT_SIZE;
   else
     alloc_bytes=(unsigned long)maxbytes;
 
 #elif __WORDSIZE==32
-  while ( (pid!=0) && (maxbytes > 1024*1024*1024) )
+  while ((pid!=0) && (maxbytes > MAX_32BIT_SIZE))
   {
     i++;
-    maxbytes=maxbytes-(1024*1024*1024);
+    maxbytes -= MAX_32BIT_SIZE;
     pid=fork();
     if (pid != 0)
       pid_cntr++;
       pid_list[i]=pid;
   }
-  if ( maxbytes > 1024*1024*1024 )
-    alloc_bytes=1024*1024*1024;
+  if (maxbytes > MAX_32BIT_SIZE)
+    alloc_bytes = MAX_32BIT_SIZE;
   else
     alloc_bytes=(unsigned long)maxbytes;
 
 #elif __WORDSIZE==64
-  while ( (pid!=0) && (maxbytes > (unsigned long long)3*1024*1024*1024) )
+  while ((pid!=0) && (maxbytes > MAX_64BIT_SIZE))
   {
     i++;
-    maxbytes=maxbytes-(unsigned long long)3*1024*1024*1024;
+    maxbytes - MAX_64BIT_SIZE;
     pid=fork();
     if (pid != 0)
       pid_cntr++;
       pid_list[i]=pid;
   }
-  if ( maxbytes > (unsigned long long)3*1024*1024*1024 )
-    alloc_bytes=(unsigned long long)3*1024*1024*1024;
+  if (maxbytes > MAX_64BIT_SIZE)
+    alloc_bytes = MAX_64BIT_SIZE;
   else
     alloc_bytes=(unsigned long)maxbytes;
 #endif
@@ -258,5 +269,6 @@ int main(int argc, char* argv[]) {
     else
       tst_resm(TPASS, "%llu kbytes allocated only.", original_maxbytes/1024);
   }
+  free(pid_list);
   exit(0);
 }
-- 
1.7.3.2


------------------------------------------------------------------------------
Lotusphere 2011
Register now for Lotusphere 2011 and learn how
to connect the dots, take your collaborative environment
to the next level, and enter the era of Social Business.
http://p.sf.net/sfu/lotusphere-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
