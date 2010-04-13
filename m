Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1O1a5E-000777-Sk
	for ltp-list@lists.sourceforge.net; Tue, 13 Apr 2010 06:58:52 +0000
Received: from out01.sjc.mx.trendmicro.com ([216.99.131.5])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O1a5D-00053V-5S
	for ltp-list@lists.sourceforge.net; Tue, 13 Apr 2010 06:58:52 +0000
Received: from relay01.sjc.mx.trendmicro.com (unknown [10.30.239.5])
	by out01.sjc.mx.trendmicro.com (Postfix) with ESMTP id 07E0D239C22
	for <ltp-list@lists.sourceforge.net>;
	Tue, 13 Apr 2010 06:58:45 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay01.sjc.mx.trendmicro.com (Postfix) with ESMTP id 090F6114B837
	for <ltp-list@lists.sourceforge.net>;
	Tue, 13 Apr 2010 06:58:43 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Apr 2010 15:58:41 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Tue, 13 Apr 2010 15:58:41 +0900
Message-ID: <000001cadad6$c061c590$412550b0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] [PATCH] fix "hugetlb" several tests
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

I tried "hugemmap", "hugeshmat", "hugeshmctl", "hugeshmdt" and 
"hugeshmget" tests.
And I found several fails in them:
------------<at "${LTPROOT}/testcases/kernel/mem/hugetlb/" directory>
 - ./hugemmap/
   1) hugemmap04   : return code = 2
  
 - ./hugeshmat/
   2) hugeshmat01  : return code = 6
   3) hugeshmat02  : return code = 6
   4) hugeshmat03  : return code = 2
  
 - ./hugeshmctl/
   5) hugeshmctl01 : return code = 6
   6) hugeshmctl02 : return code = 6
   7) hugeshmctl03 : return code = 2
  
 - ./hugeshmdt/
   8) hugeshmdt01  : return code = 6
  
 - ./hugeshmget/
   9) hugeshmget01 : return code = 2
  10) hugeshmget02 : return code = 6
  11) hugeshmget03 : return code = 6
  12) hugeshmget05 : return code = 2
------------

These tests output following messages:
------------
 a) All tests:
"TBROK  :  Test cannot be continued owning to sufficient availability of
Hugepages on the system"

 b) 2), 3), 5), 6), 8), 10), 11) tests:
"TWARN  :  tst_rmdir(): TESTDIR was NULL; no removal attempted"
------------

Both case a) and case b) are caused by the same reason.

All of case a) failures occured at the following points (for example 
hugemmap04):
------------<hugemmap04.c - main()>
        /* Check number of hugepages */
        if (get_no_of_hugepages() <= 0 || hugepages_size() <= 0)
                tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
\
                                sufficient availability of Hugepages on the
system");
------------

I found out that "HugePages_Total" parameter of "/proc/meminfo" file 
is set to "0". This caused above TBROK failure. It is environment problem.

But, in this case, tests must not return with TBROK, but with TCONF, 
I think.

And, in case b), these tests try to delete "TESTDIR" directory by 
calling "tst_rmdir()" function in "cleanup()" function.
But, "TESTDIR" never set if "tst_tmpdir()" function isn't called.
I think that case b)'s tests must not call cleanup() function.


I want to suggest following patch.

Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>

============
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c	2010-04-01
15:23:09.000000000 +0900
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c	2010-04-13
11:23:33.000000000 +0900
@@ -127,7 +127,7 @@
 
 	/* Check number of hugepages */
 	if (get_no_of_hugepages() <= 0 || hugepages_size() <= 0)
-		tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
\
+		tst_brkm(TCONF, cleanup, "Test cannot be continued owning to
\
 				sufficient availability of Hugepages on the
system");
 
 	/* Perform global setup for test */
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c	2010-04-01
15:23:09.000000000 +0900
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c	2010-04-13
11:36:25.000000000 +0900
@@ -105,7 +105,7 @@
 	}
 
         if ( get_no_of_hugepages() <= 0 || hugepages_size() <= 0 )
-             tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
sufficient availability of Hugepages on the system");
+             tst_brkm(TCONF, tst_exit, "Test cannot be continued owning to
sufficient availability of Hugepages on the system");
         else             
              huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() *
hugepages_size() * 1024) / 2 ;
 
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c	2010-04-01
15:23:09.000000000 +0900
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c	2010-04-13
11:37:41.000000000 +0900
@@ -102,7 +102,7 @@
 	}
 
         if ( get_no_of_hugepages() <= 0 || hugepages_size() <= 0 )
-             tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
sufficient availability of Hugepages on the system");
+             tst_brkm(TCONF, tst_exit, "Test cannot be continued owning to
sufficient availability of Hugepages on the system");
         else             
              huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() *
hugepages_size() * 1024) / 2 ;
 
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c	2010-04-01
15:23:09.000000000 +0900
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c	2010-04-13
11:38:16.000000000 +0900
@@ -86,7 +86,7 @@
 	}
 
         if ( get_no_of_hugepages() <= 0 || hugepages_size() <= 0 )
