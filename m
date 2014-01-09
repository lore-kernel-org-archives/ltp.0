Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1W1Faa-0002Ut-Hm
	for ltp-list@lists.sourceforge.net; Thu, 09 Jan 2014 13:24:00 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1W1FaY-00034G-Jx
	for ltp-list@lists.sourceforge.net; Thu, 09 Jan 2014 13:24:00 +0000
Date: Thu, 9 Jan 2014 08:23:48 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1382348670.13310097.1389273828896.JavaMail.root@redhat.com>
In-Reply-To: <201401090803.39606.vapier@gentoo.org>
References: <1387358991.1664.37.camel@G08JYZSD130126>
	<20140107140910.GD27135@rei.Home>
	<1389191490.2879.27.camel@G08JYZSD130126>
	<201401090803.39606.vapier@gentoo.org>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] clone/clone08.c: check whether clone supports 7
 arguments
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



----- Original Message -----
> From: "Mike Frysinger" <vapier@gentoo.org>
> To: ltp-list@lists.sourceforge.net
> Sent: Thursday, 9 January, 2014 2:03:38 PM
> Subject: Re: [LTP] [PATCH] clone/clone08.c: check whether clone supports 7	arguments
> 
> On Wednesday 08 January 2014 09:31:30 Zeng Linggang wrote:
> > +AC_DEFUN([LTP_CHECK_CLONE7ARGS],[
> > +AH_TEMPLATE(HAVE_CLONE7ARGS,
> > +[Define to 1 if clone() supports 7 arguments.])
> > +AC_MSG_CHECKING([for CLONE7ARGS])
> > +AC_TRY_LINK([#define _GNU_SOURCE
> > +		#include <sched.h>
> > +		#include <stdlib.h>],
> > +		[
> > +		#if !defined(__ia64__)
> > +		clone(NULL, NULL, 0, NULL, NULL, NULL, NULL);
> > +		#endif
> > +		],
> > +		AC_DEFINE(HAVE_CLONE7ARGS) AC_MSG_RESULT(yes), AC_MSG_RESULT(no))
> > +])
> 
> you aren't really testing for "clone takes 7 args", you're testing for "clone
> has varargs support".  rename the define (and use _ in its name), and drop
> the
> ia64 check as it isn't needed.

Why not? It should matter, according to clone(2) you should be using __clone2() on ia64:
   ia64
       On ia64, a different interface is used:

       int __clone2(int (*fn)(void *),
                    void *child_stack_base, size_t stack_size,
                    int flags, void *arg, ...
                 /* pid_t *ptid, struct user_desc *tls, pid_t *ctid */ );

# cat a.c
#define _GNU_SOURCE
#include <sched.h>
#include <stdlib.h>

int main()
{
	clone(NULL, NULL, 0, NULL, NULL, NULL, NULL);
	return 0;
}

# uname -m
ia64

# gcc a.c
/tmp/cc0QVVOU.o: In function `main':
a.c:(.text+0x42): undefined reference to `clone'
collect2: ld returned 1 exit status

So perhaps we should add #else and test for __clone2 on ia64.

Regards,
Jan

> -mike
> 
> ------------------------------------------------------------------------------
> CenturyLink Cloud: The Leader in Enterprise Cloud Services.
> Learn Why More Businesses Are Choosing CenturyLink Cloud For
> Critical Workloads, Development Environments & Everything In Between.
> Get a Quote or Start a Free Trial Today.
> http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

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
