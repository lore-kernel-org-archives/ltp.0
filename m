Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NE99G-00065Z-GO
	for ltp-list@lists.sourceforge.net; Fri, 27 Nov 2009 22:18:42 +0000
Received: from mail-pw0-f48.google.com ([209.85.160.48])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NE99A-00050r-8V
	for ltp-list@lists.sourceforge.net; Fri, 27 Nov 2009 22:18:42 +0000
MIME-Version: 1.0
In-Reply-To: <4B0FA4E9.1070206@cn.fujitsu.com>
References: <4AF93496.3030408@cn.fujitsu.com>
	<200911102333.55526.vapier@gentoo.org>
	<4AFA45B0.7070608@cn.fujitsu.com>
	<1258359225.5677.35.camel@subratamodak.linux.ibm.com>
	<4B0112EC.9020202@cn.fujitsu.com>
	<364299f40911260311m6d157453s47f57d1ba47ef643@mail.gmail.com>
	<4B0F64B7.6060507@cn.fujitsu.com>
	<364299f40911262249x1d48a61fh7528216fd18bcf57@mail.gmail.com>
	<364299f40911270050q53743fbdte8b98170e135b4ae@mail.gmail.com>
	<4B0FA4E9.1070206@cn.fujitsu.com>
Date: Fri, 27 Nov 2009 14:18:30 -0800
Message-ID: <364299f40911271418y58264d77w3849d83f8deaa441@mail.gmail.com>
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

