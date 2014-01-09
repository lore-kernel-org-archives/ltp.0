Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1W1HA1-00040u-JA
	for ltp-list@lists.sourceforge.net; Thu, 09 Jan 2014 15:04:41 +0000
Date: Thu, 9 Jan 2014 16:04:20 +0100
From: chrubis@suse.cz
Message-ID: <20140109150420.GI5125@rei.Home>
References: <1387358991.1664.37.camel@G08JYZSD130126>
	<20140109113619.GB5125@rei.Home>
	<1389269411.2149.8.camel@G08JYZSD130126>
	<201401090947.12749.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201401090947.12749.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH???v3] lib/cloner.c: add function ltp_clone7 when
 clone supports???7 arguments
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
Cc: ltp-list@lists.sourceforge.net

Hi!
> > So create m4/ltp-clone7args.m4 to check whether clone support 7 arguments.
> > If HAVE_CLONE7ARGS is defined, ltp_clone7 will be defined in lib/cloner.c.
> > 
> > When tests need pass 7 arguments to clone, ltp_clone7 should be used. When
> > HAVE_CLONE7ARGS is not defined, make these tests return TCONF, like
> > clone08.
> 
> the current clone function is broken.  you cannot call va_args on an arg that
> doesn't exist.  but if the suggestions below are implemented, this shouldn't
> be a problem anymore.
> 
> > --- a/include/test.h
> > +++ b/include/test.h
> > 
> >  /* Functions from lib/cloner.c */
> >  int ltp_clone(unsigned long clone_flags, int (*fn)(void *arg), void *arg,
> > +		size_t stack_size, void *stack);
> > +#ifdef HAVE_CLONE7ARGS
> > +int ltp_clone7(unsigned long clone_flags, int (*fn)(void *arg), void *arg,
> >  		size_t stack_size, void *stack, ...);
> > +#endif
> 
> always define this prototype
> 
> > --- a/lib/cloner.c
> > +++ b/lib/cloner.c
> 
> add a helper here like:
> 
> #ifndef CLONE_SUPPORTS_7_ARGS
> # define clone(fn, stack, flags, arg, ptid, tls, ctid) clone(fn, stack, flags, arg)
> #endif
> 
> rename the existing ltp_clone to a static _ltp_clone
> 
> create a new ltp_clone that just calls _ltp_clone and passes in NULL for the
> additional 3 args
> 
> in the new ltp_clone7, have it do:
> #ifdef CLONE_SUPPORTS_7_ARGS
> 	... call _ltp_clone ...
> #else
> 	... call TCONF or TBROK or something ...
> #endif
> 
> that should keep all the test logic simple as Cyril suggested.  no need for
> them to check ifdefs, just call ltp_clone7 instead.

I will finish this one, the solution is nearly ready and I have the
means to quickly test it on most of the distros/archs.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
