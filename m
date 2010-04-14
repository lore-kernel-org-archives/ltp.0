Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1O1yQX-0002qn-Ew
	for ltp-list@lists.sourceforge.net; Wed, 14 Apr 2010 08:58:29 +0000
Received: from out01.sjc.mx.trendmicro.com ([216.99.131.5])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O1yQV-0001ef-Hf
	for ltp-list@lists.sourceforge.net; Wed, 14 Apr 2010 08:58:29 +0000
From: "Mitani" <mitani@ryobi.co.jp>
References: <000001cadad6$c061c590$412550b0$@co.jp>	
	<4BC487C9.9080300@xenotime.net>	
	<000901cadb78$a2d05080$e870f180$@co.jp>
	<g2p364299f41004132317v539c2b02g3eea49dc830cea0f@mail.gmail.com>
In-Reply-To: <g2p364299f41004132317v539c2b02g3eea49dc830cea0f@mail.gmail.com>
Date: Wed, 14 Apr 2010 17:58:17 +0900
Message-ID: <000601cadbb0$9fb8b5d0$df2a2170$@co.jp>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: 'Garrett Cooper' <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

> -----Original Message-----
> From: Garrett Cooper [mailto:yanegomi@gmail.com]
> Sent: Wednesday, April 14, 2010 3:18 PM
> To: Mitani
> Cc: Randy Dunlap; ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] [PATCH] fix "hugetlb" several tests
> =

> On Tue, Apr 13, 2010 at 7:17 PM, Mitani <mitani@ryobi.co.jp> wrote:
> > Hi Randy,
> >
> > I couldn't notice a misspelling. Sorry.
> > I decided to use "due to" according to your advice.
> >
> > May I suggest revised patch?
> >
[...]
> >
> > Thank you--
> >
> > -Tomonori Mitani
> >
> >
> >> -----Original Message-----
> >> From: Randy Dunlap [mailto:rdunlap@xenotime.net]
> >> Sent: Wednesday, April 14, 2010 12:04 AM
> >> To: Mitani
> >> Cc: ltp-list@lists.sourceforge.net
> >> Subject: Re: [LTP] [PATCH] fix "hugetlb" several tests
> >>
> >> On 04/12/10 23:58, Mitani wrote:
> >> > ------------
> >> > =A0a) All tests:
> >> > "TBROK =A0: =A0Test cannot be continued owning to sufficient
> >> availability of
> >> > Hugepages on the system"
> >> >
> >> > =A0b) 2), 3), 5), 6), 8), 10), 11) tests:
> >> > "TWARN =A0: =A0tst_rmdir(): TESTDIR was NULL; no removal attempted"
> >> > ------------
> >> >
> >> > Both case a) and case b) are caused by the same reason.
> >> >
> >> > All of case a) failures occured at the following points (for
> example
> >> > hugemmap04):
> >> > ------------<hugemmap04.c - main()>
> >> > =A0 =A0 =A0 =A0 /* Check number of hugepages */
> >> > =A0 =A0 =A0 =A0 if (get_no_of_hugepages() <=3D 0 || hugepages_size()=
 <=3D
> 0)
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK, cleanup, "Test canno=
t be
> continued
> >> owning to
> >> > \
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 suff=
icient availability of
> >> Hugepages on the
> >> > system");
> >> > ------------
> >> >
> >> > I found out that "HugePages_Total" parameter of "/proc/meminfo"
> file
> >> > is set to "0". This caused above TBROK failure. It is environment
> >> problem.
> >> >
> >> > But, in this case, tests must not return with TBROK, but with TCONF,
> >> > I think.
> >>
> >> That makes sense to me.
> >>
> >> > And, in case b), these tests try to delete "TESTDIR" directory
> by
> >> > calling "tst_rmdir()" function in "cleanup()" function.
> >> > But, "TESTDIR" never set if "tst_tmpdir()" function isn't called.
> >> > I think that case b)'s tests must not call cleanup() function.
> >> >
> >> >
> >> > I want to suggest following patch.
> >> >
> >> > Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>
> >> >
> >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> > --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
> >> =A0 =A0 =A0 2010-04-01
> >> > 15:23:09.000000000 +0900
> >> > +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
> >> =A0 =A0 =A0 2010-04-13
> >> > 11:23:33.000000000 +0900
> >> > @@ -127,7 +127,7 @@
> >> >
> >> > =A0 =A0 /* Check number of hugepages */
> >> > =A0 =A0 if (get_no_of_hugepages() <=3D 0 || hugepages_size() <=3D 0)
> >> > - =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK, cleanup, "Test cannot be conti=
nued
> >> owning to
> >> > \
> >> > + =A0 =A0 =A0 =A0 =A0 tst_brkm(TCONF, cleanup, "Test cannot be conti=
nued
> >> owning to
> >> > \
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sufficient a=
vailability of
> Hugepages
> >> on the
> >> > system");
> >> >
> >> > =A0 =A0 /* Perform global setup for test */
> >>
> >> Not caused by your patch, but all of those "owning to" should be
> "owing
> >> to"
> >> or even better, "due to".
> =

>     Sorry... it might have been better to say (more succinctly): "Not
> enough available Hugepages" ?
> Thanks,
> -Garrett


Hi, =


I suggest new patch.

Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c	2010-04-01
15:23:09.000000000 +0900
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c	2010-04-14
16:40:25.000000000 +0900
@@ -127,8 +127,7 @@
 =

 	/* Check number of hugepages */
 	if (get_no_of_hugepages() <=3D 0 || hugepages_size() <=3D 0)
-		tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
\
-				sufficient availability of Hugepages on the
system");
+		tst_brkm(TCONF, cleanup, "Not enough available Hugepages");
 =

 	/* Perform global setup for test */
 	setup();
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c	2010-04-01
15:23:09.000000000 +0900
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c	2010-04-14
16:48:54.000000000 +0900
@@ -105,7 +105,7 @@
 	}
 =

         if ( get_no_of_hugepages() <=3D 0 || hugepages_size() <=3D 0 )
