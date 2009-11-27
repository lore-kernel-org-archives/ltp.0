Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NDueb-0001vk-1t
	for ltp-list@lists.sourceforge.net; Fri, 27 Nov 2009 06:50:05 +0000
Received: from mail-px0-f185.google.com ([209.85.216.185])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NDueW-00005f-B3
	for ltp-list@lists.sourceforge.net; Fri, 27 Nov 2009 06:50:04 +0000
MIME-Version: 1.0
In-Reply-To: <4B0F64B7.6060507@cn.fujitsu.com>
References: <4AF93496.3030408@cn.fujitsu.com>
	<200911102333.55526.vapier@gentoo.org>
	<4AFA45B0.7070608@cn.fujitsu.com>
	<1258359225.5677.35.camel@subratamodak.linux.ibm.com>
	<4B0112EC.9020202@cn.fujitsu.com>
	<364299f40911260311m6d157453s47f57d1ba47ef643@mail.gmail.com>
	<4B0F64B7.6060507@cn.fujitsu.com>
Date: Thu, 26 Nov 2009 22:49:54 -0800
Message-ID: <364299f40911262249x1d48a61fh7528216fd18bcf57@mail.gmail.com>
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
Cc: Mike Frysinger <vapier@gentoo.org>, ltp-list <ltp-list@lists.sf.net>

