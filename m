Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N84bv-0007Nm-EE
	for ltp-list@lists.sourceforge.net; Wed, 11 Nov 2009 04:15:11 +0000
Received: from mail-px0-f189.google.com ([209.85.216.189])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N84bn-0004LU-Ke
	for ltp-list@lists.sourceforge.net; Wed, 11 Nov 2009 04:15:11 +0000
Received: by pxi27 with SMTP id 27so528688pxi.25
	for <ltp-list@lists.sourceforge.net>;
	Tue, 10 Nov 2009 20:14:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4AFA133F.3020808@cn.fujitsu.com>
References: <4AF93496.3030408@cn.fujitsu.com> <4AFA133F.3020808@cn.fujitsu.com>
Date: Tue, 10 Nov 2009 20:14:57 -0800
Message-ID: <364299f40911102014p1f2c28adr75700a126ef03d86@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: liubo <liubo2009@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net, maknayak@in.ibm.com

On Tue, Nov 10, 2009 at 5:28 PM, liubo <liubo2009@cn.fujitsu.com> wrote:
> Hi,
> On 11/10/2009 05:38 PM, liubo wrote:
>> 1) rt_sigaction
>> =A0 =A0 "sigaction" has the structure:
>>
>> =A0struct sigaction {
>> =A0 =A0 =A0 =A0 =A0__sighandler_t sa_handler;
>> =A0 =A0 =A0 =A0 =A0unsigned long sa_flags;
>> =A0 #ifdef SA_RESTORER
>> =A0 =A0 =A0 =A0 =A0 __sigrestore_t sa_restorer;
>> =A0 #endif
>> =A0 =A0 =A0 =A0 =A0 sigset_t sa_mask; =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* mas=
k last for extensibility */
>> =A0};

Not true... from glibc 2.9 / gentoo-sources-2.6.30-r4:

#ifdef __i386__
/* Here we must cater to libcs that poke about in kernel headers.  */

struct sigaction {
        union {
          __sighandler_t _sa_handler;
          void (*_sa_sigaction)(int, struct siginfo *, void *);
        } _u;
        sigset_t sa_mask;
        unsigned long sa_flags;
        void (*sa_restorer)(void);
};

/* ... */

#else

struct sigaction {
        __sighandler_t sa_handler;
        unsigned long sa_flags;
        __sigrestore_t sa_restorer;
        sigset_t sa_mask;               /* mask last for extensibility */
};

#endif

What do the manpages say is required for rt_sigaction to function on
your machine? Mine just says:

SYNOPSIS
       #include <signal.h>

       int sigaction(int signum, const struct sigaction *act,
                     struct sigaction *oldact);

   Feature Test Macro Requirements for glibc (see feature_test_macros(7)):

       sigaction(): _POSIX_C_SOURCE >=3D 1 || _XOPEN_SOURCE || _POSIX_SOURCE

>> =A0 =A0 However, on arch x86_64, if we directly get to call rt_sigaction,
>> the argument "sa_restorer" will not be fulfilled, and this will lead
>> =A0to segment fault.
>> =A0 =A0 on arch x86_64, if sa_restorer is not set, kernel will lead to s=
egment fault.
>> In other arch, if sa_restorer is not set, kernel can do the correct work.
>> =A0 =A0 To avoid this segment fault, we use glibc function
>> "int sigaction(...);" instead, which can fulfill the argument "sa_restor=
er".
>>
>> 2) rt_sigprocmask
>> =A0 =A0 This failure contains two aspects,
>> the first is the segment fault as described in 1),
>> the second is that testcase uses a unknown signal 33 for test,
>> and this will lead sigaction cannot bind signal 33 to the action.
>>
>> =A0 =A0 So, we attempt to use a known signal instead, such as 34.
>>
>>
>
> =A0I am sure signal 32 and 33 cannot be used in rt_sigprocmask test
> =A0on arch x86_64, but I'm not sure which signal else should be used
> =A0here, Is there anyone can provide suggestions?

RT signals are all signals above SIGRTMIN (typically 32+, but not
always), up to SIGRTMAX (usually 64, but on mips it's 128). So... why
is setting the signal number to anywhere between SIGRTMIN and SIGRTMAX
unacceptable?

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
