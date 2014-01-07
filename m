Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1W0XLV-0003Zx-SG
	for ltp-list@lists.sourceforge.net; Tue, 07 Jan 2014 14:09:29 +0000
Date: Tue, 7 Jan 2014 15:09:11 +0100
From: chrubis@suse.cz
Message-ID: <20140107140910.GD27135@rei.Home>
References: <1387358991.1664.37.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1387358991.1664.37.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH v5 1/2] lib/cloner.c: add more args
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
To: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> add args with ptid and ctid in ltp_clone().
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> ---
>  include/test.h |  2 +-
>  lib/cloner.c   | 20 ++++++++++++++++----
>  2 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/include/test.h b/include/test.h
> index 94fc721..ffc1c8c 100644
> --- a/include/test.h
> +++ b/include/test.h
> @@ -200,7 +200,7 @@ int self_exec(char *argv0, char *fmt, ...);
>  
>  /* Functions from lib/cloner.c */
>  int ltp_clone(unsigned long clone_flags, int (*fn)(void *arg), void *arg,
> -		size_t stack_size, void *stack);
> +		size_t stack_size, void *stack, ...);
>  int ltp_clone_malloc(unsigned long clone_flags, int (*fn)(void *arg),
>  		void *arg, size_t stacksize);
>  int ltp_clone_quick(unsigned long clone_flags, int (*fn)(void *arg),
> diff --git a/lib/cloner.c b/lib/cloner.c
> index a68ff1e..93e3f8c 100644
> --- a/lib/cloner.c
> +++ b/lib/cloner.c
> @@ -27,6 +27,7 @@
>  #include <string.h>
>  #include <stdlib.h>
>  #include <sched.h>
> +#include <stdarg.h>
>  #include "test.h"
>  
>  #undef clone			/* we want to use clone() */
> @@ -50,20 +51,31 @@ extern int __clone2(int (*fn) (void *arg), void *child_stack_base,
>   */
>  int
>  ltp_clone(unsigned long clone_flags, int (*fn) (void *arg), void *arg,
> -	  size_t stack_size, void *stack)
> +	  size_t stack_size, void *stack, ...)
>  {
>  	int ret;
> +	pid_t *parent_tid, *child_tid;
> +	void *tls;
> +	va_list arg_clone;
> +
> +	va_start(arg_clone, stack);
> +	parent_tid = va_arg(arg_clone, pid_t *);
> +	tls = va_arg(arg_clone, void *);
> +	child_tid = va_arg(arg_clone, pid_t *);
> +	va_end(arg_clone);
>  
>  #if defined(__hppa__) || defined(__metag__)
> -	ret = clone(fn, stack, clone_flags, arg);
> +	ret = clone(fn, stack, clone_flags, arg, parent_tid, tls, child_tid);
>  #elif defined(__ia64__)
> -	ret = clone2(fn, stack, stack_size, clone_flags, arg, NULL, NULL, NULL);
> +	ret = clone2(fn, stack, stack_size, clone_flags, arg,
> +		     parent_tid, tls, child_tid);
>  #else
>  	/*
>  	 * For archs where stack grows downwards, stack points to the topmost
>  	 * address of the memory space set up for the child stack.
>  	 */
> -	ret = clone(fn, (stack ? stack + stack_size : NULL), clone_flags, arg);
> +	ret = clone(fn, (stack ? stack + stack_size : NULL), clone_flags, arg,
> +		    parent_tid, tls, child_tid);
>  #endif
>  
>  	return ret;

Looks like this patch breaks compilation on older distributions, I've
got: "Too many arguments to function 'clone'". Has anybody seen this
too?

So this needs an autoconf check and few ifdefs.

And as we are about to create release this needs to be either fixed
ASAP or we will have to revert it for the release.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