On Fri, Nov 27, 2009 at 2:07 AM, liubo <liubo2009@cn.fujitsu.com> wrote:
> Hi, Garrett
>
> On 11/27/2009 04:50 PM, Garrett Cooper wrote:
>
> On Thu, Nov 26, 2009 at 10:49 PM, Garrett Cooper <yanegomi@gmail.com> wro=
te:
>
>
> On Thu, Nov 26, 2009 at 9:33 PM, liubo <liubo2009@cn.fujitsu.com> wrote:
>
>
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
> =A0 =A0 "sigaction" has the structure:
>
> =A0struct sigaction {
> =A0 =A0 =A0 =A0 =A0__sighandler_t sa_handler;
> =A0 =A0 =A0 =A0 =A0unsigned long sa_flags;
> =A0 #ifdef SA_RESTORER
> =A0 =A0 =A0 =A0 =A0 __sigrestore_t sa_restorer;
> =A0 #endif
> =A0 =A0 =A0 =A0 =A0 sigset_t sa_mask; =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* mask=
 last for extensibility */
> =A0};
>
> =A0 =A0 However, on arch x86_64, if we directly get to call rt_sigaction,
> the argument "sa_restorer" will not be fulfilled, and this will lead
> =A0to segment fault.
> =A0 =A0 on arch x86_64, if sa_restorer is not set, kernel will lead to se=
gment
> =A0fault. In other arch, if sa_restorer is not set, kernel can do the cor=
rect
> =A0work. To avoid this segment fault, we use glibc function
> "int sigaction(...);" instead, which can fulfill the argument
> =A0"sa_restorer".
>
>
>
> which defeats the purpose of the test. =A0there is no guarantee that the C
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
> =A0 =A0 This failure contains two aspects,
> the first is the segment fault as described in 1),
> the second is that testcase uses a unknown signal 33 for test,
> and this will lead sigaction cannot bind signal 33 to the action.
>
> =A0 =A0 So, we attempt to use a known signal instead, such as 34.
>
>
>
> which is just as bogus and unportable. =A0if the test needs a real time
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
> There is NO WARRANTY, to the extent permitted by law. =A0Type "show copyi=
ng"
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
> rt_sigaction01 =A0 =A00 =A0TINFO =A0: =A0sigaddset(..) failed
> rt_sigaction01 =A0 =A01 =A0TFAIL =A0: =A0rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01 =A0 =A00 =A0TINFO =A0: =A0sigaddset(..) failed
> rt_sigaction01 =A0 =A02 =A0TFAIL =A0: =A0rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01 =A0 =A00 =A0TINFO =A0: =A0sigaddset(..) failed
> rt_sigaction01 =A0 =A03 =A0TFAIL =A0: =A0rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01 =A0 =A00 =A0TINFO =A0: =A0sigaddset(..) failed
> rt_sigaction01 =A0 =A04 =A0TFAIL =A0: =A0rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01 =A0 =A00 =A0TINFO =A0: =A0sigaddset(..) failed
> rt_sigaction01 =A0 =A05 =A0TFAIL =A0: =A0rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01 =A0 =A00 =A0TINFO =A0: =A0sigaddset(..) failed
> rt_sigaction01 =A0 =A06 =A0TFAIL =A0: =A0rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01 =A0 =A00 =A0TINFO =A0: =A0sigaddset(..) failed
> rt_sigaction01 =A0 =A07 =A0TFAIL =A0: =A0rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01 =A0 =A00 =A0TINFO =A0: =A0sigaddset(..) failed
> rt_sigaction01 =A0 =A08 =A0TFAIL =A0: =A0rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01 =A0 =A00 =A0TINFO =A0: =A0sigaddset(..) failed
> rt_sigaction01 =A0 =A09 =A0TFAIL =A0: =A0rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01 =A0 =A00 =A0TINFO =A0: =A0sigaddset(..) failed
> rt_sigaction01 =A0 10 =A0TFAIL =A0: =A0rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01 =A0 =A00 =A0TINFO =A0: =A0sigaddset(..) failed
> rt_sigaction01 =A0 11 =A0TFAIL =A0: =A0rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01 =A0 =A00 =A0TINFO =A0: =A0sigaddset(..) failed
> rt_sigaction01 =A0 12 =A0TFAIL =A0: =A0rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01 =A0 =A00 =A0TINFO =A0: =A0sigaddset(..) failed
> rt_sigaction01 =A0 13 =A0TFAIL =A0: =A0rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01 =A0 =A00 =A0TINFO =A0: =A0sigaddset(..) failed
> rt_sigaction01 =A0 14 =A0TFAIL =A0: =A0rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01 =A0 =A00 =A0TINFO =A0: =A0sigaddset(..) failed
> rt_sigaction01 =A0 15 =A0TFAIL =A0: =A0rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01 =A0 =A00 =A0TINFO =A0: =A0sigaddset(..) failed
> rt_sigaction01 =A0 16 =A0TFAIL =A0: =A0rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01 =A0 =A00 =A0TINFO =A0: =A0sigaddset(..) failed
> rt_sigaction01 =A0 17 =A0TFAIL =A0: =A0rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01 =A0 =A00 =A0TINFO =A0: =A0sigaddset(..) failed
> rt_sigaction01 =A0 18 =A0TFAIL =A0: =A0rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01 =A0 =A00 =A0TINFO =A0: =A0sigaddset(..) failed
> rt_sigaction01 =A0 19 =A0TFAIL =A0: =A0rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01 =A0 =A00 =A0TINFO =A0: =A0sigaddset(..) failed
> rt_sigaction01 =A0 20 =A0TFAIL =A0: =A0rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01 =A0 =A00 =A0TINFO =A0: =A0sigaddset(..) failed
> rt_sigaction01 =A0 21 =A0TFAIL =A0: =A0rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01 =A0 =A00 =A0TINFO =A0: =A0sigaddset(..) failed
> rt_sigaction01 =A0 22 =A0TFAIL =A0: =A0rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01 =A0 =A00 =A0TINFO =A0: =A0sigaddset(..) failed
> rt_sigaction01 =A0 23 =A0TFAIL =A0: =A0rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01 =A0 =A00 =A0TINFO =A0: =A0sigaddset(..) failed
> rt_sigaction01 =A0 24 =A0TFAIL =A0: =A0rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01 =A0 =A00 =A0TINFO =A0: =A0sigaddset(..) failed
> rt_sigaction01 =A0 25 =A0TFAIL =A0: =A0rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01 =A0 =A00 =A0TINFO =A0: =A0sigaddset(..) failed
> rt_sigaction01 =A0 26 =A0TFAIL =A0: =A0rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01 =A0 =A00 =A0TINFO =A0: =A0sigaddset(..) failed
> rt_sigaction01 =A0 27 =A0TFAIL =A0: =A0rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01 =A0 =A00 =A0TINFO =A0: =A0sigaddset(..) failed
> rt_sigaction01 =A0 28 =A0TFAIL =A0: =A0rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01 =A0 =A00 =A0TINFO =A0: =A0sigaddset(..) failed
> rt_sigaction01 =A0 29 =A0TFAIL =A0: =A0rt_sigaction01 failed:
> TEST_ERRNO=3DEINVAL(22): Invalid argument
> rt_sigaction01 =A0 =A00 =A0TINFO =A0: =A0sigaddset(..) failed
> rt_sigaction01 =A0 30 =A0TFAIL =A0: =A0rt_sigaction01 failed:
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
> There is NO WARRANTY, to the extent permitted by law. =A0Type "show copyi=
ng"
> and "show warranty" for details.
> This GDB was configured as "x86_64-pc-linux-gnu"...
> (gdb) r
> Starting program:
> /scratch/ltp-dev2/ltp/testcases/kernel/syscalls/rt_sigaction/rt_sigaction=
01
> thread:20
> [Thread debugging using libthread_db enabled]
> rt_sigaction01 =A0 =A00 =A0TINFO =A0: =A0signal: 34
> rt_sigaction01 =A0 =A00 =A0TINFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_=
SIGINFO
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
> =A0 =A0 =A0 result =3D INLINE_SYSCALL (rt_sigaction, 4,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sig, act ?=
 __ptrvalue (&kact) : NULL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0oact ? __p=
trvalue (&koact) : NULL, _NSIG /
> 8);
>
> The kernel code for rt_sigaction in kernel/signal.c is as follows:
>
> #ifdef __ARCH_WANT_SYS_RT_SIGACTION
> SYSCALL_DEFINE4(rt_sigaction, int, sig,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct sigaction __user *, act,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct sigaction __user *, oact,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 size_t, sigsetsize)
> {
> =A0 =A0 =A0 =A0 struct k_sigaction new_sa, old_sa;
> =A0 =A0 =A0 =A0 int ret =3D -EINVAL;
>
> =A0 =A0 =A0 =A0 /* XXX: Don't preclude handling different sized sigset_t'=
s. =A0*/
> =A0 =A0 =A0 =A0 if (sigsetsize !=3D sizeof(sigset_t))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>
> =A0 =A0 =A0 =A0 if (act) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (copy_from_user(&new_sa.sa, act, sizeo=
f(new_sa.sa)))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
> =A0 =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0 ret =3D do_sigaction(sig, act ? &new_sa : NULL, oact ? &o=
ld_sa :
> NULL);
>
> =A0 =A0 =A0 =A0 if (!ret && oact) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (copy_to_user(oact, &old_sa.sa, sizeof=
(old_sa.sa)))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
> =A0 =A0 =A0 =A0 }
> out:
> =A0 =A0 =A0 =A0 return ret;
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
> =A0 =A0 =A0 =A0 struct sigaction __user *, oact)
> {
> =A0 =A0 =A0 =A0 struct k_sigaction new_ka, old_ka;
> =A0 =A0 =A0 =A0 int ret;
> =A0 =A0 =A0 =A0 int err =3D 0;
>
> =A0 =A0 =A0 =A0 if (act) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 old_sigset_t mask;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!access_ok(VERIFY_READ, act, sizeof(*=
act)))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err |=3D __get_user(new_ka.sa.sa_handler,=
 &act->sa_handler);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err |=3D __get_user(new_ka.sa.sa_flags, &=
act->sa_flags);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err |=3D __get_user(mask, &act->sa_mask.s=
ig[0]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 siginitset(&new_ka.sa.sa_mask, mask);
> =A0 =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0 ret =3D do_sigaction(sig, act ? &new_ka : NULL, oact ? &o=
ld_ka :
> NULL);
>
> =A0 =A0 =A0 =A0 if (!ret && oact) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!access_ok(VERIFY_WRITE, oact, sizeof=
(*oact)))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err |=3D __put_user(old_ka.sa.sa_flags, &=
oact->sa_flags);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err |=3D __put_user(old_ka.sa.sa_handler,=
 &oact->sa_handler);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err |=3D __put_user(old_ka.sa.sa_mask.sig=
[0],
> oact->sa_mask.sig);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err |=3D __put_user(0, &oact->sa_mask.sig=
[1]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err |=3D __put_user(0, &oact->sa_mask.sig=
[2]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err |=3D __put_user(0, &oact->sa_mask.sig=
[3]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
> =A0 =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0 return ret;
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
>
>
> =A0 =A0It's not just x86_64 -- it's also ia64, and this may change
> depending on the version of glibc and linux sources, so... this really
> isn't a viable solution IMO.
> =A0 =A0Does anyone have any better suggestions, apart from just using a
> preprocessor macro that would execute rt_sig* via their non-rt
> equivalents in ltp_signal.h?
>
>
> AHA! I think I discovered the kernel bug. rt_sigaction on x86_64
> assumes that you're working in 32-bit space:
>
> gcooper@orangebox /usr/src/linux $ grep -r rt_sigaction
> /usr/src/linux/arch/x86*
> /usr/src/linux/arch/x86/ia32/sys_ia32.c:asmlinkage long
> sys32_rt_sigaction(int sig, struct sigaction32 __user *act,
> Binary file /usr/src/linux/arch/x86/ia32/sys_ia32.o matches
> Binary file /usr/src/linux/arch/x86/ia32/built-in.o matches
> /usr/src/linux/arch/x86/ia32/ia32entry.S:       .quad sys32_rt_sigaction
> Binary file /usr/src/linux/arch/x86/ia32/ia32entry.o matches
> Binary file /usr/src/linux/arch/x86/kernel/syscall_64.o matches
> Binary file /usr/src/linux/arch/x86/kernel/built-in.o matches
> /usr/src/linux/arch/x86/kernel/syscall_table_32.S:      .long
> sys_rt_sigaction
> /usr/src/linux/arch/x86/include/asm/unistd_32.h:#define
> __NR_rt_sigaction       174
> /usr/src/linux/arch/x86/include/asm/unistd_64.h:#define
> __NR_rt_sigaction                       13
> /usr/src/linux/arch/x86/include/asm/unistd_64.h:__SYSCALL(__NR_rt_sigacti=
on,
> sys_rt_sigaction)
> /usr/src/linux/arch/x86/include/asm/sys_ia32.h:asmlinkage long
> sys32_rt_sigaction(int, struct sigaction32 __user *,
>
> Watch (compiled with -m32):
>
> rt_sigaction01    0  TINFO  :  signal: 34
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 34
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 34
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 34
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 34
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 34
> rt_sigaction01    0  TINFO  :  signal: 35
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 35
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 35
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 35
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 35
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 35
> rt_sigaction01    0  TINFO  :  signal: 36
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 36
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 36
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 36
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 36
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 36
> rt_sigaction01    0  TINFO  :  signal: 37
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 37
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 37
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 37
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 37
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 37
> rt_sigaction01    0  TINFO  :  signal: 38
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 38
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 38
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 38
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 38
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 38
> rt_sigaction01    0  TINFO  :  signal: 39
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 39
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 39
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 39
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 39
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 39
> rt_sigaction01    0  TINFO  :  signal: 40
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 40
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 40
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 40
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 40
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 40
> rt_sigaction01    0  TINFO  :  signal: 41
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 41
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 41
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 41
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 41
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 41
> rt_sigaction01    0  TINFO  :  signal: 42
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 42
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 42
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 42
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 42
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 42
> rt_sigaction01    0  TINFO  :  signal: 43
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 43
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 43
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 43
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 43
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 43
> rt_sigaction01    0  TINFO  :  signal: 44
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 44
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 44
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 44
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 44
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 44
> rt_sigaction01    0  TINFO  :  signal: 45
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 45
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 45
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 45
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 45
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 45
> rt_sigaction01    0  TINFO  :  signal: 46
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 46
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 46
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 46
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 46
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 46
> rt_sigaction01    0  TINFO  :  signal: 47
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 47
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 47
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 47
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 47
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 47
> rt_sigaction01    0  TINFO  :  signal: 48
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 48
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 48
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 48
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 48
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 48
> rt_sigaction01    0  TINFO  :  signal: 49
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 49
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 49
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 49
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 49
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 49
> rt_sigaction01    0  TINFO  :  signal: 50
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 50
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 50
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 50
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 50
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 50
> rt_sigaction01    0  TINFO  :  signal: 51
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 51
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 51
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 51
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 51
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 51
> rt_sigaction01    0  TINFO  :  signal: 52
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 52
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 52
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 52
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 52
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 52
> rt_sigaction01    0  TINFO  :  signal: 53
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 53
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 53
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 53
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 53
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 53
> rt_sigaction01    0  TINFO  :  signal: 54
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 54
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 54
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 54
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 54
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 54
> rt_sigaction01    0  TINFO  :  signal: 55
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 55
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 55
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 55
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 55
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 55
> rt_sigaction01    0  TINFO  :  signal: 56
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 56
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 56
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 56
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 56
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 56
> rt_sigaction01    0  TINFO  :  signal: 57
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 57
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 57
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 57
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 57
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 57
> rt_sigaction01    0  TINFO  :  signal: 58
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 58
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 58
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 58
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 58
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 58
> rt_sigaction01    0  TINFO  :  signal: 59
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 59
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 59
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 59
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 59
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 59
> rt_sigaction01    0  TINFO  :  signal: 60
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 60
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 60
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 60
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 60
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 60
> rt_sigaction01    0  TINFO  :  signal: 61
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 61
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 61
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 61
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 61
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 61
> rt_sigaction01    0  TINFO  :  signal: 62
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 62
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 62
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 62
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 62
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 62
> rt_sigaction01    0  TINFO  :  signal: 63
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 63
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 63
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 63
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 63
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 63
> rt_sigaction01    0  TINFO  :  signal: 64
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 64
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 64
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 64
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 64
> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 64
>
> So from what I can tell, the sucker isn't properly translating
> something in 64-bit space, and instead of properly trapping the issue,
> it's segfaulting and dying -_-.
>
> Ultimately the problem from what I can see is that bi-arch (32-bit on
> 64-bit kernel) 64-bit rt_sig* support is broken. I don't know about
> straight, non-bi-arch 64-bit rt_sig* support...
>
> If someone could verify this with a little more kernel experience, or
> someone could direct me on how the issue could be trapped in gdb so I
> could inspect the registers and ensure the traps are or aren't being
> done properly, that would be helpful.
>
>
>
> Although I had figured this, I think your solution is just a compromise,
> isn't it?
> Change 64-bit rt_sigaction to 32-bit rt_sigaction to pass the testcase.
> Let's try to use 64bit rt_sigaction to pass it. ^_^

Luibo,
    It isn't really a compromise -- it's an observation of what I
consider broken functionality in the 32-bit <-> 64-bit translation
layers in the kernel ;)... 32-bit and 64-bit rt_sigaction should
function equivalently, but they don't today.
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
