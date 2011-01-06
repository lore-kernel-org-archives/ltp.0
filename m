Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1PaulJ-0002Wb-Sd
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 18:40:37 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PaulI-0007ft-Ee
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 18:40:37 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id p06IeTHi027904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 6 Jan 2011 13:40:30 -0500
From: czhang@redhat.com
Date: Fri,  7 Jan 2011 02:40:11 +0800
Message-Id: <1294339211-19449-1-git-send-email-czhang@redhat.com>
Subject: [LTP] [PATCH v4] make pid_list dynamically sized with memory
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
v4: fix code format.

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 testcases/kernel/mem/mtest01/mtest01.c |  409 +++++++++++++++++---------------
 1 files changed, 215 insertions(+), 194 deletions(-)

diff --git a/testcases/kernel/mem/mtest01/mtest01.c b/testcases/kernel/mem/mtest01/mtest01.c
index aee0d51..94b429a 100644
--- a/testcases/kernel/mem/mtest01/mtest01.c
+++ b/testcases/kernel/mem/mtest01/mtest01.c
@@ -44,223 +44,244 @@
 
 #include "test.h"
 
+#define FIVE_HUNDRED_KB (unsigned long long)(500*1024*1024)
+#define ONE_MEGABYTE    (unsigned long long)(1024*1024*1024)
+#define THREE_MEGABYTES (unsigned long long)(3*ONE_MEGABYTE)
+
 char *TCID = "mtest01";
 int TST_TOTAL = 1;
-
 int pid_count = 0;
 
 void handler(int signo)
 {
-        pid_count++;
+    pid_count++;
 }
 
