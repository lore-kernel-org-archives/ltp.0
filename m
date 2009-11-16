Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1NA4MM-00069o-JT
	for ltp-list@lists.sourceforge.net; Mon, 16 Nov 2009 16:23:22 +0000
Date: Mon, 16 Nov 2009 17:23:03 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20091116162303.GC16811@schrodinger.suse.cz>
References: <20091105192746.GA30521@schrodinger.suse.cz>
	<8368651DACC1964480F951191B94A078016A1F41@svexch01.mvista.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8368651DACC1964480F951191B94A078016A1F41@svexch01.mvista.com>
Subject: Re: [LTP] rt_sigqueueinfo
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
To: Henry Yei <hyei@mvista.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> For the rt_sig* tests I have some changes in my internal tree to set SIGSETSIZE depending on arch rather than to use the hardcoded value of 8 in orderto fix mips failures. Please consider folding this change into your proposal. I've submitted similar changes in a recent ppoll01 patch, and am awaiting comments on correctness.
> 
> Ex)
> 
> +#if defined (__mips__)
> +#define SIGSETSIZE 16
> +#else
> +#define SIGSETSIZE 8
> +#endif
> 
> -TEST(syscall(__NR_rt_sigprocmask, SIG_BLOCK, &set, &oset,
> 					8));
> +TEST(syscall(__NR_rt_sigprocmask, SIG_BLOCK, &set, &oset,
> 					SIGSETSIZE));
> 

Well there is _SIGSET_NWORDS macro defined in my /usr/include/sigset/bits.h
header and it's defined as  (1024 / (8 * sizeof (unsigned long int). Anyway
this should be moved to some header in $LTPROOT/include/ or better we should
test for _SIGSET_NWORDS aviability in configure script.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
