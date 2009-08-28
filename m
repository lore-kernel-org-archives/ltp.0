Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mgwz3-0004bH-1y
	for Ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 08:38:57 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mgwyv-00084M-6T
	for Ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 08:38:57 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7S8ca73026121
	for <Ltp-list@lists.sourceforge.net>; Fri, 28 Aug 2009 04:38:36 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7S8chdT258228
	for <Ltp-list@lists.sourceforge.net>; Fri, 28 Aug 2009 04:38:43 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7S8chrx001697
	for <Ltp-list@lists.sourceforge.net>; Fri, 28 Aug 2009 04:38:43 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1251439738.9081.9.camel@subratamodak.linux.ibm.com>
References: <alpine.LRH.2.00.0908271703550.1134@vixen.sonytel.be>
	<alpine.LRH.2.00.0908271709060.22490@vixen.sonytel.be>
	<1251439738.9081.9.camel@subratamodak.linux.ibm.com>
Date: Fri, 28 Aug 2009 14:08:17 +0530
Message-Id: <1251448700.9081.13.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Annotate tst_*() helpers
	with	__attribute__	((format (printf, M,
	N))) (was: Re: [PATCH] quotactl01: Fix	tst_resm()	format
	causing	crash)
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
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Linux Test Project <Ltp-list@lists.sourceforge.net>

On Fri, 2009-08-28 at 11:38 +0530, Subrata Modak wrote:
> On Thu, 2009-08-27 at 17:29 +0200, Geert Uytterhoeven wrote: 
> > On Thu, 27 Aug 2009, Geert Uytterhoeven wrote:
> > > When the quotactl syscall fails, quotactl01 crashes with a segmentation fault
> > > due to an incorrect printf()-style format.
> > 
> > This bug encouraged me to add annotations to the test helpers that take
> > printf()-style formats, cfr. the patch below.
> > 
> > It causes a massive amount of compiler warnings, most of them caused by
> > TEST_ERRNO being long. According to CVS history, both TEST_RETURN and
> > TEST_ERRNO have been changed from int to long to accomodate 64-bit platforms,
> > but to me the change of TEST_ERRNO looks bogus.
> > As errno is int according to C99, TEST_ERRNO should actually be int too, right? 
> > 
> > Note that there are also a few other cases where integers are used on pointer
> > type format specifiers. These will cause crashes when the code path is
> > executed.
> > 
> > >From 601578f79c05779acefe023fd499726d9fe4ce03 Mon Sep 17 00:00:00 2001
> > From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> > Date: Thu, 27 Aug 2009 17:08:18 +0200
> > Subject: [PATCH] Annotate tst_*() helpers with __attribute__ ((format (printf, M, N)))
> > 
> > Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> 
> Ok. Thanks.

Sorry. I need to revert this as it generates a huge set of warning for
all the tests compiled. It should not only get fixed at test.h, but also
in all tests that uses the tst_* family of functions, which obviously is
too big to fix.

Regards--
Subrata

> 
> Regards--
> Subrata
> 
> > ---
> >  include/test.h |   18 ++++++++++++------
> >  1 files changed, 12 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/test.h b/include/test.h
> > index 34ed5d2..03b0d46 100644
> > --- a/include/test.h
> > +++ b/include/test.h
> > @@ -186,12 +186,18 @@
> >   * Functions from lib/tst_res.c
> >   */
> >  const char *strttype(int ttype);
> > -void tst_res(int ttype, char *fname, char *arg_fmt, ...);
> > -void tst_resm(int ttype, char *arg_fmt, ...);
> > -void tst_brk(int ttype, char *fname, void (*func)(void), char *arg_fmt, ...);
> > -void tst_brkloop(int ttype, char *fname, void (*func)(void), char *arg_fmt, ...);
> > -void tst_brkm(int ttype, void (*func)(void), char *arg_fmt, ...);
> > -void tst_brkloopm(int ttype, void (*func)(void), char *arg_fmt, ...);
> > +void tst_res(int ttype, char *fname, char *arg_fmt, ...)
> > +	__attribute__ ((format (printf, 3, 4)));
> > +void tst_resm(int ttype, char *arg_fmt, ...)
> > +	__attribute__ ((format (printf, 2, 3)));
> > +void tst_brk(int ttype, char *fname, void (*func)(void), char *arg_fmt, ...)
> > +	__attribute__ ((format (printf, 4, 5)));
> > +void tst_brkloop(int ttype, char *fname, void (*func)(void), char *arg_fmt, ...)
> > +	__attribute__ ((format (printf, 4, 5)));
> > +void tst_brkm(int ttype, void (*func)(void), char *arg_fmt, ...)
> > +	__attribute__ ((format (printf, 3, 4)));
> > +void tst_brkloopm(int ttype, void (*func)(void), char *arg_fmt, ...)
> > +	__attribute__ ((format (printf, 3, 4)));
> >  void tst_require_root(void (*func)(void));
> >  int  tst_environ(void);
> >  void tst_exit(void) LTP_ATTRIBUTE_NORETURN;
> 
> 
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with 
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
