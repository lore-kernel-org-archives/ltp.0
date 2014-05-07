Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wi4eD-0008Oj-3w
	for ltp-list@lists.sourceforge.net; Wed, 07 May 2014 16:24:45 +0000
Date: Wed, 7 May 2014 18:23:45 +0200
From: chrubis@suse.cz
Message-ID: <20140507162344.GA1916@rei>
References: <1398422611-12706-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1398422611-12706-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] lib/tst_sig.c: output signal name when got
 unexpected signal
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> When testcase is killed by unexpected signal, usually it just prints
> signal's value.
> 	fcntl30     1  TBROK  :  unexpected signal 2 received (pid = 6714).
> 	fcntl30     2  TBROK  :  Remaining cases broken
> 
> Here we also print signal's name to output more informative message.
> 	fcntl30     1  TBROK  :  unexpected signal SIGINT(2) received (pid = 9872).
> 	fcntl30     2  TBROK  :  Remaining cases broken

This is a great idea.

What about we even add two tst_ functions to convert errno and signal to
string so that we can use these when needed in tests too?

what about:

const char *tst_strerrno(int err);
const char *tst_strsig(int sig);

> ---
>  lib/errnos.h  |  2 +-
>  lib/signame.h | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  lib/tst_res.c |  3 ++
>  lib/tst_sig.c |  4 ++-
>  4 files changed, 99 insertions(+), 2 deletions(-)
>  create mode 100644 lib/signame.h
> 
> diff --git a/lib/errnos.h b/lib/errnos.h
> index 8e80e07..bb42233 100644
> --- a/lib/errnos.h
> +++ b/lib/errnos.h
> @@ -27,7 +27,7 @@
>  
>  static const char *strerrnodef(int err)
>  {
> -	struct pair errno_pairs[] = {
> +	static struct pair errno_pairs[] = {
>  		{.name = "SUCCESS", .val = 0},
>  		/* asm-generic/errno-base.h */
>  		PAIR(EPERM)

Why have you removed the static? Do we need to have the errno_pairs
variable visible outside the tst_res.c?

> diff --git a/lib/signame.h b/lib/signame.h
> new file mode 100644
> index 0000000..77eabc1
> --- /dev/null
> +++ b/lib/signame.h
> @@ -0,0 +1,92 @@
> +/*
> + * Copyright (c) 2014 Fujitsu Ltd.
> + * Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +const char *strsignaldef(int sig)
> +{
> +	static const struct pair signal_pairs[] = {
> +		PAIR(SIGHUP)
> +		PAIR(SIGINT)
> +		PAIR(SIGQUIT)
> +		PAIR(SIGILL)
> +	#ifdef SIGTRAP
> +		PAIR(SIGTRAP)
> +	#endif
> +		/* SIGIOT same as SIGABRT, skipped */
> +		PAIR(SIGABRT)

                Hmm, it may be better to add both names in case that the
		number is mapped to two signals. I.e.

		[SIGABRT] = {.name = "SIGABRT/SIGIOT", .val = SIGABRT},

		Or we can add a STRPAIR() macro that takes two
		parameters, the number and the string for tese cases.

> +	#ifdef SIGEMT
> +		PAIR(SIGEMT)
> +	#endif
> +	#ifdef SIGBUS
> +		PAIR(SIGBUS)
> +	#endif
> +		PAIR(SIGFPE)
> +		PAIR(SIGKILL)
> +		PAIR(SIGUSR1)
> +		PAIR(SIGSEGV)
> +		PAIR(SIGUSR2)
> +		PAIR(SIGPIPE)
> +		PAIR(SIGALRM)
> +		PAIR(SIGTERM)
> +	#ifdef SIGSTKFLT
> +		PAIR(SIGSTKFLT)
> +	#endif
> +		/* SIGCLD same as SIGCHLD, skipped */
> +		PAIR(SIGCHLD)
> +		PAIR(SIGCONT)
> +		PAIR(SIGSTOP)
> +		PAIR(SIGTSTP)
> +		PAIR(SIGTTIN)
> +		PAIR(SIGTTOU)
> +	#ifdef SIGURG
> +		PAIR(SIGURG)
> +	#endif
> +	#ifdef SIGXCPU
> +		PAIR(SIGXCPU)
> +	#endif
> +	#ifdef SIGXFSZ
> +		PAIR(SIGXFSZ)
> +	#endif
> +	#ifdef SIGVTALRM
> +		PAIR(SIGVTALRM)
> +	#endif
> +	#ifdef SIGPROF
> +		PAIR(SIGPROF)
> +	#endif
> +	#ifdef SIGWINCH
> +		PAIR(SIGWINCH)
> +	#endif
> +	#if defined(SIGIO) || defined(SIGPOLL)
> +		/* SIGPOLL same as SIGIO, skipped */
> +		PAIR(SIGIO)
> +	#endif
> +	#ifdef SIGINFO
> +		PAIR(SIGINFO)
> +	#endif
> +	#ifdef SIGLOST
> +		PAIR(SIGLOST)
> +	#endif
> +	#ifdef SIGPWR
> +		PAIR(SIGPWR)
> +	#endif
> +	#if defined(SIGUNUSED) || defined(SIGSYS)
> +		/* SIGUNUSED same as SIGSYS, skipped */
> +		PAIR(SIGSYS)
> +	#endif
> +	};
> +
> +	PAIR_LOOKUP(signal_pairs, sig);
> +};
> diff --git a/lib/tst_res.c b/lib/tst_res.c
> index 8faa5a9..f19e5ab 100644
> --- a/lib/tst_res.c
> +++ b/lib/tst_res.c
> @@ -220,6 +220,9 @@ const char *strttype(int ttype)
>   */
>  #include "errnos.h"
>  
> +/* Include table of signals and strsignaldef() function*/
> +#include "signame.h"
> +
>  /*
>   * tst_res() - Main result reporting function.  Handle test information
>   *             appropriately depending on output display mode.  Call
> diff --git a/lib/tst_sig.c b/lib/tst_sig.c
> index 2ffe610..58ab4b3 100644
> --- a/lib/tst_sig.c
> +++ b/lib/tst_sig.c
> @@ -235,6 +235,7 @@ void tst_sig(int fork_flag, void (*handler) (), void (*cleanup) ())
>  	}			/* endfor */
>  }
>  
> +const char *strsignaldef(int sig);
>  /****************************************************************************
>   * def_handler() : default signal handler that is invoked when
>   *      an unexpected signal is caught.
> @@ -246,7 +247,8 @@ static void def_handler(int sig)
>  	 * Break remaining test cases, do any cleanup, then exit
>  	 */
>  	tst_brkm(TBROK, T_cleanup,
> -		 "unexpected signal %d received (pid = %d).", sig, getpid());
> +		 "unexpected signal %s(%d) received (pid = %d).",
> +		 strsignaldef(sig), sig, getpid());
>  }

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
