Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MLY0J-0000UN-NO
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 07:43:47 +0000
Received: from [32.97.182.143] (helo=e3.ny.us.ibm.com)
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLY0I-0002iG-FL
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 07:43:47 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5U7bUp0002081
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 03:37:30 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5U7gnOI187210
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 03:42:49 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5U7gnWR002853
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 03:42:49 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1245920973.5542.33.camel@subratamodak.linux.ibm.com>
References: <200906232049.n5NKne0h007108@e5.ny.us.ibm.com>
	<1245920973.5542.33.camel@subratamodak.linux.ibm.com>
Date: Tue, 30 Jun 2009 13:11:07 +0530
Message-Id: <1246347667.4819.27.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Run the eventfd test in a temporary directory,
	because it creates some files
Reply-To: subrata@linux.vnet.ibm.com
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
To: Jiri Palecek <jpalecek@web.de>
Cc: ltp-list@lists.sourceforge.net, Davide Libenzi <davidel@xmailserver.org>

Jiri,

On Thu, 2009-06-25 at 14:39 +0530, Subrata Modak wrote: 
> On Mon, 2008-12-29 at 14:48 +0100, Jiri Palecek wrote: 
> > Hello,
> > 
> > the eventfd test creates some files in the current directory. I think it should be creating the files in a temporary directory instead, as is already the standard with other LTP tests, because the current might be nonwriteable and the user might not want the files left there.
> > 
> > Regards
> >     Jiri Palecek
> > 
> > Signed-off-by: Jiri Palecek <jpalecek@web.de>
> 
> Thanks. 
> 
> Recently i have seen some patches on LKML from Davide on the change for
> eventfd() interface. Could you please verify how they will affect our
> tests, and, make changes if necessary ?
> http://lkml.org/lkml/2009/6/24/590,

Any thoughts for this ?

Regards--
Subrata

> 
> Regards--
> Subrata
> 
> > ---
> >  testcases/kernel/syscalls/eventfd/eventfd01.c |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> > 
> > diff --git a/testcases/kernel/syscalls/eventfd/eventfd01.c b/testcases/kernel/syscalls/eventfd/eventfd01.c
> > index ee09752..0eed8d1 100644
> > --- a/testcases/kernel/syscalls/eventfd/eventfd01.c
> > +++ b/testcases/kernel/syscalls/eventfd/eventfd01.c
> > @@ -759,6 +759,8 @@ static void setup(void)
> >  	if (tst_kvercmp(2, 6, 22) < 0)
> >  		tst_brkm(TCONF, cleanup, "2.6.22 or greater kernel required");
> > 
> > +	/* Create a temporary directory & chdir there */
> > +	tst_tmpdir();
> >  	/* Pause if that option was specified
> >  	 * TEST_PAUSE contains the code to fork the test with the -c option.
> >  	 */
> > @@ -776,6 +778,7 @@ static void cleanup(void)
> >  	 */
> >  	TEST_CLEANUP;
> > 
> > +	tst_rmdir();
> >  	/* exit with return code appropriate for results */
> >  	tst_exit();
> >   /*NOTREACHED*/}
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