-             tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
sufficient availability of Hugepages on the system");
+             tst_brkm(TCONF, tst_exit, "Not enough available Hugepages");
         else             =

              huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages() *
hugepages_size() * 1024) / 2 ;
 =

--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c	2010-04-01
15:23:09.000000000 +0900
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c	2010-04-14
16:49:15.000000000 +0900
@@ -102,7 +102,7 @@
 	}
 =

         if ( get_no_of_hugepages() <=3D 0 || hugepages_size() <=3D 0 )
-             tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
sufficient availability of Hugepages on the system");
+             tst_brkm(TCONF, tst_exit, "Not enough available Hugepages");
         else             =

              huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages() *
hugepages_size() * 1024) / 2 ;
 =

--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c	2010-04-01
15:23:09.000000000 +0900
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c	2010-04-14
16:49:31.000000000 +0900
@@ -86,7 +86,7 @@
 	}
 =

         if ( get_no_of_hugepages() <=3D 0 || hugepages_size() <=3D 0 )
-             tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
sufficient availability of Hugepages on the system");
+             tst_brkm(TCONF, cleanup, "Not enough available Hugepages");
         else             =

              huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages() *
hugepages_size() * 1024) / 2 ;
 =

--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c	2010-04-01
15:23:09.000000000 +0900
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c	2010-04-14
16:50:16.000000000 +0900
@@ -130,7 +130,7 @@
 	}
 =

         if ( get_no_of_hugepages() <=3D 0 || hugepages_size() <=3D 0 )
-             tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
sufficient availability of Hugepages on the system");
+             tst_brkm(TCONF, tst_exit, "Not enough available Hugepages");
         else             =

              huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages() *
hugepages_size() * 1024) / 2 ;
 =

--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c	2010-04-01
15:23:09.000000000 +0900
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c	2010-04-14
16:50:28.000000000 +0900
@@ -102,7 +102,7 @@
 	}
 =

         if ( get_no_of_hugepages() <=3D 0 || hugepages_size() <=3D 0 )
-             tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
sufficient availability of Hugepages on the system");
+             tst_brkm(TCONF, tst_exit, "Not enough available Hugepages");
         else             =

              huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages() *
hugepages_size() * 1024) / 2 ;
 =

--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c	2010-04-01
15:23:09.000000000 +0900
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c	2010-04-14
16:50:40.000000000 +0900
@@ -105,7 +105,7 @@
 	}
 =

         if ( get_no_of_hugepages() <=3D 0 || hugepages_size() <=3D 0 )
-             tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
sufficient availability of Hugepages on the system");
+             tst_brkm(TCONF, cleanup, "Not enough available Hugepages");
         else             =

              huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages() *
hugepages_size() * 1024) / 2 ;
 =

--- a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c	2010-04-01
15:23:09.000000000 +0900
+++ b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c	2010-04-14
16:51:11.000000000 +0900
@@ -87,7 +87,7 @@
 	}
 =

         if ( get_no_of_hugepages() <=3D 0 || hugepages_size() <=3D 0 )
-             tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
sufficient availability of Hugepages on the system");
+             tst_brkm(TCONF, tst_exit, "Not enough available Hugepages");
         else             =

              huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages() *
hugepages_size() * 1024) / 2 ;
 =

--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c	2010-04-01
15:23:09.000000000 +0900
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c	2010-04-14
16:51:34.000000000 +0900
@@ -82,7 +82,7 @@
 =

 	/* The following loop checks looping state if -i option given */
         if ( get_no_of_hugepages() <=3D 0 || hugepages_size() <=3D 0 )
-             tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
sufficient availability of Hugepages on the system");
+             tst_brkm(TCONF, cleanup, "Not enough available Hugepages");
         else             =

               huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages() *
hugepages_size() * 1024) / 2 ;
         =

--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c	2010-04-01
15:23:09.000000000 +0900
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c	2010-04-14
16:51:45.000000000 +0900
@@ -84,7 +84,7 @@
 	}
 =

         if ( get_no_of_hugepages() <=3D 0 || hugepages_size() <=3D 0 )
-             tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
sufficient availability of Hugepages on the system");
+             tst_brkm(TCONF, tst_exit, "Not enough available Hugepages");
         else             =

              huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages() *
hugepages_size() * 1024) / 2 ;
   =

--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c	2010-04-01
15:23:09.000000000 +0900
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c	2010-04-14
16:51:55.000000000 +0900
@@ -85,7 +85,7 @@
 =

 	/* The following loop checks looping state if -i option given */
         if ( get_no_of_hugepages() <=3D 0 || hugepages_size() <=3D 0 )
-             tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
sufficient availability of Hugepages on the system");
+             tst_brkm(TCONF, tst_exit, "Not enough available Hugepages");
         else             =

              huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages() *
hugepages_size() * 1024) / 2 ;
 =

--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c	2010-04-01
15:23:09.000000000 +0900
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c	2010-04-14
16:52:10.000000000 +0900
@@ -86,7 +86,7 @@
 	}
 =

         if ( get_no_of_hugepages() <=3D 0 || hugepages_size() <=3D 0 )
-             tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
sufficient availability of Hugepages on the system");
+             tst_brkm(TCONF, cleanup, "Not enough available Hugepages");
         else             =

              huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages() *
hugepages_size() * 1024) / 2 ;
        =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


Regards--

-Tomonori Mitani



---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
