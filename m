Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1W0uqn-0000FS-3X
	for ltp-list@lists.sourceforge.net; Wed, 08 Jan 2014 15:15:21 +0000
Date: Wed, 8 Jan 2014 16:15:02 +0100
From: chrubis@suse.cz
Message-ID: <20140108151501.GA1556@rei>
References: <1387358991.1664.37.camel@G08JYZSD130126>
	<20140107140910.GD27135@rei.Home>
	<1389191490.2879.27.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1389191490.2879.27.camel@G08JYZSD130126>
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> Create m4/ltp-clone7args.m4 to check whether clone support 7 arguments.
> When HAVE_CLONE7ARGS is not defined, make clone08 return TCONF
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> ---
>  configure.ac                              |  1 +
>  include/test.h                            |  9 +++++++-
>  lib/cloner.c                              | 24 +++++++++++++++++++++
>  m4/ltp-clone7args.m4                      | 36 +++++++++++++++++++++++++++++++
>  testcases/kernel/syscalls/clone/clone08.c | 14 ++++++++++++
>  5 files changed, 83 insertions(+), 1 deletion(-)
>  create mode 100644 m4/ltp-clone7args.m4
> 
> diff --git a/configure.ac b/configure.ac
> index 4af7662..e564ee5 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -171,5 +171,6 @@ LTP_CHECK_FS_IOC_FLAGS
>  LTP_CHECK_MREMAP_FIXED
>  LTP_CHECK_KERNEL_DEVEL
>  LTP_CHECK_XFS_QUOTACTL
> +LTP_CHECK_CLONE7ARGS
>  
>  AC_OUTPUT
> diff --git a/include/test.h b/include/test.h
> index ffc1c8c..050dba5 100644
> --- a/include/test.h
> +++ b/include/test.h
> @@ -46,6 +46,7 @@
>  #include "tst_checkpoint.h"
>  #include "tst_process_state.h"
>  #include "tst_resource.h"
> +#include "config.h"
>  
>  /* Use low 6 bits to encode test type */
>  #define TTYPE_MASK 0x3f
> @@ -199,8 +200,14 @@ void maybe_run_child(void (*child)(), char *fmt, ...);
>  int self_exec(char *argv0, char *fmt, ...);
>  
>  /* Functions from lib/cloner.c */
> -int ltp_clone(unsigned long clone_flags, int (*fn)(void *arg), void *arg,
> +#ifdef HAVE_CLONE7ARGS
> +int ltp_clone(unsigned long clone_flags, int (*fn) (void *arg), void *arg,
>  		size_t stack_size, void *stack, ...);
> +#else
> +int ltp_clone(unsigned long clone_flags, int (*fn)(void *arg), void *arg,
> +		size_t stack_size, void *stack);
> +#endif

I wonder if having two different definitions is worth the trouble.
Because we can easily use the definition with the ... in both cases.

The result is not optimal in either case. In the first case there would
be compilation failures on older distributions, in the second there is a
posibility that some of the arguments are ignored if test is not ifdefed
properly. I think I like the second case better.

>  int ltp_clone_malloc(unsigned long clone_flags, int (*fn)(void *arg),
>  		void *arg, size_t stacksize);
>  int ltp_clone_quick(unsigned long clone_flags, int (*fn)(void *arg),
> diff --git a/lib/cloner.c b/lib/cloner.c
> index 93e3f8c..e0c92cc 100644
> --- a/lib/cloner.c
> +++ b/lib/cloner.c
> @@ -29,6 +29,7 @@
>  #include <sched.h>
>  #include <stdarg.h>
>  #include "test.h"
> +#include "config.h"
>  
>  #undef clone			/* we want to use clone() */
>  
> @@ -49,6 +50,7 @@ extern int __clone2(int (*fn) (void *arg), void *child_stack_base,
>   *   2. __ia64__ takes bottom of stack and uses clone2
>   *   3. all others take top of stack (stack grows down)
>   */
> +#ifdef HAVE_CLONE7ARGS
>  int
>  ltp_clone(unsigned long clone_flags, int (*fn) (void *arg), void *arg,
>  	  size_t stack_size, void *stack, ...)
> @@ -80,6 +82,28 @@ ltp_clone(unsigned long clone_flags, int (*fn) (void *arg), void *arg,
>  
>  	return ret;
>  }
> +#else
> +int
> +ltp_clone(unsigned long clone_flags, int (*fn) (void *arg), void *arg,
> +	  size_t stack_size, void *stack)
> +{
> +	int ret;
> +
> +#if defined(__hppa__) || defined(__metag__)
> +	ret = clone(fn, stack, clone_flags, arg);
> +#elif defined(__ia64__)
> +	ret = clone2(fn, stack, stack_size, clone_flags, arg, NULL, NULL, NULL);
> +#else
> +	/*
> +	 * For archs where stack grows downwards, stack points to the topmost
> +	 * address of the memory space set up for the child stack.
> +	 */
> +	ret = clone(fn, (stack ? stack + stack_size : NULL), clone_flags, arg);
> +#endif
> +
> +	return ret;
> +}
> +#endif
>  
>  /*
>   * ltp_clone_malloc: also does the memory allocation for clone with a
> diff --git a/m4/ltp-clone7args.m4 b/m4/ltp-clone7args.m4
> new file mode 100644
> index 0000000..927c9f8
> --- /dev/null
> +++ b/m4/ltp-clone7args.m4
> @@ -0,0 +1,36 @@
> +dnl
> +dnl Copyright (c) Linux Test Project, 2013
> +dnl
> +dnl This program is free software;  you can redistribute it and/or modify
> +dnl it under the terms of the GNU General Public License as published by
> +dnl the Free Software Foundation; either version 2 of the License, or
> +dnl (at your option) any later version.
> +dnl
> +dnl This program is distributed in the hope that it will be useful,
> +dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
> +dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> +dnl the GNU General Public License for more details.
> +dnl
> +dnl You should have received a copy of the GNU General Public License
> +dnl along with this program;  if not, write to the Free Software
> +dnl Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> +dnl
> +
> +dnl
> +dnl LTP_CHECK_CLONE7ARGS
> +dnl ----------------------------
> +dnl
> +AC_DEFUN([LTP_CHECK_CLONE7ARGS],[
> +AH_TEMPLATE(HAVE_CLONE7ARGS,
> +[Define to 1 if clone() supports 7 arguments.])
> +AC_MSG_CHECKING([for CLONE7ARGS])
> +AC_TRY_LINK([#define _GNU_SOURCE
> +		#include <sched.h>
> +		#include <stdlib.h>],
> +		[
> +		#if !defined(__ia64__)
> +		clone(NULL, NULL, 0, NULL, NULL, NULL, NULL);
> +		#endif
> +		],
> +		AC_DEFINE(HAVE_CLONE7ARGS) AC_MSG_RESULT(yes), AC_MSG_RESULT(no))
> +])
> diff --git a/testcases/kernel/syscalls/clone/clone08.c b/testcases/kernel/syscalls/clone/clone08.c
> index ec559a3..3a70a49 100644
> --- a/testcases/kernel/syscalls/clone/clone08.c
> +++ b/testcases/kernel/syscalls/clone/clone08.c
> @@ -23,6 +23,9 @@
>  #include "clone_platform.h"
>  #include "safe_macros.h"
>  #include "linux_syscall_numbers.h"
> +#include "config.h"
> +
> +#ifdef HAVE_CLONE7ARGS
>  
>  static pid_t ptid, ctid, tgid;
>  static void *child_stack;
> @@ -305,3 +308,14 @@ static int child_clone_thread(void)
>  	ltp_syscall(__NR_exit, 0);
>  	return 0;
>  }
> +
> +#else
> +
> +char *TCID = "clone08";
> +
> +int main(int ac, char **av)
> +{
> +	tst_brkm(TCONF, NULL, "This test needs clone support "
> +		 "7 args");

Is this string really over 80 chars?

Also in this case it should be main(void) to avoid unused warnings.

And I would rather see one TCID and TST_TOTAL at the top of the test
(before the #ifdef HAVE_CLONE7ARGS).

> +}
> +#endif
> -- 
> 1.8.4.2
> 
> 
> 

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
