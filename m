Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1QCo56-0003KQ-F8
	for ltp-list@lists.sourceforge.net; Thu, 21 Apr 2011 07:13:40 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1QCo53-0007b7-GS
	for ltp-list@lists.sourceforge.net; Thu, 21 Apr 2011 07:13:38 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p3L7DVLp013949
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 21 Apr 2011 03:13:31 -0400
From: Caspar Zhang <czhang@redhat.com>
Date: Thu, 21 Apr 2011 15:13:16 +0800
Message-Id: <ebbbe0dead0a401286ecede63f3e8dbe03f29e18.1303369524.git.czhang@redhat.com>
In-Reply-To: <3b1be0379ad68fd9c06480b7b5cf2f9c1e9b2529.1303369524.git.czhang@redhat.com>
References: <czhang@redhat.com>
	<1303369996-4812-1-git-send-email-czhang@redhat.com>
	<3b1be0379ad68fd9c06480b7b5cf2f9c1e9b2529.1303369524.git.czhang@redhat.com>
In-Reply-To: <3b1be0379ad68fd9c06480b7b5cf2f9c1e9b2529.1303369524.git.czhang@redhat.com>
References: <3b1be0379ad68fd9c06480b7b5cf2f9c1e9b2529.1303369524.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.1"
Subject: [LTP] [PATCH 2/2] hugemmap: use common header files
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


there are some hugetlb related functions in
$(topdir)/include/system_specific_hugepages_info.h, this patch makes the
hugemmap tests use this common header so that codes can be simpler and
less overlaps.

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c |   65 +------------------
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c |   18 +++---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c |   18 +++---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c |   64 +------------------
 4 files changed, 26 insertions(+), 139 deletions(-)


--------------1.7.1
Content-Type: text/x-patch; name="0002-hugemmap-use-common-header-files.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0002-hugemmap-use-common-header-files.patch"

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
index 4b2cd30..874f736 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
@@ -72,6 +72,7 @@
 
 #include "test.h"
 #include "usctest.h"
+#include "system_specific_hugepages_info.h"
 
 #define BUFFER_SIZE  256
 
@@ -87,8 +88,6 @@ int aftertest=0;		/* Amount of free huge pages after testing */
 int hugepagesmapped=0;		/* Amount of huge pages mapped after testing */
 
 void setup();			/* Main setup function of test */
-int getfreehugepages();		/* Reads free huge pages */
-int get_huge_pagesize();        /* Reads huge page size */
 void cleanup();			/* cleanup function for the test */
 
 void help()
@@ -135,10 +134,10 @@ main(int ac, char **av)
 		Tst_count=0;
 
 		/* Note the number of free huge pages BEFORE testing */
-		beforetest = getfreehugepages();
+		beforetest = get_no_of_free_hugepages();
 
 		/* Note the size of huge page size BEFORE testing */
-		page_sz = get_huge_pagesize();
+		page_sz = hugepages_size();
 
 		/*
 		 * Call mmap
@@ -160,7 +159,7 @@ main(int ac, char **av)
 		}
 
 		/* Make sure the number of free huge pages AFTER testing decreased */
-		aftertest = getfreehugepages();
+		aftertest = get_no_of_free_hugepages();
 		hugepagesmapped = beforetest - aftertest;
 		if (hugepagesmapped < 1) {
 			tst_resm(TWARN,"Number of HUGEPAGES_FREE stayed the same. Okay if");
@@ -205,62 +204,6 @@ setup()
 }
 
 /*
- * getfreehugepages() - Reads the number of free huge pages from /proc/meminfo
- */
-int
-getfreehugepages()
-{
-	int hugefree;
-	FILE* f;
-	int retcode=0;
-	char buff[BUFFER_SIZE];
-
-        f = fopen("/proc/meminfo", "r");
-	if (!f)
-     		tst_brkm(TFAIL, cleanup, "Could not open /proc/meminfo for reading");
-
-	while (fgets(buff,BUFFER_SIZE, f) != NULL) {
-		if ((retcode = sscanf(buff, "HugePages_Free: %d ", &hugefree)) == 1)
-	  		break;
-	}
-
-        if (retcode != 1) {
-        	fclose(f);
-       		tst_brkm(TFAIL, cleanup, "Failed reading number of huge pages free.");
-     	}
-	fclose(f);
-	return(hugefree);
-}
-
-/*
- * get_huge_pagesize() - Reads the size of huge page size from /proc/meminfo
- */
-int
-get_huge_pagesize()
-{
-        int hugesize;
-        FILE* f;
-        int retcode=0;
-        char buff[BUFFER_SIZE];
-
-        f = fopen("/proc/meminfo", "r");
-        if (!f)
-                tst_brkm(TFAIL, cleanup, "Could not open /proc/meminfo for reading");
-
-        while (fgets(buff,BUFFER_SIZE, f) != NULL) {
-                if ((retcode = sscanf(buff, "Hugepagesize: %d ", &hugesize)) == 1)
-                        break;
-        }
-
-        if (retcode != 1) {
-                fclose(f);
-                tst_brkm(TFAIL, cleanup, "Failed reading size of huge page.");
-        }
-        fclose(f);
-        return(hugesize);
-}
-
-/*
  * cleanup() - performs all ONE TIME cleanup for this test at
  *             completion or premature exit.
  * 	       Remove the temporary directory created.
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
index ce4cdac..45cddf7 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
@@ -62,10 +62,8 @@
 
 #include "test.h"
 #include "usctest.h"
+#include "system_specific_hugepages_info.h"
 
-#define PAGE_SIZE      ((1UL) << 12) 	/* Normal page size */
-#define HPAGE_SIZE     ((1UL) << 24) 	/* Huge page size */
-#define MAP_SIZE       (2*HPAGE_SIZE) 	/* Huge map page size */
 #define LOW_ADDR       (void *)(0x80000000)
 #define LOW_ADDR2      (void *)(0x90000000)
 