-int main(int argc, char* argv[]) {
-  char* mem;
-  float percent;
-  unsigned int maxpercent=0, dowrite=0, verbose=0, j, c;
-  unsigned long bytecount, alloc_bytes;
-  unsigned long long original_maxbytes,maxbytes=0;
-  unsigned long long pre_mem, post_mem;
-  extern char* optarg;
-  int chunksize = 1024*1024; /* one meg at a time by default */
-  struct sysinfo sstats;
-  int i,pid_cntr;
-  pid_t pid,pid_list[1000];
-  struct sigaction act;
-
-  act.sa_handler = handler;
-  act.sa_flags = 0;
-  sigemptyset(&act.sa_mask);
-  sigaction(SIGRTMIN,  &act, 0);
-
-  for (i=0;i<1000;i++)
-   pid_list[i]=(pid_t)0;
-
-  while ((c=getopt(argc, argv, "c:b:p:wvh")) != EOF) {
-    switch((char)c) {
-      case 'c':
-        chunksize = atoi(optarg);
-        break;
-      case 'b':
-        maxbytes = atoll(optarg);
-        break;
-      case 'p':
-        maxpercent = atoi(optarg);
-	if (maxpercent <= 0) {
-	  tst_resm(TFAIL, "ERROR: -p option requires number greater than 0");
-	  exit(1);}
-	if (maxpercent > 99) {
-	  tst_resm(TFAIL, "ERROR: -p option cannot be greater than 99");
-	  exit(1);}
-        break;
-      case 'w':
-        dowrite = 1;
-        break;
-      case 'v':
-        verbose = 1;
-        break;
-      case 'h':
-      default:
-        printf("Usage: %s [-c <bytes>] [-b <bytes>|-p <percent>] [-v]\n", argv[0]);
-        printf("\t-c <num>\tsize of chunk in bytes to malloc on each pass\n");
-        printf("\t-b <bytes>\tmaximum number of bytes to allocate before stopping\n");
-        printf("\t-p <bytes>\tpercent of total memory used at which the program stops\n");
-        printf("\t-w\t\twrite to the memory after allocating\n");
-        printf("\t-v\t\tverbose\n");
-        printf("\t-h\t\tdisplay usage\n");
-        exit(-1);
-    }
-  }
-
-  sysinfo(&sstats);
-  if (maxpercent) {
+int main(int argc, char* argv[])
+{
+    char* mem;
+    float percent;
+    unsigned int maxpercent = 0, dowrite = 0, verbose=0, j, c;
+    unsigned long bytecount, alloc_bytes, max_pids;
+    unsigned long long original_maxbytes, maxbytes = 0;
+    unsigned long long pre_mem, post_mem;
     unsigned long long total_ram, total_free, D, C;
-    percent=(float)maxpercent/100.00;
-
-    total_ram=sstats.totalram;
-    total_ram=total_ram+sstats.totalswap;
-
-    total_free=sstats.freeram;
-    total_free=total_free+sstats.freeswap;
-
-    /* Total memory used needed to reach maxpercent */
-    D = percent*(sstats.mem_unit*total_ram);
-    tst_resm(TINFO, "Total memory used needed to reach maxpercent = %llu kbytes", D/1024);
-
-    /* Total memory already used */
-    C = sstats.mem_unit*(total_ram-total_free);
-    tst_resm(TINFO, "Total memory already used on system = %llu kbytes", C/1024);
+    extern char* optarg;
+    int chunksize = 1024*1024; /* one meg at a time by default */
+    struct sysinfo sstats;
+    int i, pid_cntr;
+    pid_t pid, *pid_list;
+    struct sigaction act;
 
+    act.sa_handler = handler;
+    act.sa_flags = 0;
+    sigemptyset(&act.sa_mask);
+    sigaction(SIGRTMIN,  &act, 0);
+    
+    while ((c = getopt(argc, argv, "c:b:p:wvh")) != EOF) 
+    {
+        switch((char)c) 
+        {
+            case 'c':
+                chunksize = atoi(optarg);
+                break;
+            case 'b':
+                if (maxpercent != 0) {
+                    tst_resm(TFAIL, "ERROR: -b option cannot be used with -p option at the same time");
+                    exit(1);
+                }
+                maxbytes = atoll(optarg);
+                break;
+            case 'p':
+                if (maxbytes != 0) {
+                    tst_resm(TFAIL, "ERROR: -p option cannot be used with -b option at the same time");
+                    exit(1);
+                }
+                maxpercent = atoi(optarg);
+                if (maxpercent <= 0) {
+                    tst_resm(TFAIL, "ERROR: -p option requires number greater than 0");
+                    exit(1);
+                }
+                if (maxpercent > 99) {
+                    tst_resm(TFAIL, "ERROR: -p option cannot be greater than 99");
+                    exit(1);
+                }
+                break;
+            case 'w':
+                dowrite = 1;
+                break;
+            case 'v':
+                verbose = 1;
+                break;
+            case 'h':
+            default:
+                printf("Usage: %s [-c <bytes>] [-b <bytes>|-p <percent>] [-v]\n", argv[0]);
+                printf("\t-c <num>\tsize of chunk in bytes to malloc on each pass\n");
+                printf("\t-b <bytes>\tmaximum number of bytes to allocate before stopping\n");
+                printf("\t-p <bytes>\tpercent of total memory used at which the program stops\n");
+                printf("\t-w\t\twrite to the memory after allocating\n");
+                printf("\t-v\t\tverbose\n");
+                printf("\t-h\t\tdisplay usage\n");
+                exit(-1);
+        }
+    }
+    
+    sysinfo(&sstats);
+    total_ram = sstats.totalram + sstats.totalswap; 
+    total_free = sstats.freeram + sstats.freeswap;
     /* Total Free Pre-Test RAM */
-    pre_mem = sstats.mem_unit*total_free;
-
-    /* Are we already using more than maxpercent? */
-    if (C>D) {
-      tst_resm(TFAIL, "More memory than the maximum amount you specified is already being used");
-      exit(1);
+    pre_mem = sstats.mem_unit * total_free;   
+    max_pids = total_ram / (unsigned long)FIVE_HUNDRED_KB + 1;
+ 
+    if ((pid_list = malloc(max_pids * sizeof(pid_t))) == NULL)
+    {
+        tst_resm(TBROK|TERRNO, "malloc failed.");
+        exit(1);
     }
-    else
-      pre_mem = sstats.mem_unit*total_free;
+    memset(pid_list, 0, max_pids * sizeof(pid_t));
+    
+    /* Currently used memory */
+    C = sstats.mem_unit * (total_ram - total_free);
+    tst_resm(TINFO, "Total memory already used on system = %llu kbytes", C/1024);
+    
+    if (maxpercent) 
+    {
+        percent = (float)maxpercent / 100.00;
 
-    /* set maxbytes to the extra amount we want to allocate */
-    maxbytes = D-C;
-    tst_resm(TINFO, "Filling up %d%% of ram which is %llu kbytes", maxpercent, maxbytes/1024);
-  }
-  original_maxbytes=maxbytes;
-  i=0;
-  pid_cntr=0;
-  pid=fork();
-  if (pid != 0)
-    pid_cntr++;
-    pid_list[i]=pid;
+        /* Desired memory needed to reach maxpercent */
+        D = percent * (sstats.mem_unit * total_ram);
+        tst_resm(TINFO, "Total memory used needed to reach maxpercent = %llu kbytes", D/1024);
+        
+        /* Are we already using more than maxpercent? */
+        if (C > D) 
+        {
+            tst_resm(TFAIL, "More memory than the maximum amount you specified is already being used");
+            free(pid_list);
+            exit(1);
+        }
+        
+        /* set maxbytes to the extra amount we want to allocate */
+        maxbytes = D - C;
+        tst_resm(TINFO, "Filling up %d%% of ram which is %llu kbytes", maxpercent, maxbytes/1024);
+    }
+    original_maxbytes = maxbytes;
+    i = 0;
+    pid_cntr = 0;
+    pid = fork();
+    if (pid != 0)
+        pid_cntr++;
+    pid_list[i] = pid;
 
 #if defined (_s390_) /* s390's 31bit addressing requires smaller chunks */
-#define FIVE_HUNDRED_KB	(500*1024*1024)
-#define ONE_MEGABYTE	(1024*1024*1024)
-#define THREE_MEGABYTES	(3*ONE_MEGABYTE)
-  while (pid != 0 && maxbytes > FIVE_HUNDRED_KB)
-  {
-    i++;
-    maxbytes -= FIVE_HUNDRED_KB;
-    pid = fork();
-    if (pid != 0) {
-      pid_cntr++;
-      pid_list[i] = pid;
+    while (pid != 0 && maxbytes > FIVE_HUNDRED_KB)
+    {
+        i++;
+        maxbytes -= FIVE_HUNDRED_KB;
+        pid = fork();
+        if (pid != 0) 
+        {
+            pid_cntr++;
+            pid_list[i] = pid;
+        }
     }
-  }
-  if (maxbytes > FIVE_HUNDRED_KB)
-    alloc_bytes FIVE_HUNDRED_KB;
-  else
-    alloc_bytes = (unsigned long) maxbytes;
-
+    if (maxbytes > FIVE_HUNDRED_KB)
+        alloc_bytes = FIVE_HUNDRED_KB;
+    else
+        alloc_bytes = (unsigned long) maxbytes;
+    
 #elif __WORDSIZE==32
-  while (pid != 0 && maxbytes > ONE_MEGABYTE)
-  {
-    i++;
-    maxbytes -= ONE_MEGABYTE;
-    pid = fork();
-    if (pid != 0) {
-      pid_cntr++;
-      pid_list[i]=pid;
+    while (pid != 0 && maxbytes > ONE_MEGABYTE)
+    {
+        i++;
+        maxbytes -= ONE_MEGABYTE;
+        pid = fork();
+        if (pid != 0) 
+        {
+            pid_cntr++;
+            pid_list[i]=pid;
+        }
     }
-  }
-  if (maxbytes > ONE_MEGABYTE)
-    alloc_bytes = ONE_MEGABYTE;
-  else
-    alloc_bytes = (unsigned long)maxbytes;
-
+    if (maxbytes > ONE_MEGABYTE)
+        alloc_bytes = ONE_MEGABYTE;
+    else
+        alloc_bytes = (unsigned long)maxbytes;
+    
 #elif __WORDSIZE==64
-  while (pid!=0 && maxbytes > THREE_MEGABYTES)
-  {
-    i++;
-    maxbytes -= THREE_MEGABYTES;
-    pid=fork();
-    if (pid != 0) {
-      pid_cntr++;
-      pid_list[i] = pid;
-    }
-  }
-  if (maxbytes > THREE_MEGABYTES)
-    alloc_bytes = THREE_MEGABYTES;
-  else
-    alloc_bytes = maxbytes;
-#endif
-
-  if (pid == 0)			/** CHILD **/
-  {
-    bytecount=chunksize;
-    while (1) {
-      if ((mem = (char*)malloc(chunksize)) == NULL) {
-        tst_resm(TINFO, "stopped at %lu bytes", bytecount);
-        exit(1);
-      }
-      if (dowrite)
-        for (j=0; j<chunksize; j++)
-          *(mem+j)='a';
-      if (verbose)
-	tst_resm(TINFO, "allocated %lu bytes chunksize is %d", bytecount, chunksize);
-      bytecount+=chunksize;
-      if (alloc_bytes && (bytecount >= alloc_bytes))
-        break;
+    while (pid!=0 && maxbytes > THREE_MEGABYTES) 
+    {
+        i++;
+        maxbytes -= THREE_MEGABYTES;
+        pid = fork();
+        if (pid != 0) 
+        {
+            pid_cntr++;
+            pid_list[i] = pid;
+        }
     }
-    if (dowrite)
-      tst_resm(TINFO, "... %lu bytes allocated and used.", bytecount);
+    if (maxbytes > THREE_MEGABYTES)
+        alloc_bytes = THREE_MEGABYTES;
     else
-      tst_resm(TINFO, "... %lu bytes allocated only.", bytecount);
-    kill(getppid(),SIGRTMIN);
-    while (1)
-      sleep(1);
-  }
-  else					/** PARENT **/
-  {
-
-    i=0;
-    sysinfo(&sstats);
+        alloc_bytes = maxbytes;
+#endif
 
-    if (dowrite)
+    if (pid == 0)         /** CHILD **/
     {
-      /* Total Free Post-Test RAM */
-      post_mem = (unsigned long long)sstats.mem_unit*sstats.freeram;
-      post_mem = post_mem+((unsigned long long)sstats.mem_unit*sstats.freeswap);
-
-      while ((((unsigned long long)pre_mem - post_mem) < (unsigned long long)original_maxbytes) &&
-              (pid_count < pid_cntr) )
-      {
-       sleep(1);
-       sysinfo(&sstats);
-       post_mem = (unsigned long long)sstats.mem_unit*sstats.freeram;
-       post_mem = post_mem+((unsigned long long)sstats.mem_unit*sstats.freeswap);
-      }
+        bytecount = chunksize;
+        while (1) 
+        {
+            if ((mem = malloc(chunksize)) == NULL) 
+            {
+                tst_resm(TBROK|TERRNO, "stopped at %lu bytes", bytecount);
+                free(pid_list);
+                exit(1);
+            }
+            if (dowrite)
+                for (j = 0; j < chunksize; j++)
+                    *(mem+j) = 'a';
+            if (verbose)
+                tst_resm(TINFO, "allocated %lu bytes chunksize is %d", bytecount, chunksize);
+            bytecount += chunksize;
+            if (alloc_bytes && bytecount >= alloc_bytes)
+                break;
+        }
+        if (dowrite)
+            tst_resm(TINFO, "... %lu bytes allocated and used.", bytecount);
+        else
+            tst_resm(TINFO, "... %lu bytes allocated only.", bytecount);
+        kill(getppid(), SIGRTMIN);
+        while (1)
+            sleep(1);
     }
-    while (pid_list[i]!=0)
+    else                  /** PARENT **/
     {
-      kill(pid_list[i],SIGKILL);
-      i++;
+        i = 0;
+        sysinfo(&sstats);
+        
+        if (dowrite) 
+        {
+            /* Total Free Post-Test RAM */
+            post_mem = (unsigned long long)sstats.mem_unit * sstats.freeram;
+            post_mem = post_mem + (unsigned long long)sstats.mem_unit * sstats.freeswap;
+
+            while ((((unsigned long long)pre_mem - post_mem) < (unsigned long long)original_maxbytes) &&
+                    (pid_count < pid_cntr))
+            {
+                sleep(1);
+                sysinfo(&sstats);
+                post_mem = (unsigned long long)sstats.mem_unit * sstats.freeram;
+                post_mem = post_mem + (unsigned long long)sstats.mem_unit * sstats.freeswap;
+            }
+        }
+        while (pid_list[i] != 0)
+        {
+            kill(pid_list[i], SIGKILL);
+            i++;
+        }
+        if (dowrite)
+            tst_resm(TPASS, "%llu kbytes allocated and used.", original_maxbytes/1024);
+        else
+            tst_resm(TPASS, "%llu kbytes allocated only.", original_maxbytes/1024);
     }
-    if (dowrite)
-      tst_resm(TPASS, "%llu kbytes allocated and used.", original_maxbytes/1024);
-    else
-      tst_resm(TPASS, "%llu kbytes allocated only.", original_maxbytes/1024);
-  }
-  exit(0);
-}
\ No newline at end of file
+    free(pid_list);
+    exit(0);
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
