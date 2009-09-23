Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1MqJ7M-0007jv-OQ
	for ltp-list@lists.sourceforge.net; Wed, 23 Sep 2009 04:06:12 +0000
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MqJ7I-0006f3-2U
	for ltp-list@lists.sourceforge.net; Wed, 23 Sep 2009 04:06:12 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8N446kl017679
	for <ltp-list@lists.sourceforge.net>; Tue, 22 Sep 2009 22:04:06 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8N45kEJ061162
	for <ltp-list@lists.sourceforge.net>; Tue, 22 Sep 2009 22:05:53 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8N45k1l006898
	for <ltp-list@lists.sourceforge.net>; Tue, 22 Sep 2009 22:05:46 -0600
Date: Tue, 22 Sep 2009 23:05:46 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20090923040546.GC9662@us.ibm.com>
References: <20090921230644.GA30741@us.ibm.com>
	<200909221100.42467.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200909221100.42467.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH RFC] ltp: define and use common clone helpers
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: LTP list <ltp-list@lists.sourceforge.net>, Nathan T Lynch <natlynch@us.ibm.com>

Quoting Mike Frysinger (vapier@gentoo.org):
> On Monday 21 September 2009 19:06:44 Serge E. Hallyn wrote:
> > Define ltp_clone() and ltp_clone_malloc() in libltp, and convert existing
> > clone usages to them.  (clone04 can't use it bc it wants to pass NULL,
> > which ltp_clone() will for many arches convert to NULL+stacksize-1).
> 
> so have the code handle NULL specially:
> (stack ? stack + stack_size - 1 : NULL)

<grumble> yeah that occurred to me but I was rebelling against the clone04.c
code...  But I guess I should.

> > +ltp_clone(unsigned long clone_flags, void *stack, int stack_size,
> > +		int (*fn)(void *arg), void *arg)
> > +{
> > +	int ret;
> > +
> > +#if defined(__hppa__)
> > +	ret = clone(fn, stack, clone_flags, arg);
> > +#elif defined(__ia64__)
> > +	ret = clone2(fn, stack, stack_size, clone_flags, arg, NULL, NULL, NULL);
> > +#else
> > +	ret = clone(fn, stack + stack_size - 1, clone_flags, arg);
> > +#endif
> > +
> > +	if (ret == -1)
> > +		perror("clone");
> 
> we cant be sure why the higher layers are calling clone.  maybe the args given 
> expect the clone() call to fail.  so we dont want any perror() invocation 
> here.

Makes sense.

> > +/***********************************************************************
> > + * ltp_clone_malloc: also does the memory allocation for clone.
> > + * Experience thus far suggests that one page is often insufficient,
> > + * while 4*getpagesize() seems adequate.
> > + ***********************************************************************/
> 
> a malloc() function implies you should be giving it a size.  i think there 
> should be another helper here.
> ltp_clone_malloc() - takes a size
> ltp_clone_quick() - calls ltp_clone_malloc() with getpagesize() * 4
> 
> or a better name than "quick" ...
> 
> > +int
> > +ltp_clone_malloc(unsigned long clone_flags, int (*fn)(void *arg), void
> >  *arg)
> 
> i think argument order should be consistent.  i.e. have all ltp_clone_* calls 
> start with (flags, func, arg) and then the malloc/etc... calls can add on 
> (..., size) and (..., size, buffer).

makes sense.

> > +	void *stack = malloc (stack_size);
> 
> no spacing around function calls
> 
> > +	if (!stack) {
> > +		perror("malloc");
> > +		return -1;
> > +	}
> 
> since people are linking in -lltp to get these clone helpers, we can assume 
> the tst_* funcs exist.  so this should invoke one of them with TBROK|TERRNO.

True.

> > +	ret = ltp_clone(clone_flags, stack, stack_size, fn, arg);
> > +
> > +	if (ret == -1) {
> > +		perror("clone");
> > +		free(stack);
> > +	}
> 
> same issue as the other func -- dont call perror()
> 
> i think we should make sure to save/restore errno across the free() invocation 
> so that the caller gets the result from clone() ...

Good point.

> otherwise this looks great.  thanks for doing the footwork here.
> -mike

Will hopefully whip up a new patch later this week and resend.

thanks,
-serge

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