@@ -95,6 +93,7 @@ main(int ac, char **av)
 	int lc;
 	char *msg;
         int Hflag = 0;
+	int page_sz, map_sz;
 
        	option_t options[] = {
         	{ "H:",   &Hflag, &Hopt },    /* Required for location of hugetlbfs */
@@ -110,6 +109,9 @@ main(int ac, char **av)
 		    "-H option is REQUIRED for this test, use -h for options help");
 	}
 
+	page_sz = getpagesize();
+	map_sz = 2 * 1024 * hugepages_size();
+
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
@@ -138,14 +140,14 @@ main(int ac, char **av)
 
 		/* mmap using normal pages and a low memory address */
 		errno = 0;
-		addr = mmap(LOW_ADDR, PAGE_SIZE, PROT_READ,
+		addr = mmap(LOW_ADDR, page_sz, PROT_READ,
 			    MAP_SHARED | MAP_FIXED, nfildes, 0);
 		if (addr == MAP_FAILED)
 			tst_brkm(TBROK, cleanup,"mmap failed on nfildes");
 
 		/* Attempt to mmap a huge page into a low memory address */
 		errno = 0;
-		addr2 = mmap(LOW_ADDR2, MAP_SIZE, PROT_READ | PROT_WRITE,
+		addr2 = mmap(LOW_ADDR2, map_sz, PROT_READ | PROT_WRITE,
 			    MAP_SHARED, fildes, 0);
 
 #if __WORDSIZE == 64 /* 64-bit process */
@@ -177,11 +179,11 @@ main(int ac, char **av)
         	}
 
 #if __WORDSIZE == 64
-		if (munmap(addr2, MAP_SIZE) == -1) {
+		if (munmap(addr2, map_sz) == -1) {
 			tst_brkm(TFAIL|TERRNO, NULL, "huge munmap failed");
 		}
 #endif
-		if (munmap(addr, PAGE_SIZE) == -1) {
+		if (munmap(addr, page_sz) == -1) {
 			tst_brkm(TFAIL|TERRNO, NULL, "munmap failed");
 		}
 
@@ -231,4 +233,4 @@ cleanup()
 	unlink(TEMPFILE);
 
 	tst_rmdir();
-}
\ No newline at end of file
+}
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c
index c1479fe..cac94b0 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c
@@ -53,8 +53,8 @@
 
 #include "test.h"
 #include "usctest.h"
+#include "system_specific_hugepages_info.h"
 
-#define PAGE_SIZE      ((1UL) << 12) 	/* Normal page size */
 #define HIGH_ADDR      (void *)(0x1000000000000)
 
 char* TEMPFILE="mmapfile";
@@ -76,15 +76,14 @@ void help()
 int
 main(int ac, char **av)
 {
-#if __WORDSIZE==32  /* 32-bit compiled */
-      	tst_resm(TCONF,"This test is only for 64bit");
-	tst_exit();
-
-       	return 1;
-#else	/* 64-bit compiled */
 	int lc;			/* loop counter */
 	char *msg;		/* message returned from parse_opts */
         int Hflag=0;              /* binary flag: opt or not */
+	int page_sz;
+
+#if __WORDSIZE==32  /* 32-bit compiled */
+	tst_brkm(TCONF, NULL, "This test is only for 64bit");
+#endif
 
        	option_t options[] = {
         	{ "H:",   &Hflag, &Hopt },    /* Required for location of hugetlbfs */
@@ -103,6 +102,8 @@ main(int ac, char **av)
 		tst_exit();
 	}
 
+	page_sz = getpagesize();
+
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
@@ -118,7 +119,7 @@ main(int ac, char **av)
 
 		/* Attempt to mmap using normal pages and a high memory address */
 		errno = 0;
-		addr = mmap(HIGH_ADDR, PAGE_SIZE, PROT_READ,
+		addr = mmap(HIGH_ADDR, page_sz, PROT_READ,
 			    MAP_SHARED | MAP_FIXED, fildes, 0);
 		if (addr != MAP_FAILED) {
 			tst_resm(TFAIL, "Normal mmap() into high region unexpectedly succeeded on %s, errno=%d : %s",
@@ -135,7 +136,6 @@ main(int ac, char **av)
 	cleanup();
 
 	tst_exit();
-#endif
 }
 
 /*
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
index b6c6988..4cc6ed4 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
@@ -90,8 +90,6 @@ int hugepagesmapped=0;		/* Amount of huge pages mapped after testing */
 char *Hopt;                     /* location of hugetlbfs */
 
 void setup();			/* Main setup function of test */
-int getfreehugepages();		/* Reads free huge pages */
-int get_huge_pagesize();        /* Reads huge page size */
 void cleanup();			/* cleanup function for the test */
 
 void help()
@@ -142,11 +140,11 @@ main(int ac, char **av)
 		Tst_count=0;
 
 		/* Note the number of free huge pages BEFORE testing */
-		freepages = getfreehugepages();
+		freepages = get_no_of_free_hugepages();
 		beforetest = freepages;
 
 		/* Note the size of huge page size BEFORE testing */
-		huge_pagesize = get_huge_pagesize();
+		huge_pagesize = hugepages_size();
 		tst_resm(TINFO,"Size of huge pages is %d KB",huge_pagesize);
 
 #if __WORDSIZE==32
@@ -176,7 +174,7 @@ main(int ac, char **av)
 		}
 
 		/* Make sure the number of free huge pages AFTER testing decreased */
-		aftertest = getfreehugepages();
+		aftertest = get_no_of_free_hugepages();
 		hugepagesmapped = beforetest - aftertest;
 		if (hugepagesmapped < 1) {
 			tst_resm(TWARN,"Number of HUGEPAGES_FREE stayed the same. Okay if");
@@ -221,62 +219,6 @@ setup()
 }
 
 /*
- * getfreehugepages() - Reads the number of free huge pages from /proc/meminfo
- */
-int
-getfreehugepages()
-{
-	int hugefree;
-	FILE* f;
-	int retcode=0;
-	char buff[BUFFER_SIZE];
-
-        f = fopen("/proc/meminfo", "r");
-	if (!f)
-     		tst_brkm(TFAIL, cleanup, "Could not open /proc/meminfo for reading");
-
-	while (fgets(buff,BUFFER_SIZE, f) != NULL) {
-		if ((retcode = sscanf(buff, "HugePages_Free: %d ", &hugefree)) == 1)
-			break;
-	}
-
-        if (retcode != 1) {
-        	fclose(f);
-       		tst_brkm(TFAIL, cleanup, "Failed reading number of huge pages free.");
-     	}
-	fclose(f);
-	return(hugefree);
-}
-
-/*
- * get_huge_pagesize() - Reads the size of huge page size from /proc/meminfo
-*/
-int
-get_huge_pagesize()
-{
-	int hugesize;
-	FILE* f;
-	int retcode=0;
-	char buff[BUFFER_SIZE];
-
-        f = fopen("/proc/meminfo", "r");
-	if (!f)
-     		tst_brkm(TFAIL, cleanup, "Could not open /proc/meminfo for reading");
-
-	while (fgets(buff,BUFFER_SIZE, f) != NULL) {
-		if ((retcode = sscanf(buff, "Hugepagesize: %d ", &hugesize)) == 1)
-			break;
-	}
-
-        if (retcode != 1) {
-        	fclose(f);
-       		tst_brkm(TFAIL, cleanup, "Failed reading size of huge page.");
-     	}
-	fclose(f);
-	return(hugesize);
-}
-
-/*
  * cleanup() - performs all ONE TIME cleanup for this test at
  *             completion or premature exit.
  * 	       Remove the temporary directory created.

--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Benefiting from Server Virtualization: Beyond Initial Workload 
Consolidation -- Increasing the use of server virtualization is a top
priority.Virtualization can reduce costs, simplify management, and improve 
application availability and disaster protection. Learn more about boosting 
the value of server virtualization. http://p.sf.net/sfu/vmware-sfdev2dev
--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.1--