On Thu, Nov 26, 2009 at 9:33 PM, liubo <liubo2009@cn.fujitsu.com> wrote:
> Hi, Garrett
> On 11/26/2009 07:11 PM, Garrett Cooper wrote:
>
> On Mon, Nov 16, 2009 at 12:53 AM, liubo <liubo2009@cn.fujitsu.com> wrote:
>
>
> Hi, Subrata,
> On 11/16/2009 04:13 PM, Subrata Modak wrote:
>
> Liubo,
>
> Are you sending an updated patch post this discussion ?
>
>
>
> Yes, I'll resend a updated patch about these rt_sigs.
>
> Regards--
> Liubo
>
> Regards--
> Subrata
>
> On Wed, 2009-11-11 at 13:03 +0800, Wei Yongjun wrote:
>
>
> Mike Frysinger wrote:
>
>
> On Tuesday 10 November 2009 04:38:30 liubo wrote:
>
>
>
> 1) rt_sigaction
>     "sigaction" has the structure:
>
>  struct sigaction {
>          __sighandler_t sa_handler;
>          unsigned long sa_flags;
>   #ifdef SA_RESTORER
>           __sigrestore_t sa_restorer;
>   #endif
>           sigset_t sa_mask;               /* mask last for extensibility =
*/
>  };
>
>     However, on arch x86_64, if we directly get to call rt_sigaction,
> the argument "sa_restorer" will not be fulfilled, and this will lead
>  to segment fault.
>     on arch x86_64, if sa_restorer is not set, kernel will lead to segment
>  fault. In other arch, if sa_restorer is not set, kernel can do the corre=
ct
>  work. To avoid this segment fault, we use glibc function
> "int sigaction(...);" instead, which can fulfill the argument
>  "sa_restorer".
>
>
>
> which defeats the purpose of the test.  there is no guarantee that the C
> library sigaction function is implemented via the __NR_rt_sigaction sysca=
ll.
>
>
>
> In x86_64, it do this. And If we want to use __NR_rt_sigaction syscall
> directly, we must fill the sa_restorer and set the RESTORER flag to
> sa_mask. If we do not set the sa_restorer, kill will always cause
> segment fault.
>
>
>
>
>
>
> 2) rt_sigprocmask
>     This failure contains two aspects,
> the first is the segment fault as described in 1),
> the second is that testcase uses a unknown signal 33 for test,
> and this will lead sigaction cannot bind signal 33 to the action.
>
>     So, we attempt to use a known signal instead, such as 34.
>
>
>
> which is just as bogus and unportable.  if the test needs a real time
> signal,
> it should leverage the sigrtmin...sigrtmax defines.
> -mike
>
>
> I see what you mean about this testcase segfaulting now.
>
> I've done some exploring, and while sigaction does map to rt_sigaction
> on ia64 and x86_64, it won't on arm, mips, s390*, sh, or x86.
>
> Furthermore, the problem is actually being caused by the fact that
> we're not even calling sigaddset properly!
>
> gcooper@orangebox
> /scratch/ltp-dev2/ltp/testcases/kernel/syscalls/rt_sigaction $ gdb
> ./rt_sigaction01
> GNU gdb 6.8
> Copyright (C) 2008 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later
> <http://gnu.org/licenses/gpl.html>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
> and "show warranty" for details.
> This GDB was configured as "x86_64-pc-linux-gnu"...
> (gdb) c
> The program is not being run.
> (gdb) r
> Starting program:
> /scratch/ltp-dev2/ltp/testcases/kernel/syscalls/rt_sigaction/rt_sigaction=
01
> thread:20
> [Thread debugging using libthread_db enabled]
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01    1  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01    2  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01    3  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01    4  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01    5  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01    6  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01    7  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01    8  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01    9  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   10  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   11  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   12  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   13  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   14  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   15  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   16  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   17  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   18  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   19  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   20  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   21  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   22  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   23  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   24  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   25  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   26  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   27  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   28  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   29  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   30  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
>
> So, the test needs fixing, anyhow. After I fixed it, the test still
> segfaulted >:( --
>
> gcooper@orangebox
> /scratch/ltp-dev2/ltp/testcases/kernel/syscalls/rt_sigaction $ gdb
> ./rt_sigaction01
> GNU gdb 6.8
> Copyright (C) 2008 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later
> <http://gnu.org/licenses/gpl.html>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
> and "show warranty" for details.
> This GDB was configured as "x86_64-pc-linux-gnu"...
> (gdb) r
> Starting program:
> /scratch/ltp-dev2/ltp/testcases/kernel/syscalls/rt_sigaction/rt_sigaction=
01
> thread:20
> [Thread debugging using libthread_db enabled]
> rt_sigaction01    0  TINFO  :  signal: 34
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> [New Thread 0x7fdd451d66f0 (LWP 31927)]
>
> Program received signal SIG34, Real-time event 34.
> [Switching to Thread 0x7fdd451d66f0 (LWP 31927)]
> 0x00007fdd448944f7 in kill () from /lib/libc.so.6
> (gdb) c
> Continuing.
>
> Program received signal SIGSEGV, Segmentation fault.
> 0x00007fdd448944f7 in kill () from /lib/libc.so.6
>
> So I tried to do some digging. glibc 2.8-20080602 does the following
> for alpha, i386, and sysv:
>
>       result =3D INLINE_SYSCALL (rt_sigaction, 4,
>                                sig, act ? __ptrvalue (&kact) : NULL,
>                                oact ? __ptrvalue (&koact) : NULL, _NSIG /
> 8);
>
> The kernel code for rt_sigaction in kernel/signal.c is as follows:
>
> #ifdef __ARCH_WANT_SYS_RT_SIGACTION
> SYSCALL_DEFINE4(rt_sigaction, int, sig,
>                 const struct sigaction __user *, act,
>                 struct sigaction __user *, oact,
>                 size_t, sigsetsize)
> {
>         struct k_sigaction new_sa, old_sa;
>         int ret =3D -EINVAL;
>
>         /* XXX: Don't preclude handling different sized sigset_t's.  */
>         if (sigsetsize !=3D sizeof(sigset_t))
>                 goto out;
>
>         if (act) {
>                 if (copy_from_user(&new_sa.sa, act, sizeof(new_sa.sa)))
>                         return -EFAULT;
>         }
>
>         ret =3D do_sigaction(sig, act ? &new_sa : NULL, oact ? &old_sa :
> NULL);
>
>         if (!ret && oact) {
>                 if (copy_to_user(oact, &old_sa.sa, sizeof(old_sa.sa)))
>                         return -EFAULT;
>         }
> out:
>         return ret;
> }
>
> This just blows my mind because rt_sigaction is just calling
> do_sigaction, which is the same code as sigaction AFAICT, apart from
> the fact that rt_sigaction completely disregards sa_restorer on some
> architectures because it's obsolete, and requires the end-user to
> specify a signal mask set (here's mips' version, which wasn't the same
> as i386's version -- i386 had the old sa_restorer code):
>
> SYSCALL_DEFINE3(sigaction, int, sig, const struct sigaction __user *, act,
>         struct sigaction __user *, oact)
> {
>         struct k_sigaction new_ka, old_ka;
>         int ret;
>         int err =3D 0;
>
>         if (act) {
>                 old_sigset_t mask;
>
>                 if (!access_ok(VERIFY_READ, act, sizeof(*act)))
>                         return -EFAULT;
>                 err |=3D __get_user(new_ka.sa.sa_handler, &act->sa_handle=
r);
>                 err |=3D __get_user(new_ka.sa.sa_flags, &act->sa_flags);
>                 err |=3D __get_user(mask, &act->sa_mask.sig[0]);
>                 if (err)
>                         return -EFAULT;
>
>                 siginitset(&new_ka.sa.sa_mask, mask);
>         }
>
>         ret =3D do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka :
> NULL);
>
>         if (!ret && oact) {
>                 if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)))
>                         return -EFAULT;
>                 err |=3D __put_user(old_ka.sa.sa_flags, &oact->sa_flags);
>                 err |=3D __put_user(old_ka.sa.sa_handler, &oact->sa_handl=
er);
>                 err |=3D __put_user(old_ka.sa.sa_mask.sig[0],
> oact->sa_mask.sig);
>                 err |=3D __put_user(0, &oact->sa_mask.sig[1]);
>                 err |=3D __put_user(0, &oact->sa_mask.sig[2]);
>                 err |=3D __put_user(0, &oact->sa_mask.sig[3]);
>                 if (err)
>                         return -EFAULT;
>         }
>
>         return ret;
> }
>
> I dunno -- maybe someone else can read the kernel code better than me,
> but it looks like there's zero real value to the rt_sigaction
> testcases, because it can be covered by sigaction...
>
>
>
> =A0=A0=A0 We just tell guys who use these testcases on arch x86_64 that
> =A0=A0=A0 "Syscall rt_sigaction cannot be called directly on arch x86_64.=
",
> =A0=A0=A0 can we?

    It's not just x86_64 -- it's also ia64, and this may change
depending on the version of glibc and linux sources, so... this really
isn't a viable solution IMO.
    Does anyone have any better suggestions, apart from just using a
preprocessor macro that would execute rt_sig* via their non-rt
equivalents in ltp_signal.h?
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
