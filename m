Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1O2IwA-0005KZ-BV
	for ltp-list@lists.sourceforge.net; Thu, 15 Apr 2010 06:52:30 +0000
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O2Iw9-000136-17
	for ltp-list@lists.sourceforge.net; Thu, 15 Apr 2010 06:52:30 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o3F6nIg1022942
	for <ltp-list@lists.sourceforge.net>; Thu, 15 Apr 2010 00:49:18 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3F6qGr4126452
	for <ltp-list@lists.sourceforge.net>; Thu, 15 Apr 2010 00:52:16 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o3F6qFJl006979
	for <ltp-list@lists.sourceforge.net>; Thu, 15 Apr 2010 00:52:15 -0600
Date: Thu, 15 Apr 2010 12:22:13 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100415065213.GC4557@linux.vnet.ibm.com>
References: <000301cad6f8$1b9b0c60$52d12520$@co.jp>
	<D30EE9FA-D2B3-4292-9571-BEF87442BD30@gmail.com>
	<003601cadc47$f8724eb0$e956ec10$@co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <003601cadc47$f8724eb0$e956ec10$@co.jp>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net, kamimura@ryobi.co.jp

On Thu, Apr 15, 2010 at 12:01:40PM +0900, Mitani wrote:
> 
> Sorry.
> My patch was destroyed by e-mail.
> I attach patch for "eventfd01.c" file.

Applied to next branch. Will wait for someone to Acked/test it before merging to 
master.

Thanks
-Rishi

> 
> 
> Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>
> 
> 
> Regards--
> 
> -Tomonori Mitani
> 
> > -----Original Message-----
> > From: Garrett Cooper [mailto:yanegomi@gmail.com]
> > Sent: Friday, April 09, 2010 2:35 AM
> > To: Mitani
> > Cc: <ltp-list@lists.sourceforge.net>
> > Subject: Re: [LTP] [PATCH] fix "eventfd01" test
> > 
> > On Apr 8, 2010, at 1:47 AM, "Mitani" <mitani@ryobi.co.jp> wrote:
> > 
> > > Hi,
> > >
> > >
> > > I tried "eventfd01" test in my system.
> > > This test failed with TWARN (return code:4) :
> > >
> > > ------------
> > >  eventfd01    1  TCONF  :  2.6.22 or greater kernel required
> > >  eventfd01    2  TCONF  :  Remaining cases not appropriate for
> > > configuration
> > >  eventfd01    3  TCONF  :  Remaining cases not appropriate for
> > > configuration
> > >  eventfd01    4  TCONF  :  Remaining cases not appropriate for
> > > configuration
> > >  eventfd01    5  TCONF  :  Remaining cases not appropriate for
> > > configuration
> > >  eventfd01    6  TCONF  :  Remaining cases not appropriate for
> > > configuration
> > >  eventfd01    7  TCONF  :  Remaining cases not appropriate for
> > > configuration
> > >  eventfd01    8  TCONF  :  Remaining cases not appropriate for
> > > configuration
> > >  eventfd01    9  TCONF  :  Remaining cases not appropriate for
> > > configuration
> > >  eventfd01   10  TCONF  :  Remaining cases not appropriate for
> > > configuration
> > >  eventfd01   11  TCONF  :  Remaining cases not appropriate for
> > > configuration
> > >  eventfd01   12  TCONF  :  Remaining cases not appropriate for
> > > configuration
> > >  eventfd01   13  TCONF  :  Remaining cases not appropriate for
> > > configuration
> > >  eventfd01   14  TCONF  :  Remaining cases not appropriate for
> > > configuration
> > >  eventfd01   15  TCONF  :  Remaining cases not appropriate for
> > > configuration
> > >  eventfd01    0  TWARN  :  tst_rmdir(): TESTDIR was NULL; no
> > removal
> > > attempted
> > > ------------
> > >
> > > My system's kernel level is 2.6.18-164.el5
> > > Therefore this test rejected:
> > >
> > > ------< eventfd01.c - main() >------
> > >        if (tst_kvercmp(2, 6, 22) < 0)
> > >                tst_brkm(TCONF, cleanup, "2.6.22 or greater kernel
> > > required");
> > > ------------
> > >
> > > But, this "tst_brkm()" called "cleanup()".
> > > "tst_rmdir()" is called in "cleanup()", and this checked "TESTDIR":
> > >
> > > ------< tst_tmpdir.c - tst_rmdir() >------
> > >   /*
> > >    * Check that TESTDIR is not NULL.
> > >    */
> > >   if ( TESTDIR == NULL ) {
> > >      tst_resm(TWARN, "%s: TESTDIR was NULL; no removal attempted",
> > >               FN_NAME);
> > >      return;
> > >   }
> > > ------------
> > >
> > > This TWARN caused FAIL.
> > > "TESTDIR" is NULL because the test didn't start.
> > >
> > > I think that "cleanup()" doesn't have to be called in this case.
> > >
> > >
> > > Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>
> > >
> > > ============
> > > --- a/testcases/kernel/syscalls/eventfd/eventfd01.c
> > 2010-04-01
> > > 15:23:10.000000000 +0900
> > > +++ b/testcases/kernel/syscalls/eventfd/eventfd01.c
> > 2010-04-08
> > > 17:16:35.000000000 +0900
> > > @@ -728,8 +728,10 @@
> > >        /* capture signals */
> > >        tst_sig(FORK, DEF_HANDLER, cleanup);
> > >
> > > -       if (tst_kvercmp(2, 6, 22) < 0)
> > > -               tst_brkm(TCONF, cleanup, "2.6.22 or greater kernel
> > > required");
> > > +       if (tst_kvercmp(2, 6, 22) < 0) {
> > > +               tst_brkm(TCONF, NULL, "2.6.22 or greater kernel
> > > required");
> > > +               tst_exit();
> > > +       }
> > >
> > >        /* Create a temporary directory & chdir there */
> > >        tst_tmpdir();
> > > ============
> > 
> > Try tst_exit instead of NULL.
> > Cheers,
> > -Garrett


> ------------------------------------------------------------------------------
> Download Intel&#174; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev

> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


-- 
Thanks & Regards
Rishi
LTP Maintainer
IBM, LTC, Bangalore
Please join IRC #ltp @ irc.freenode.net

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
