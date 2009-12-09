Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <liubo2009@cn.fujitsu.com>) id 1NIGys-0002QS-79
	for ltp-list@lists.sourceforge.net; Wed, 09 Dec 2009 07:29:02 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NIGyk-0004FG-72
	for ltp-list@lists.sourceforge.net; Wed, 09 Dec 2009 07:29:02 +0000
Message-ID: <4B1F51CA.6030906@cn.fujitsu.com>
Date: Wed, 09 Dec 2009 15:29:14 +0800
From: liubo <liubo2009@cn.fujitsu.com>
MIME-Version: 1.0
References: <4AF93496.3030408@cn.fujitsu.com>	
	<1258359225.5677.35.camel@subratamodak.linux.ibm.com>	
	<4B0112EC.9020202@cn.fujitsu.com>	
	<364299f40911260311m6d157453s47f57d1ba47ef643@mail.gmail.com>	
	<4B0F64B7.6060507@cn.fujitsu.com>	
	<364299f40911262249x1d48a61fh7528216fd18bcf57@mail.gmail.com>	
	<364299f40911270050q53743fbdte8b98170e135b4ae@mail.gmail.com>	
	<4B0FA4E9.1070206@cn.fujitsu.com>	
	<364299f40911271418y58264d77w3849d83f8deaa441@mail.gmail.com>	
	<4B11CCC9.5020608@cn.fujitsu.com>
	<364299f40911301600t1993f27do55101ea022d15ca0@mail.gmail.com>
In-Reply-To: <364299f40911301600t1993f27do55101ea022d15ca0@mail.gmail.com>
Subject: Re: [LTP] [PATCH] syscalls: fix some failure on arch X86_64
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: Mike Frysinger <vapier@gentoo.org>, ltp-list <ltp-list@lists.sf.net>

Hi,
> Yes. I [mostly] fixed the rt_sigaction01 test a few hours ago. A
> summary of the issues with the old version:
>
> 1. The test as it was written before verified functionality by
> ensuring that coredumps and crashes didn't occur. The new version
> either catches the appropriate rt signal and increments, or catches
> SIGSEGV and continues. Eventually once all of the issues are worked
> out with SIGRTMIN, the known issue TINFO printout needs to be removed
> from include/ltp_signal.h
> 2. If the sa_flags field of a struct sigaction `object' specifies
> SA_SIGINFO, you should and must use sa_sigaction instead of
> sa_handler, as stated in the manpage, because sa_handler and
> sa_sigaction are a union structure on many architectures, or not
> present when rt_* not implemented.
> 3. An autoconf test was added to look for sa_sigaction in struct
> sigaction, as it isn't present on all architectures.
>
> So, while this does fix rt_sigaction01, by and large, the following
> issues still exist with the rt_sig* syscalls:
> 1. SIGRTMIN always SIGSEGV's because signal_fault is being called in
> arch/x86/kernel/signal.c . I need to put some printk's in the code to
> understand why -EFAULT is being thrown, and thus why signal_fault is
> being tossed.
> 2. rt_sigprocmask01 and rt_sigsuspend01 still segfault for the same
> reason, as noted in 1.
>
>     Someone in the kernel.org team should generate some kind of
> documentation to clarify several points (including architectural
> quirks) with the rt_sig* syscalls. This trial and error problem
> solving isn't very helpful and there are a fair number of gotchas
> involved with implementing a functional set of sigaction-like calls
> using rt_sig*.
>
> Thanks,
> -Garrett
>
>
>   
I've made a patch to fix this rt_sig problem, but I encounted a trouble.

I figured out that syscall __NR_rt_sigaction doesn't use struct
sigaction, and glibc defines a
struct called kernel_sigaction to fit __NR_rt_sigaction so that glibc
function can pass it.
And the struct sigaction may change in the future.

My trouble is if we define a struct to fit this syscall just as what
glibc does, after the struct
sigaction change, we'll define another struct as well.

Looking forward to any advice about this trouble...


Thanks,
Liubo 

------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