-             tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
sufficient availability of Hugepages on the system");
+             tst_brkm(TCONF, cleanup, "Test cannot be continued owning to
sufficient availability of Hugepages on the system");
         else             
              huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() *
hugepages_size() * 1024) / 2 ;
 
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c	2010-04-01
15:23:09.000000000 +0900
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c	2010-04-13
11:41:23.000000000 +0900
@@ -130,7 +130,7 @@
 	}
 
         if ( get_no_of_hugepages() <= 0 || hugepages_size() <= 0 )
-             tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
sufficient availability of Hugepages on the system");
+             tst_brkm(TCONF, tst_exit, "Test cannot be continued owning to
sufficient availability of Hugepages on the system");
         else             
              huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() *
hugepages_size() * 1024) / 2 ;
 
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c	2010-04-01
15:23:09.000000000 +0900
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c	2010-04-13
11:41:48.000000000 +0900
@@ -102,7 +102,7 @@
 	}
 
         if ( get_no_of_hugepages() <= 0 || hugepages_size() <= 0 )
-             tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
sufficient availability of Hugepages on the system");
+             tst_brkm(TCONF, tst_exit, "Test cannot be continued owning to
sufficient availability of Hugepages on the system");
         else             
              huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() *
hugepages_size() * 1024) / 2 ;
 
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c	2010-04-01
15:23:09.000000000 +0900
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c	2010-04-13
11:42:10.000000000 +0900
@@ -105,7 +105,7 @@
 	}
 
         if ( get_no_of_hugepages() <= 0 || hugepages_size() <= 0 )
-             tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
sufficient availability of Hugepages on the system");
+             tst_brkm(TCONF, cleanup, "Test cannot be continued owning to
sufficient availability of Hugepages on the system");
         else             
              huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() *
hugepages_size() * 1024) / 2 ;
 
--- a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c	2010-04-01
15:23:09.000000000 +0900
+++ b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c	2010-04-13
11:42:55.000000000 +0900
@@ -87,7 +87,7 @@
 	}
 
         if ( get_no_of_hugepages() <= 0 || hugepages_size() <= 0 )
-             tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
sufficient availability of Hugepages on the system");
+             tst_brkm(TCONF, tst_exit, "Test cannot be continued owning to
sufficient availability of Hugepages on the system");
         else             
              huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() *
hugepages_size() * 1024) / 2 ;
 
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c	2010-04-01
15:23:09.000000000 +0900
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c	2010-04-13
11:43:30.000000000 +0900
@@ -82,7 +82,7 @@
 
 	/* The following loop checks looping state if -i option given */
         if ( get_no_of_hugepages() <= 0 || hugepages_size() <= 0 )
-             tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
sufficient availability of Hugepages on the system");
+             tst_brkm(TCONF, cleanup, "Test cannot be continued owning to
sufficient availability of Hugepages on the system");
         else             
               huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() *
hugepages_size() * 1024) / 2 ;
         
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c	2010-04-01
15:23:09.000000000 +0900
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c	2010-04-13
11:43:51.000000000 +0900
@@ -84,7 +84,7 @@
 	}
 
         if ( get_no_of_hugepages() <= 0 || hugepages_size() <= 0 )
-             tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
sufficient availability of Hugepages on the system");
+             tst_brkm(TCONF, tst_exit, "Test cannot be continued owning to
sufficient availability of Hugepages on the system");
         else             
              huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() *
hugepages_size() * 1024) / 2 ;
   
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c	2010-04-01
15:23:09.000000000 +0900
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c	2010-04-13
11:44:10.000000000 +0900
@@ -85,7 +85,7 @@
 
 	/* The following loop checks looping state if -i option given */
         if ( get_no_of_hugepages() <= 0 || hugepages_size() <= 0 )
-             tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
sufficient availability of Hugepages on the system");
+             tst_brkm(TCONF, tst_exit, "Test cannot be continued owning to
sufficient availability of Hugepages on the system");
         else             
              huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() *
hugepages_size() * 1024) / 2 ;
 
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c	2010-04-01
15:23:09.000000000 +0900
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c	2010-04-13
11:44:29.000000000 +0900
@@ -86,7 +86,7 @@
 	}
 
         if ( get_no_of_hugepages() <= 0 || hugepages_size() <= 0 )
-             tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
sufficient availability of Hugepages on the system");
+             tst_brkm(TCONF, cleanup, "Test cannot be continued owning to
sufficient availability of Hugepages on the system");
         else             
              huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() *
hugepages_size() * 1024) / 2 ;
        
============


Regards--

-Tomonori Mitani



------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
