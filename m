Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wjrfo-0007DQ-Ah
	for ltp-list@lists.sourceforge.net; Mon, 12 May 2014 14:57:48 +0000
Date: Mon, 12 May 2014 16:56:46 +0200
From: chrubis@suse.cz
Message-ID: <20140512145646.GF4741@rei>
References: <1399616591-32662-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1399616591-32662-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2] lib/tst_sig.c: output signal name when got
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

Please add a note about the two new tst_ functions here as well,
something as:

This also adds two new tst_ functions to convert errno or signal to its
name.

const char *tst_strsig(int sig) returns signal name given signal number

const char *tst_strerrno(int err) returns errno name given errno number

> +const char *tst_strsig(int sig)
> +{
> +	static const struct pair signal_pairs[] = {
> +		STRPAIR(SIGHUP, "SIGHUP")
> +		STRPAIR(SIGINT, "SIGINT")
> +		STRPAIR(SIGQUIT, "SIGQUIT")
> +		STRPAIR(SIGILL, "SIGILL")
> +	#ifdef SIGTRAP
> +		STRPAIR(SIGTRAP, "SIGTRAP")
> +	#endif
> +
> +	#ifdef SIGIOT
> +		/* SIGIOT same as SIGABRT */
> +		STRPAIR(SIGABRT, "SIGIOT/SIGABRT")
> +	#else
> +		STRPAIR(SIGABRT, "SIGABRT")
> +	#endif
> +
> +	#ifdef SIGEMT
> +		STRPAIR(SIGEMT, "SIGEMT")
> +	#endif
> +	#ifdef SIGBUS
> +		STRPAIR(SIGBUS, "SIGBUS")
> +	#endif
> +		STRPAIR(SIGFPE, "SIGFPE")
> +		STRPAIR(SIGKILL, "SIGKILL")
> +		STRPAIR(SIGUSR1, "SIGUSR1")
> +		STRPAIR(SIGSEGV, "SIGSEGV")
> +		STRPAIR(SIGUSR2, "SIGUSR2")
> +		STRPAIR(SIGPIPE, "SIGPIPE")
> +		STRPAIR(SIGALRM, "SIGALRM")
> +		STRPAIR(SIGTERM, "SIGTERM")

Ah, I wasn't clear enough, I guess, sorry.

What I had in mind was to use STRPAIR() in cases that the string is different
from the symbolic name and use PAIR() in the rest of the cases.

I.e. use STRPAIR(SIGABRT, "SIGIOT/SIGABRT") but PAIR(SIGEMT).

> +#define STRPAIR(key, value)  {.val = (key), .name = (value)},

This would be:

#define STRPAIR(key, value) [key] = {.name = value, .val = key}

Then you can mix PAIR() with STRPAIR() and use PARI_LOOKUP().

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
