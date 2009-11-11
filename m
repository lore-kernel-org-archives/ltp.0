Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yjwei@cn.fujitsu.com>) id 1N84ti-0005YV-LO
	for ltp-list@lists.sourceforge.net; Wed, 11 Nov 2009 04:33:34 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N84tb-0004y9-RV
	for ltp-list@lists.sourceforge.net; Wed, 11 Nov 2009 04:33:34 +0000
Message-ID: <4AFA3DF5.4000604@cn.fujitsu.com>
Date: Wed, 11 Nov 2009 12:30:45 +0800
From: Wei Yongjun <yjwei@cn.fujitsu.com>
MIME-Version: 1.0
References: <4AF93496.3030408@cn.fujitsu.com> <4AFA133F.3020808@cn.fujitsu.com>
	<364299f40911102014p1f2c28adr75700a126ef03d86@mail.gmail.com>
In-Reply-To: <364299f40911102014p1f2c28adr75700a126ef03d86@mail.gmail.com>
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
Cc: ltp-list@lists.sourceforge.net, maknayak@in.ibm.com


Garrett Cooper wrote:
> On Tue, Nov 10, 2009 at 5:28 PM, liubo <liubo2009@cn.fujitsu.com> wrote:
>   
>> Hi,
>> On 11/10/2009 05:38 PM, liubo wrote:
>>     
>>> 1) rt_sigaction
>>>     "sigaction" has the structure:
>>>
>>>  struct sigaction {
>>>          __sighandler_t sa_handler;
>>>          unsigned long sa_flags;
>>>   #ifdef SA_RESTORER
>>>           __sigrestore_t sa_restorer;
>>>   #endif
>>>           sigset_t sa_mask;               /* mask last for extensibility */
>>>  };
>>>       
>
> Not true... from glibc 2.9 / gentoo-sources-2.6.30-r4:
>
> #ifdef __i386__
> /* Here we must cater to libcs that poke about in kernel headers.  */
>
> struct sigaction {
>         union {
>           __sighandler_t _sa_handler;
>           void (*_sa_sigaction)(int, struct siginfo *, void *);
>         } _u;
>         sigset_t sa_mask;
>         unsigned long sa_flags;
>         void (*sa_restorer)(void);
> };
>
> /* ... */
>
> #else
>
> struct sigaction {
>         __sighandler_t sa_handler;
>         unsigned long sa_flags;
>         __sigrestore_t sa_restorer;
>         sigset_t sa_mask;               /* mask last for extensibility */
> };
>
> #endif
>
> What do the manpages say is required for rt_sigaction to function on
> your machine? Mine just says:
>
> SYNOPSIS
>        #include <signal.h>
>
>        int sigaction(int signum, const struct sigaction *act,
>                      struct sigaction *oldact);
>
>    Feature Test Macro Requirements for glibc (see feature_test_macros(7)):
>
>        sigaction(): _POSIX_C_SOURCE >= 1 || _XOPEN_SOURCE || _POSIX_SOURCE
>
>   
>>>     However, on arch x86_64, if we directly get to call rt_sigaction,
>>> the argument "sa_restorer" will not be fulfilled, and this will lead
>>>  to segment fault.
>>>     on arch x86_64, if sa_restorer is not set, kernel will lead to segment fault.
>>> In other arch, if sa_restorer is not set, kernel can do the correct work.
>>>     To avoid this segment fault, we use glibc function
>>> "int sigaction(...);" instead, which can fulfill the argument "sa_restorer".
>>>
>>> 2) rt_sigprocmask
>>>     This failure contains two aspects,
>>> the first is the segment fault as described in 1),
>>> the second is that testcase uses a unknown signal 33 for test,
>>> and this will lead sigaction cannot bind signal 33 to the action.
>>>
>>>     So, we attempt to use a known signal instead, such as 34.
>>>
>>>
>>>       
>>  I am sure signal 32 and 33 cannot be used in rt_sigprocmask test
>>  on arch x86_64, but I'm not sure which signal else should be used
>>  here, Is there anyone can provide suggestions?
>>     
>
> RT signals are all signals above SIGRTMIN (typically 32+, but not
> always), up to SIGRTMAX (usually 64, but on mips it's 128). So... why
> is setting the signal number to anywhere between SIGRTMIN and SIGRTMAX
> unacceptable?
>   

Not sure why signal 32 and 33 are not accepted by sigaction() on
x86_64, the acceptable signal from 34 to SIGRTMAX, maybe it's the
glibc's BUG? since I had not found the source code of x86_64
sigaction(), I can not check this. It is very strange.



------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
