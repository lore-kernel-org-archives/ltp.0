Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1O1sAf-0003Qo-Iq
	for ltp-list@lists.sourceforge.net; Wed, 14 Apr 2010 02:17:41 +0000
Received: from out07.sjc.mx.trendmicro.com ([216.99.131.23])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O1sAe-0003EB-2X
	for ltp-list@lists.sourceforge.net; Wed, 14 Apr 2010 02:17:41 +0000
From: "Mitani" <mitani@ryobi.co.jp>
References: <000001cadad6$c061c590$412550b0$@co.jp>
	<4BC487C9.9080300@xenotime.net>
In-Reply-To: <4BC487C9.9080300@xenotime.net>
Date: Wed, 14 Apr 2010 11:17:30 +0900
Message-ID: <000901cadb78$a2d05080$e870f180$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: Re: [LTP] [PATCH] fix "hugetlb" several tests
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
To: 'Randy Dunlap' <rdunlap@xenotime.net>
Cc: ltp-list@lists.sourceforge.net

Hi Randy, 

I couldn't notice a misspelling. Sorry.
I decided to use "due to" according to your advice.

May I suggest revised patch?

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
+		tst_brkm(TCONF, cleanup, "Test cannot be continued due to \
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
+             tst_brkm(TCONF, tst_exit, "Test cannot be continued due to
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
+             tst_brkm(TCONF, tst_exit, "Test cannot be continued due to
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
+             tst_brkm(TCONF, cleanup, "Test cannot be continued due to
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
+             tst_brkm(TCONF, tst_exit, "Test cannot be continued due to
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
+             tst_brkm(TCONF, tst_exit, "Test cannot be continued due to
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
+             tst_brkm(TCONF, cleanup, "Test cannot be continued due to
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
+             tst_brkm(TCONF, tst_exit, "Test cannot be continued due to
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
+             tst_brkm(TCONF, cleanup, "Test cannot be continued due to
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
+             tst_brkm(TCONF, tst_exit, "Test cannot be continued due to
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
+             tst_brkm(TCONF, tst_exit, "Test cannot be continued due to
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
+             tst_brkm(TCONF, cleanup, "Test cannot be continued due to
sufficient availability of Hugepages on the system");
         else             
              huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() *
hugepages_size() * 1024) / 2 ;
        
============


Thank you--

-Tomonori Mitani


> -----Original Message-----
> From: Randy Dunlap [mailto:rdunlap@xenotime.net]
> Sent: Wednesday, April 14, 2010 12:04 AM
> To: Mitani
> Cc: ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] [PATCH] fix "hugetlb" several tests
> 
> On 04/12/10 23:58, Mitani wrote:
> > ------------
> >  a) All tests:
> > "TBROK  :  Test cannot be continued owning to sufficient
> availability of
> > Hugepages on the system"
> >
> >  b) 2), 3), 5), 6), 8), 10), 11) tests:
> > "TWARN  :  tst_rmdir(): TESTDIR was NULL; no removal attempted"
> > ------------
> >
> > Both case a) and case b) are caused by the same reason.
> >
> > All of case a) failures occured at the following points (for example
> > hugemmap04):
> > ------------<hugemmap04.c - main()>
> >         /* Check number of hugepages */
> >         if (get_no_of_hugepages() <= 0 || hugepages_size() <= 0)
> >                 tst_brkm(TBROK, cleanup, "Test cannot be continued
> owning to
> > \
> >                                 sufficient availability of
> Hugepages on the
> > system");
> > ------------
> >
> > I found out that "HugePages_Total" parameter of "/proc/meminfo" file
> > is set to "0". This caused above TBROK failure. It is environment
> problem.
> >
> > But, in this case, tests must not return with TBROK, but with TCONF,
> > I think.
> 
> That makes sense to me.
> 
> > And, in case b), these tests try to delete "TESTDIR" directory by
> > calling "tst_rmdir()" function in "cleanup()" function.
> > But, "TESTDIR" never set if "tst_tmpdir()" function isn't called.
> > I think that case b)'s tests must not call cleanup() function.
> >
> >
> > I want to suggest following patch.
> >
> > Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>
> >
> > ============
> > --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
> 	2010-04-01
> > 15:23:09.000000000 +0900
> > +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
> 	2010-04-13
> > 11:23:33.000000000 +0900
> > @@ -127,7 +127,7 @@
> >
> >  	/* Check number of hugepages */
> >  	if (get_no_of_hugepages() <= 0 || hugepages_size() <= 0)
> > -		tst_brkm(TBROK, cleanup, "Test cannot be continued
> owning to
> > \
> > +		tst_brkm(TCONF, cleanup, "Test cannot be continued
> owning to
> > \
> >  				sufficient availability of Hugepages
> on the
> > system");
> >
> >  	/* Perform global setup for test */
> 
> Not caused by your patch, but all of those "owning to" should be "owing
> to"
> or even better, "due to".
> 
> --
> ~Randy



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
