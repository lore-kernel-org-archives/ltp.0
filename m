Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1O2FRV-0005aP-MF
	for ltp-list@lists.sourceforge.net; Thu, 15 Apr 2010 03:08:37 +0000
Received: from out05.sjc.mx.trendmicro.com ([216.99.131.18])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O2FRU-0004T8-55
	for ltp-list@lists.sourceforge.net; Thu, 15 Apr 2010 03:08:37 +0000
Received: from out01.sjc.mx.trendmicro.com (unknown [216.99.131.5])
	by out05.sjc.mx.trendmicro.com (Postfix) with ESMTP id E857B39E3ED
	for <ltp-list@lists.sourceforge.net>;
	Thu, 15 Apr 2010 03:02:46 +0000 (UTC)
Message-ID: <003601cadc47$f8724eb0$e956ec10$@co.jp>
From: "Mitani" <mitani@ryobi.co.jp>
Date: Thu, 15 Apr 2010 12:01:40 +0900
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="--=_NextPart_ST_12_01_41_Thursday_April_15_2010_13161"
References: <000301cad6f8$1b9b0c60$52d12520$@co.jp>
	<D30EE9FA-D2B3-4292-9571-BEF87442BD30@gmail.com>
In-Reply-To: <D30EE9FA-D2B3-4292-9571-BEF87442BD30@gmail.com>
Content-Language: ja
Subject: Re: [LTP] [PATCH] fix "eventfd01" test
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
To: 'Garrett Cooper' <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, kamimura@ryobi.co.jp

This is a multi-part message in MIME format.

----=_NextPart_ST_12_01_41_Thursday_April_15_2010_13161
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit


Sorry.
My patch was destroyed by e-mail.
I attach patch for "eventfd01.c" file.


Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>


Regards--

-Tomonori Mitani

> -----Original Message-----
> From: Garrett Cooper [mailto:yanegomi@gmail.com]
> Sent: Friday, April 09, 2010 2:35 AM
> To: Mitani
> Cc: <ltp-list@lists.sourceforge.net>
> Subject: Re: [LTP] [PATCH] fix "eventfd01" test
> 
> On Apr 8, 2010, at 1:47 AM, "Mitani" <mitani@ryobi.co.jp> wrote:
> 
> > Hi,
> >
> >
> > I tried "eventfd01" test in my system.
> > This test failed with TWARN (return code:4) :
> >
> > ------------
> >  eventfd01    1  TCONF  :  2.6.22 or greater kernel required
> >  eventfd01    2  TCONF  :  Remaining cases not appropriate for
> > configuration
> >  eventfd01    3  TCONF  :  Remaining cases not appropriate for
> > configuration
> >  eventfd01    4  TCONF  :  Remaining cases not appropriate for
> > configuration
> >  eventfd01    5  TCONF  :  Remaining cases not appropriate for
> > configuration
> >  eventfd01    6  TCONF  :  Remaining cases not appropriate for
> > configuration
> >  eventfd01    7  TCONF  :  Remaining cases not appropriate for
> > configuration
> >  eventfd01    8  TCONF  :  Remaining cases not appropriate for
> > configuration
> >  eventfd01    9  TCONF  :  Remaining cases not appropriate for
> > configuration
> >  eventfd01   10  TCONF  :  Remaining cases not appropriate for
> > configuration
> >  eventfd01   11  TCONF  :  Remaining cases not appropriate for
> > configuration
> >  eventfd01   12  TCONF  :  Remaining cases not appropriate for
> > configuration
> >  eventfd01   13  TCONF  :  Remaining cases not appropriate for
> > configuration
> >  eventfd01   14  TCONF  :  Remaining cases not appropriate for
> > configuration
> >  eventfd01   15  TCONF  :  Remaining cases not appropriate for
> > configuration
> >  eventfd01    0  TWARN  :  tst_rmdir(): TESTDIR was NULL; no
> removal
> > attempted
> > ------------
> >
> > My system's kernel level is 2.6.18-164.el5
> > Therefore this test rejected:
> >
> > ------< eventfd01.c - main() >------
> >        if (tst_kvercmp(2, 6, 22) < 0)
> >                tst_brkm(TCONF, cleanup, "2.6.22 or greater kernel
> > required");
> > ------------
> >
> > But, this "tst_brkm()" called "cleanup()".
> > "tst_rmdir()" is called in "cleanup()", and this checked "TESTDIR":
> >
> > ------< tst_tmpdir.c - tst_rmdir() >------
> >   /*
> >    * Check that TESTDIR is not NULL.
> >    */
> >   if ( TESTDIR == NULL ) {
> >      tst_resm(TWARN, "%s: TESTDIR was NULL; no removal attempted",
> >               FN_NAME);
> >      return;
> >   }
> > ------------
> >
> > This TWARN caused FAIL.
> > "TESTDIR" is NULL because the test didn't start.
> >
> > I think that "cleanup()" doesn't have to be called in this case.
> >
> >
> > Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>
> >
> > ============
> > --- a/testcases/kernel/syscalls/eventfd/eventfd01.c
> 2010-04-01
> > 15:23:10.000000000 +0900
> > +++ b/testcases/kernel/syscalls/eventfd/eventfd01.c
> 2010-04-08
> > 17:16:35.000000000 +0900
> > @@ -728,8 +728,10 @@
> >        /* capture signals */
> >        tst_sig(FORK, DEF_HANDLER, cleanup);
> >
> > -       if (tst_kvercmp(2, 6, 22) < 0)
> > -               tst_brkm(TCONF, cleanup, "2.6.22 or greater kernel
> > required");
> > +       if (tst_kvercmp(2, 6, 22) < 0) {
> > +               tst_brkm(TCONF, NULL, "2.6.22 or greater kernel
> > required");
> > +               tst_exit();
> > +       }
> >
> >        /* Create a temporary directory & chdir there */
> >        tst_tmpdir();
> > ============
> 
> Try tst_exit instead of NULL.
> Cheers,
> -Garrett

----=_NextPart_ST_12_01_41_Thursday_April_15_2010_13161
Content-Type: application/octet-stream;
	name="eventfd01.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="eventfd01.patch"

--- a/testcases/kernel/syscalls/eventfd/eventfd01.c=092010-04-01 15:23:10.0=
00000000 +0900=0A+++ b/testcases/kernel/syscalls/eventfd/eventfd01.c=092010=
-04-09 09:06:48.000000000 +0900=0A@@ -729,7 +729,7 @@=0A =09tst_sig(FORK, D=
EF_HANDLER, cleanup);=0A =0A =09if (tst_kvercmp(2, 6, 22) < 0)=0A-=09=09tst=
_brkm(TCONF, cleanup, "2.6.22 or greater kernel required");=0A+=09=09tst_br=
km(TCONF, tst_exit, "2.6.22 or greater kernel required");=0A =0A =09/* Crea=
te a temporary directory & chdir there */=0A =09tst_tmpdir();=0A
----=_NextPart_ST_12_01_41_Thursday_April_15_2010_13161
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
----=_NextPart_ST_12_01_41_Thursday_April_15_2010_13161
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

----=_NextPart_ST_12_01_41_Thursday_April_15_2010_13161--

