Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1W1K1q-00074o-F8
	for ltp-list@lists.sourceforge.net; Thu, 09 Jan 2014 18:08:26 +0000
Date: Thu, 9 Jan 2014 19:08:05 +0100
From: chrubis@suse.cz
Message-ID: <20140109180804.GA9619@rei>
References: <1387358991.1664.37.camel@G08JYZSD130126>
	<20140109113619.GB5125@rei.Home>
	<1389269411.2149.8.camel@G08JYZSD130126>
	<201401090947.12749.vapier@gentoo.org> <20140109163716.GA8938@rei>
	<629935924.13499645.1389289589284.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <629935924.13499645.1389289589284.JavaMail.root@redhat.com>
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>

Hi!
> > Hi!
> > And here is a patch. (note that it should be applied over the two
> > allready commited patches)
> 
> Hi,
> 
> Line 130 contains a typo:
> clone08.c: In function ??clone_child??:
> clone08.c:130: warning: implicit declaration of function ??tst_brmk??

Aw, I will fix that.

> In relation to:
> #ifndef CLONE_SUPPORTS_7_ARGS
> # define clone(fn, stack, flags, arg, ptid, tls, ctid) \
>          clone(fn, stack, flags, arg)                                                                                                                                                         #endif
> 
> Shouldn't we have something similar also for clone2()?
> For example:
> 
> --- cloner.c    2014-01-09 18:10:27.965074200 +0100
> +++ /tmp/cloner.c       2014-01-09 18:43:28.099822061 +0100
> @@ -34,10 +34,14 @@
>  #undef clone                   /* we want to use clone() */
> 
>  #if defined(__ia64__)
> -#define clone2 __clone2
> +# ifndef CLONE_SUPPORTS_7_ARGS
> +# define clone2(fn, stack, stack_size, flags, arg, ptid, tls, ctid) \
> +         __clone2(fn, stack, stack_size, flags, arg)
> +# else
> +# define clone2 __clone2
> +# endif
>  extern int __clone2(int (*fn) (void *arg), void *child_stack_base,
> -                   size_t child_stack_size, int flags, void *arg,
> -                   pid_t *parent_tid, void *tls, pid_t *child_tid);
> +                   size_t child_stack_size, int flags, void *arg, ...);
>  #endif
> 
>  #ifndef CLONE_SUPPORTS_7_ARGS

I've been unable to locate ia64 distribution that does not support the
additional parameters so I've leaved that out. It may be related to a
fact that linux was ported to ia64 after the interface has changed, but
that is just my guess.

And I guess that we may drop the extern int definition too, at least the
configure script with __clone2() function seems to work fine just with
the <sched.h>

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
