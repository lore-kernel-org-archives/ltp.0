Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <liubo2009@cn.fujitsu.com>) id 1NDxjV-0003cL-7K
	for ltp-list@lists.sourceforge.net; Fri, 27 Nov 2009 10:07:21 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NDxjN-0007GB-2Z
	for ltp-list@lists.sourceforge.net; Fri, 27 Nov 2009 10:07:21 +0000
Message-ID: <4B0FA4E9.1070206@cn.fujitsu.com>
Date: Fri, 27 Nov 2009 18:07:37 +0800
From: liubo <liubo2009@cn.fujitsu.com>
MIME-Version: 1.0
References: <4AF93496.3030408@cn.fujitsu.com>	
	<200911102333.55526.vapier@gentoo.org>	
	<4AFA45B0.7070608@cn.fujitsu.com>	
	<1258359225.5677.35.camel@subratamodak.linux.ibm.com>	
	<4B0112EC.9020202@cn.fujitsu.com>	
	<364299f40911260311m6d157453s47f57d1ba47ef643@mail.gmail.com>	
	<4B0F64B7.6060507@cn.fujitsu.com>	
	<364299f40911262249x1d48a61fh7528216fd18bcf57@mail.gmail.com>
	<364299f40911270050q53743fbdte8b98170e135b4ae@mail.gmail.com>
In-Reply-To: <364299f40911270050q53743fbdte8b98170e135b4ae@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============3243571527156341501=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: Mike Frysinger <vapier@gentoo.org>, ltp-list <ltp-list@lists.sf.net>

This is a multi-part message in MIME format.
--===============3243571527156341501==
Content-Type: multipart/alternative;
	boundary="------------090901080506050605040503"

This is a multi-part message in MIME format.
--------------090901080506050605040503
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi, Garrett

On 11/27/2009 04:50 PM, Garrett Cooper wrote:
> On Thu, Nov 26, 2009 at 10:49 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
>   
>> On Thu, Nov 26, 2009 at 9:33 PM, liubo <liubo2009@cn.fujitsu.com> wrote:
>>     
>>> Hi, Garrett
>>> On 11/26/2009 07:11 PM, Garrett Cooper wrote:
>>>
>>> On Mon, Nov 16, 2009 at 12:53 AM, liubo <liubo2009@cn.fujitsu.com> wrote:
>>>
>>>
>>> Hi, Subrata,
>>> On 11/16/2009 04:13 PM, Subrata Modak wrote:
>>>
>>> Liubo,
>>>
>>> Are you sending an updated patch post this discussion ?
>>>
>>>
>>>
>>> Yes, I'll resend a updated patch about these rt_sigs.
>>>
>>> Regards--
>>> Liubo
>>>
>>> Regards--
>>> Subrata
>>>
>>> On Wed, 2009-11-11 at 13:03 +0800, Wei Yongjun wrote:
>>>
>>>
>>> Mike Frysinger wrote:
>>>
>>>
>>> On Tuesday 10 November 2009 04:38:30 liubo wrote:
>>>
>>>
>>>
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
>>>     However, on arch x86_64, if we directly get to call rt_sigaction,
>>> the argument "sa_restorer" will not be fulfilled, and this will lead
>>>  to segment fault.
>>>     on arch x86_64, if sa_restorer is not set, kernel will lead to segment
>>>  fault. In other arch, if sa_restorer is not set, kernel can do the correct
>>>  work. To avoid this segment fault, we use glibc function
>>> "int sigaction(...);" instead, which can fulfill the argument
>>>  "sa_restorer".
>>>
>>>
>>>
>>> which defeats the purpose of the test.  there is no guarantee that the C
>>> library sigaction function is implemented via the __NR_rt_sigaction syscall.
>>>
>>>
>>>
>>> In x86_64, it do this. And If we want to use __NR_rt_sigaction syscall
>>> directly, we must fill the sa_restorer and set the RESTORER flag to
>>> sa_mask. If we do not set the sa_restorer, kill will always cause
>>> segment fault.
>>>
>>>
>>>
>>>
>>>
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
>>> which is just as bogus and unportable.  if the test needs a real time
>>> signal,
>>> it should leverage the sigrtmin...sigrtmax defines.
>>> -mike
>>>
>>>
>>> I see what you mean about this testcase segfaulting now.
>>>
>>> I've done some exploring, and while sigaction does map to rt_sigaction
>>> on ia64 and x86_64, it won't on arm, mips, s390*, sh, or x86.
>>>
>>> Furthermore, the problem is actually being caused by the fact that
>>> we're not even calling sigaddset properly!
>>>
>>> gcooper@orangebox
>>> /scratch/ltp-dev2/ltp/testcases/kernel/syscalls/rt_sigaction $ gdb
>>> ./rt_sigaction01
>>> GNU gdb 6.8
>>> Copyright (C) 2008 Free Software Foundation, Inc.
>>> License GPLv3+: GNU GPL version 3 or later
>>> <http://gnu.org/licenses/gpl.html>
>>> This is free software: you are free to change and redistribute it.
>>> There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
>>> and "show warranty" for details.
>>> This GDB was configured as "x86_64-pc-linux-gnu"...
>>> (gdb) c
>>> The program is not being run.
>>> (gdb) r
>>> Starting program:
>>> /scratch/ltp-dev2/ltp/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01
>>> thread:20
>>> [Thread debugging using libthread_db enabled]
>>> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
>>> rt_sigaction01    1  TFAIL  :  rt_sigaction01 failed:
>>> TEST_ERRNO=EINVAL(22): Invalid argument
>>> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
>>> rt_sigaction01    2  TFAIL  :  rt_sigaction01 failed:
>>> TEST_ERRNO=EINVAL(22): Invalid argument
>>> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
>>> rt_sigaction01    3  TFAIL  :  rt_sigaction01 failed:
>>> TEST_ERRNO=EINVAL(22): Invalid argument
>>> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
>>> rt_sigaction01    4  TFAIL  :  rt_sigaction01 failed:
>>> TEST_ERRNO=EINVAL(22): Invalid argument
>>> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
>>> rt_sigaction01    5  TFAIL  :  rt_sigaction01 failed:
>>> TEST_ERRNO=EINVAL(22): Invalid argument
>>> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
>>> rt_sigaction01    6  TFAIL  :  rt_sigaction01 failed:
>>> TEST_ERRNO=EINVAL(22): Invalid argument
>>> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
>>> rt_sigaction01    7  TFAIL  :  rt_sigaction01 failed:
>>> TEST_ERRNO=EINVAL(22): Invalid argument
>>> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
>>> rt_sigaction01    8  TFAIL  :  rt_sigaction01 failed:
>>> TEST_ERRNO=EINVAL(22): Invalid argument
>>> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
>>> rt_sigaction01    9  TFAIL  :  rt_sigaction01 failed:
>>> TEST_ERRNO=EINVAL(22): Invalid argument
>>> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
>>> rt_sigaction01   10  TFAIL  :  rt_sigaction01 failed:
>>> TEST_ERRNO=EINVAL(22): Invalid argument
>>> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
>>> rt_sigaction01   11  TFAIL  :  rt_sigaction01 failed:
>>> TEST_ERRNO=EINVAL(22): Invalid argument
>>> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
>>> rt_sigaction01   12  TFAIL  :  rt_sigaction01 failed:
>>> TEST_ERRNO=EINVAL(22): Invalid argument
>>> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
>>> rt_sigaction01   13  TFAIL  :  rt_sigaction01 failed:
>>> TEST_ERRNO=EINVAL(22): Invalid argument
>>> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
>>> rt_sigaction01   14  TFAIL  :  rt_sigaction01 failed:
>>> TEST_ERRNO=EINVAL(22): Invalid argument
>>> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
>>> rt_sigaction01   15  TFAIL  :  rt_sigaction01 failed:
>>> TEST_ERRNO=EINVAL(22): Invalid argument
>>> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
>>> rt_sigaction01   16  TFAIL  :  rt_sigaction01 failed:
>>> TEST_ERRNO=EINVAL(22): Invalid argument
>>> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
>>> rt_sigaction01   17  TFAIL  :  rt_sigaction01 failed:
>>> TEST_ERRNO=EINVAL(22): Invalid argument
>>> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
>>> rt_sigaction01   18  TFAIL  :  rt_sigaction01 failed:
>>> TEST_ERRNO=EINVAL(22): Invalid argument
>>> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
>>> rt_sigaction01   19  TFAIL  :  rt_sigaction01 failed:
>>> TEST_ERRNO=EINVAL(22): Invalid argument
>>> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
>>> rt_sigaction01   20  TFAIL  :  rt_sigaction01 failed:
>>> TEST_ERRNO=EINVAL(22): Invalid argument
>>> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
>>> rt_sigaction01   21  TFAIL  :  rt_sigaction01 failed:
>>> TEST_ERRNO=EINVAL(22): Invalid argument
>>> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
>>> rt_sigaction01   22  TFAIL  :  rt_sigaction01 failed:
>>> TEST_ERRNO=EINVAL(22): Invalid argument
>>> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
>>> rt_sigaction01   23  TFAIL  :  rt_sigaction01 failed:
>>> TEST_ERRNO=EINVAL(22): Invalid argument
>>> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
>>> rt_sigaction01   24  TFAIL  :  rt_sigaction01 failed:
>>> TEST_ERRNO=EINVAL(22): Invalid argument
>>> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
>>> rt_sigaction01   25  TFAIL  :  rt_sigaction01 failed:
>>> TEST_ERRNO=EINVAL(22): Invalid argument
>>> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
>>> rt_sigaction01   26  TFAIL  :  rt_sigaction01 failed:
>>> TEST_ERRNO=EINVAL(22): Invalid argument
>>> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
>>> rt_sigaction01   27  TFAIL  :  rt_sigaction01 failed:
>>> TEST_ERRNO=EINVAL(22): Invalid argument
>>> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
>>> rt_sigaction01   28  TFAIL  :  rt_sigaction01 failed:
>>> TEST_ERRNO=EINVAL(22): Invalid argument
>>> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
>>> rt_sigaction01   29  TFAIL  :  rt_sigaction01 failed:
>>> TEST_ERRNO=EINVAL(22): Invalid argument
>>> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
>>> rt_sigaction01   30  TFAIL  :  rt_sigaction01 failed:
>>> TEST_ERRNO=EINVAL(22): Invalid argument
>>>
>>> So, the test needs fixing, anyhow. After I fixed it, the test still
>>> segfaulted >:( --
>>>
>>> gcooper@orangebox
>>> /scratch/ltp-dev2/ltp/testcases/kernel/syscalls/rt_sigaction $ gdb
>>> ./rt_sigaction01
>>> GNU gdb 6.8
>>> Copyright (C) 2008 Free Software Foundation, Inc.
>>> License GPLv3+: GNU GPL version 3 or later
>>> <http://gnu.org/licenses/gpl.html>
>>> This is free software: you are free to change and redistribute it.
>>> There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
>>> and "show warranty" for details.
>>> This GDB was configured as "x86_64-pc-linux-gnu"...
>>> (gdb) r
>>> Starting program:
>>> /scratch/ltp-dev2/ltp/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01
>>> thread:20
>>> [Thread debugging using libthread_db enabled]
>>> rt_sigaction01    0  TINFO  :  signal: 34
>>> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
>>> [New Thread 0x7fdd451d66f0 (LWP 31927)]
>>>
>>> Program received signal SIG34, Real-time event 34.
>>> [Switching to Thread 0x7fdd451d66f0 (LWP 31927)]
>>> 0x00007fdd448944f7 in kill () from /lib/libc.so.6
>>> (gdb) c
>>> Continuing.
>>>
>>> Program received signal SIGSEGV, Segmentation fault.
>>> 0x00007fdd448944f7 in kill () from /lib/libc.so.6
>>>
>>> So I tried to do some digging. glibc 2.8-20080602 does the following
>>> for alpha, i386, and sysv:
>>>
>>>       result = INLINE_SYSCALL (rt_sigaction, 4,
>>>                                sig, act ? __ptrvalue (&kact) : NULL,
>>>                                oact ? __ptrvalue (&koact) : NULL, _NSIG /
>>> 8);
>>>
>>> The kernel code for rt_sigaction in kernel/signal.c is as follows:
>>>
>>> #ifdef __ARCH_WANT_SYS_RT_SIGACTION
>>> SYSCALL_DEFINE4(rt_sigaction, int, sig,
>>>                 const struct sigaction __user *, act,
>>>                 struct sigaction __user *, oact,
>>>                 size_t, sigsetsize)
>>> {
>>>         struct k_sigaction new_sa, old_sa;
>>>         int ret = -EINVAL;
>>>
>>>         /* XXX: Don't preclude handling different sized sigset_t's.  */
>>>         if (sigsetsize != sizeof(sigset_t))
>>>                 goto out;
>>>
>>>         if (act) {
>>>                 if (copy_from_user(&new_sa.sa, act, sizeof(new_sa.sa)))
>>>                         return -EFAULT;
>>>         }
>>>
>>>         ret = do_sigaction(sig, act ? &new_sa : NULL, oact ? &old_sa :
>>> NULL);
>>>
>>>         if (!ret && oact) {
>>>                 if (copy_to_user(oact, &old_sa.sa, sizeof(old_sa.sa)))
>>>                         return -EFAULT;
>>>         }
>>> out:
>>>         return ret;
>>> }
>>>
>>> This just blows my mind because rt_sigaction is just calling
>>> do_sigaction, which is the same code as sigaction AFAICT, apart from
>>> the fact that rt_sigaction completely disregards sa_restorer on some
>>> architectures because it's obsolete, and requires the end-user to
>>> specify a signal mask set (here's mips' version, which wasn't the same
>>> as i386's version -- i386 had the old sa_restorer code):
>>>
>>> SYSCALL_DEFINE3(sigaction, int, sig, const struct sigaction __user *, act,
>>>         struct sigaction __user *, oact)
>>> {
>>>         struct k_sigaction new_ka, old_ka;
>>>         int ret;
>>>         int err = 0;
>>>
>>>         if (act) {
>>>                 old_sigset_t mask;
>>>
>>>                 if (!access_ok(VERIFY_READ, act, sizeof(*act)))
>>>                         return -EFAULT;
>>>                 err |= __get_user(new_ka.sa.sa_handler, &act->sa_handler);
>>>                 err |= __get_user(new_ka.sa.sa_flags, &act->sa_flags);
>>>                 err |= __get_user(mask, &act->sa_mask.sig[0]);
>>>                 if (err)
>>>                         return -EFAULT;
>>>
>>>                 siginitset(&new_ka.sa.sa_mask, mask);
>>>         }
>>>
>>>         ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka :
>>> NULL);
>>>
>>>         if (!ret && oact) {
>>>                 if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)))
>>>                         return -EFAULT;
>>>                 err |= __put_user(old_ka.sa.sa_flags, &oact->sa_flags);
>>>                 err |= __put_user(old_ka.sa.sa_handler, &oact->sa_handler);
>>>                 err |= __put_user(old_ka.sa.sa_mask.sig[0],
>>> oact->sa_mask.sig);
>>>                 err |= __put_user(0, &oact->sa_mask.sig[1]);
>>>                 err |= __put_user(0, &oact->sa_mask.sig[2]);
>>>                 err |= __put_user(0, &oact->sa_mask.sig[3]);
>>>                 if (err)
>>>                         return -EFAULT;
>>>         }
>>>
>>>         return ret;
>>> }
>>>
>>> I dunno -- maybe someone else can read the kernel code better than me,
>>> but it looks like there's zero real value to the rt_sigaction
>>> testcases, because it can be covered by sigaction...
>>>
>>>
>>>
>>>     We just tell guys who use these testcases on arch x86_64 that
>>>     "Syscall rt_sigaction cannot be called directly on arch x86_64.",
>>>     can we?
>>>       
>>    It's not just x86_64 -- it's also ia64, and this may change
>> depending on the version of glibc and linux sources, so... this really
>> isn't a viable solution IMO.
>>    Does anyone have any better suggestions, apart from just using a
>> preprocessor macro that would execute rt_sig* via their non-rt
>> equivalents in ltp_signal.h?
>>     
>
> AHA! I think I discovered the kernel bug. rt_sigaction on x86_64
> assumes that you're working in 32-bit space:
>
> gcooper@orangebox /usr/src/linux $ grep -r rt_sigaction /usr/src/linux/arch/x86*
> /usr/src/linux/arch/x86/ia32/sys_ia32.c:asmlinkage long
> sys32_rt_sigaction(int sig, struct sigaction32 __user *act,
> Binary file /usr/src/linux/arch/x86/ia32/sys_ia32.o matches
> Binary file /usr/src/linux/arch/x86/ia32/built-in.o matches
> /usr/src/linux/arch/x86/ia32/ia32entry.S:       .quad sys32_rt_sigaction
> Binary file /usr/src/linux/arch/x86/ia32/ia32entry.o matches
> Binary file /usr/src/linux/arch/x86/kernel/syscall_64.o matches
> Binary file /usr/src/linux/arch/x86/kernel/built-in.o matches
> /usr/src/linux/arch/x86/kernel/syscall_table_32.S:      .long sys_rt_sigaction
> /usr/src/linux/arch/x86/include/asm/unistd_32.h:#define
> __NR_rt_sigaction       174
> /usr/src/linux/arch/x86/include/asm/unistd_64.h:#define
> __NR_rt_sigaction                       13
> /usr/src/linux/arch/x86/include/asm/unistd_64.h:__SYSCALL(__NR_rt_sigaction,
> sys_rt_sigaction)
> /usr/src/linux/arch/x86/include/asm/sys_ia32.h:asmlinkage long
> sys32_rt_sigaction(int, struct sigaction32 __user *,
>
> Watch (compiled with -m32):
>
> rt_sigaction01    0  TINFO  :  signal: 34
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 34
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 34
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 34
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 34
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 34
> rt_sigaction01    0  TINFO  :  signal: 35
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 35
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 35
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 35
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 35
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 35
> rt_sigaction01    0  TINFO  :  signal: 36
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 36
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 36
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 36
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 36
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 36
> rt_sigaction01    0  TINFO  :  signal: 37
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 37
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 37
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 37
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 37
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 37
> rt_sigaction01    0  TINFO  :  signal: 38
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 38
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 38
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 38
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 38
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 38
> rt_sigaction01    0  TINFO  :  signal: 39
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 39
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 39
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 39
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 39
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 39
> rt_sigaction01    0  TINFO  :  signal: 40
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 40
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 40
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 40
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 40
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 40
> rt_sigaction01    0  TINFO  :  signal: 41
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 41
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 41
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 41
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 41
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 41
> rt_sigaction01    0  TINFO  :  signal: 42
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 42
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 42
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 42
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 42
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 42
> rt_sigaction01    0  TINFO  :  signal: 43
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 43
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 43
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 43
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 43
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 43
> rt_sigaction01    0  TINFO  :  signal: 44
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 44
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 44
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 44
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 44
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 44
> rt_sigaction01    0  TINFO  :  signal: 45
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 45
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 45
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 45
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 45
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 45
> rt_sigaction01    0  TINFO  :  signal: 46
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 46
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 46
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 46
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 46
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 46
> rt_sigaction01    0  TINFO  :  signal: 47
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 47
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 47
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 47
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 47
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 47
> rt_sigaction01    0  TINFO  :  signal: 48
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 48
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 48
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 48
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 48
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 48
> rt_sigaction01    0  TINFO  :  signal: 49
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 49
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 49
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 49
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 49
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 49
> rt_sigaction01    0  TINFO  :  signal: 50
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 50
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 50
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 50
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 50
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 50
> rt_sigaction01    0  TINFO  :  signal: 51
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 51
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 51
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 51
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 51
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 51
> rt_sigaction01    0  TINFO  :  signal: 52
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 52
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 52
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 52
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 52
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 52
> rt_sigaction01    0  TINFO  :  signal: 53
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 53
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 53
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 53
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 53
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 53
> rt_sigaction01    0  TINFO  :  signal: 54
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 54
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 54
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 54
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 54
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 54
> rt_sigaction01    0  TINFO  :  signal: 55
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 55
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 55
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 55
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 55
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 55
> rt_sigaction01    0  TINFO  :  signal: 56
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 56
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 56
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 56
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 56
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 56
> rt_sigaction01    0  TINFO  :  signal: 57
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 57
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 57
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 57
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 57
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 57
> rt_sigaction01    0  TINFO  :  signal: 58
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 58
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 58
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 58
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 58
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 58
> rt_sigaction01    0  TINFO  :  signal: 59
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 59
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 59
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 59
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 59
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 59
> rt_sigaction01    0  TINFO  :  signal: 60
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 60
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 60
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 60
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 60
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 60
> rt_sigaction01    0  TINFO  :  signal: 61
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 61
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 61
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 61
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 61
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 61
> rt_sigaction01    0  TINFO  :  signal: 62
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 62
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 62
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 62
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 62
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 62
> rt_sigaction01    0  TINFO  :  signal: 63
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 63
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 63
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 63
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 63
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 63
> rt_sigaction01    0  TINFO  :  signal: 64
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 64
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 64
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 64
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 64
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
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

Although I had figured this, I think your solution is just a compromise,
isn't it?
Change 64-bit rt_sigaction to 32-bit rt_sigaction to pass the testcase.
Let's try to use 64bit rt_sigaction to pass it. ^_^

Thanks~
Liubo

> Thanks!
> -Garrett
>
>
>   


--------------090901080506050605040503
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Hi, Garrett<br>
<br>
On 11/27/2009 04:50 PM, Garrett Cooper wrote:
<blockquote
 cite="mid:364299f40911270050q53743fbdte8b98170e135b4ae@mail.gmail.com"
 type="cite">
  <pre wrap="">On Thu, Nov 26, 2009 at 10:49 PM, Garrett Cooper <a class="moz-txt-link-rfc2396E" href="mailto:yanegomi@gmail.com">&lt;yanegomi@gmail.com&gt;</a> wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">On Thu, Nov 26, 2009 at 9:33 PM, liubo <a class="moz-txt-link-rfc2396E" href="mailto:liubo2009@cn.fujitsu.com">&lt;liubo2009@cn.fujitsu.com&gt;</a> wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">Hi, Garrett
On 11/26/2009 07:11 PM, Garrett Cooper wrote:

On Mon, Nov 16, 2009 at 12:53 AM, liubo <a class="moz-txt-link-rfc2396E" href="mailto:liubo2009@cn.fujitsu.com">&lt;liubo2009@cn.fujitsu.com&gt;</a> wrote:


Hi, Subrata,
On 11/16/2009 04:13 PM, Subrata Modak wrote:

Liubo,

Are you sending an updated patch post this discussion ?



Yes, I'll resend a updated patch about these rt_sigs.

Regards--
Liubo

Regards--
Subrata

On Wed, 2009-11-11 at 13:03 +0800, Wei Yongjun wrote:


Mike Frysinger wrote:


On Tuesday 10 November 2009 04:38:30 liubo wrote:



1) rt_sigaction
&nbsp; &nbsp; "sigaction" has the structure:

&nbsp;struct sigaction {
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;__sighandler_t sa_handler;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;unsigned long sa_flags;
&nbsp; #ifdef SA_RESTORER
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; __sigrestore_t sa_restorer;
&nbsp; #endif
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; sigset_t sa_mask; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* mask last for extensibility */
&nbsp;};

&nbsp; &nbsp; However, on arch x86_64, if we directly get to call rt_sigaction,
the argument "sa_restorer" will not be fulfilled, and this will lead
&nbsp;to segment fault.
&nbsp; &nbsp; on arch x86_64, if sa_restorer is not set, kernel will lead to segment
&nbsp;fault. In other arch, if sa_restorer is not set, kernel can do the correct
&nbsp;work. To avoid this segment fault, we use glibc function
"int sigaction(...);" instead, which can fulfill the argument
&nbsp;"sa_restorer".



which defeats the purpose of the test. &nbsp;there is no guarantee that the C
library sigaction function is implemented via the __NR_rt_sigaction syscall.



In x86_64, it do this. And If we want to use __NR_rt_sigaction syscall
directly, we must fill the sa_restorer and set the RESTORER flag to
sa_mask. If we do not set the sa_restorer, kill will always cause
segment fault.






2) rt_sigprocmask
&nbsp; &nbsp; This failure contains two aspects,
the first is the segment fault as described in 1),
the second is that testcase uses a unknown signal 33 for test,
and this will lead sigaction cannot bind signal 33 to the action.

&nbsp; &nbsp; So, we attempt to use a known signal instead, such as 34.



which is just as bogus and unportable. &nbsp;if the test needs a real time
signal,
it should leverage the sigrtmin...sigrtmax defines.
-mike


I see what you mean about this testcase segfaulting now.

I've done some exploring, and while sigaction does map to rt_sigaction
on ia64 and x86_64, it won't on arm, mips, s390*, sh, or x86.

Furthermore, the problem is actually being caused by the fact that
we're not even calling sigaddset properly!

gcooper@orangebox
/scratch/ltp-dev2/ltp/testcases/kernel/syscalls/rt_sigaction $ gdb
./rt_sigaction01
GNU gdb 6.8
Copyright (C) 2008 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later
<a class="moz-txt-link-rfc2396E" href="http://gnu.org/licenses/gpl.html">&lt;http://gnu.org/licenses/gpl.html&gt;</a>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law. &nbsp;Type "show copying"
and "show warranty" for details.
This GDB was configured as "x86_64-pc-linux-gnu"...
(gdb) c
The program is not being run.
(gdb) r
Starting program:
/scratch/ltp-dev2/ltp/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01
thread:20
[Thread debugging using libthread_db enabled]
rt_sigaction01 &nbsp; &nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;sigaddset(..) failed
rt_sigaction01 &nbsp; &nbsp;1 &nbsp;TFAIL &nbsp;: &nbsp;rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01 &nbsp; &nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;sigaddset(..) failed
rt_sigaction01 &nbsp; &nbsp;2 &nbsp;TFAIL &nbsp;: &nbsp;rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01 &nbsp; &nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;sigaddset(..) failed
rt_sigaction01 &nbsp; &nbsp;3 &nbsp;TFAIL &nbsp;: &nbsp;rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01 &nbsp; &nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;sigaddset(..) failed
rt_sigaction01 &nbsp; &nbsp;4 &nbsp;TFAIL &nbsp;: &nbsp;rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01 &nbsp; &nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;sigaddset(..) failed
rt_sigaction01 &nbsp; &nbsp;5 &nbsp;TFAIL &nbsp;: &nbsp;rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01 &nbsp; &nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;sigaddset(..) failed
rt_sigaction01 &nbsp; &nbsp;6 &nbsp;TFAIL &nbsp;: &nbsp;rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01 &nbsp; &nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;sigaddset(..) failed
rt_sigaction01 &nbsp; &nbsp;7 &nbsp;TFAIL &nbsp;: &nbsp;rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01 &nbsp; &nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;sigaddset(..) failed
rt_sigaction01 &nbsp; &nbsp;8 &nbsp;TFAIL &nbsp;: &nbsp;rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01 &nbsp; &nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;sigaddset(..) failed
rt_sigaction01 &nbsp; &nbsp;9 &nbsp;TFAIL &nbsp;: &nbsp;rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01 &nbsp; &nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;sigaddset(..) failed
rt_sigaction01 &nbsp; 10 &nbsp;TFAIL &nbsp;: &nbsp;rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01 &nbsp; &nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;sigaddset(..) failed
rt_sigaction01 &nbsp; 11 &nbsp;TFAIL &nbsp;: &nbsp;rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01 &nbsp; &nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;sigaddset(..) failed
rt_sigaction01 &nbsp; 12 &nbsp;TFAIL &nbsp;: &nbsp;rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01 &nbsp; &nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;sigaddset(..) failed
rt_sigaction01 &nbsp; 13 &nbsp;TFAIL &nbsp;: &nbsp;rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01 &nbsp; &nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;sigaddset(..) failed
rt_sigaction01 &nbsp; 14 &nbsp;TFAIL &nbsp;: &nbsp;rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01 &nbsp; &nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;sigaddset(..) failed
rt_sigaction01 &nbsp; 15 &nbsp;TFAIL &nbsp;: &nbsp;rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01 &nbsp; &nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;sigaddset(..) failed
rt_sigaction01 &nbsp; 16 &nbsp;TFAIL &nbsp;: &nbsp;rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01 &nbsp; &nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;sigaddset(..) failed
rt_sigaction01 &nbsp; 17 &nbsp;TFAIL &nbsp;: &nbsp;rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01 &nbsp; &nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;sigaddset(..) failed
rt_sigaction01 &nbsp; 18 &nbsp;TFAIL &nbsp;: &nbsp;rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01 &nbsp; &nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;sigaddset(..) failed
rt_sigaction01 &nbsp; 19 &nbsp;TFAIL &nbsp;: &nbsp;rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01 &nbsp; &nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;sigaddset(..) failed
rt_sigaction01 &nbsp; 20 &nbsp;TFAIL &nbsp;: &nbsp;rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01 &nbsp; &nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;sigaddset(..) failed
rt_sigaction01 &nbsp; 21 &nbsp;TFAIL &nbsp;: &nbsp;rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01 &nbsp; &nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;sigaddset(..) failed
rt_sigaction01 &nbsp; 22 &nbsp;TFAIL &nbsp;: &nbsp;rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01 &nbsp; &nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;sigaddset(..) failed
rt_sigaction01 &nbsp; 23 &nbsp;TFAIL &nbsp;: &nbsp;rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01 &nbsp; &nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;sigaddset(..) failed
rt_sigaction01 &nbsp; 24 &nbsp;TFAIL &nbsp;: &nbsp;rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01 &nbsp; &nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;sigaddset(..) failed
rt_sigaction01 &nbsp; 25 &nbsp;TFAIL &nbsp;: &nbsp;rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01 &nbsp; &nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;sigaddset(..) failed
rt_sigaction01 &nbsp; 26 &nbsp;TFAIL &nbsp;: &nbsp;rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01 &nbsp; &nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;sigaddset(..) failed
rt_sigaction01 &nbsp; 27 &nbsp;TFAIL &nbsp;: &nbsp;rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01 &nbsp; &nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;sigaddset(..) failed
rt_sigaction01 &nbsp; 28 &nbsp;TFAIL &nbsp;: &nbsp;rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01 &nbsp; &nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;sigaddset(..) failed
rt_sigaction01 &nbsp; 29 &nbsp;TFAIL &nbsp;: &nbsp;rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01 &nbsp; &nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;sigaddset(..) failed
rt_sigaction01 &nbsp; 30 &nbsp;TFAIL &nbsp;: &nbsp;rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument

So, the test needs fixing, anyhow. After I fixed it, the test still
segfaulted &gt;:( --

gcooper@orangebox
/scratch/ltp-dev2/ltp/testcases/kernel/syscalls/rt_sigaction $ gdb
./rt_sigaction01
GNU gdb 6.8
Copyright (C) 2008 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later
<a class="moz-txt-link-rfc2396E" href="http://gnu.org/licenses/gpl.html">&lt;http://gnu.org/licenses/gpl.html&gt;</a>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law. &nbsp;Type "show copying"
and "show warranty" for details.
This GDB was configured as "x86_64-pc-linux-gnu"...
(gdb) r
Starting program:
/scratch/ltp-dev2/ltp/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01
thread:20
[Thread debugging using libthread_db enabled]
rt_sigaction01 &nbsp; &nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;signal: 34
rt_sigaction01 &nbsp; &nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;sa.sa_flags = SA_RESETHAND|SA_SIGINFO
[New Thread 0x7fdd451d66f0 (LWP 31927)]

Program received signal SIG34, Real-time event 34.
[Switching to Thread 0x7fdd451d66f0 (LWP 31927)]
0x00007fdd448944f7 in kill () from /lib/libc.so.6
(gdb) c
Continuing.

Program received signal SIGSEGV, Segmentation fault.
0x00007fdd448944f7 in kill () from /lib/libc.so.6

So I tried to do some digging. glibc 2.8-20080602 does the following
for alpha, i386, and sysv:

&nbsp; &nbsp; &nbsp; result = INLINE_SYSCALL (rt_sigaction, 4,
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;sig, act ? __ptrvalue (&amp;kact) : NULL,
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;oact ? __ptrvalue (&amp;koact) : NULL, _NSIG /
8);

The kernel code for rt_sigaction in kernel/signal.c is as follows:

#ifdef __ARCH_WANT_SYS_RT_SIGACTION
SYSCALL_DEFINE4(rt_sigaction, int, sig,
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; const struct sigaction __user *, act,
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; struct sigaction __user *, oact,
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; size_t, sigsetsize)
{
&nbsp; &nbsp; &nbsp; &nbsp; struct k_sigaction new_sa, old_sa;
&nbsp; &nbsp; &nbsp; &nbsp; int ret = -EINVAL;

&nbsp; &nbsp; &nbsp; &nbsp; /* XXX: Don't preclude handling different sized sigset_t's. &nbsp;*/
&nbsp; &nbsp; &nbsp; &nbsp; if (sigsetsize != sizeof(sigset_t))
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; goto out;

&nbsp; &nbsp; &nbsp; &nbsp; if (act) {
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (copy_from_user(&amp;new_sa.sa, act, sizeof(new_sa.sa)))
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -EFAULT;
&nbsp; &nbsp; &nbsp; &nbsp; }

&nbsp; &nbsp; &nbsp; &nbsp; ret = do_sigaction(sig, act ? &amp;new_sa : NULL, oact ? &amp;old_sa :
NULL);

&nbsp; &nbsp; &nbsp; &nbsp; if (!ret &amp;&amp; oact) {
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (copy_to_user(oact, &amp;old_sa.sa, sizeof(old_sa.sa)))
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -EFAULT;
&nbsp; &nbsp; &nbsp; &nbsp; }
out:
&nbsp; &nbsp; &nbsp; &nbsp; return ret;
}

This just blows my mind because rt_sigaction is just calling
do_sigaction, which is the same code as sigaction AFAICT, apart from
the fact that rt_sigaction completely disregards sa_restorer on some
architectures because it's obsolete, and requires the end-user to
specify a signal mask set (here's mips' version, which wasn't the same
as i386's version -- i386 had the old sa_restorer code):

SYSCALL_DEFINE3(sigaction, int, sig, const struct sigaction __user *, act,
&nbsp; &nbsp; &nbsp; &nbsp; struct sigaction __user *, oact)
{
&nbsp; &nbsp; &nbsp; &nbsp; struct k_sigaction new_ka, old_ka;
&nbsp; &nbsp; &nbsp; &nbsp; int ret;
&nbsp; &nbsp; &nbsp; &nbsp; int err = 0;

&nbsp; &nbsp; &nbsp; &nbsp; if (act) {
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; old_sigset_t mask;

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (!access_ok(VERIFY_READ, act, sizeof(*act)))
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -EFAULT;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; err |= __get_user(new_ka.sa.sa_handler, &amp;act-&gt;sa_handler);
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; err |= __get_user(new_ka.sa.sa_flags, &amp;act-&gt;sa_flags);
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; err |= __get_user(mask, &amp;act-&gt;sa_mask.sig[0]);
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (err)
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -EFAULT;

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; siginitset(&amp;new_ka.sa.sa_mask, mask);
&nbsp; &nbsp; &nbsp; &nbsp; }

&nbsp; &nbsp; &nbsp; &nbsp; ret = do_sigaction(sig, act ? &amp;new_ka : NULL, oact ? &amp;old_ka :
NULL);

&nbsp; &nbsp; &nbsp; &nbsp; if (!ret &amp;&amp; oact) {
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)))
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -EFAULT;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; err |= __put_user(old_ka.sa.sa_flags, &amp;oact-&gt;sa_flags);
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; err |= __put_user(old_ka.sa.sa_handler, &amp;oact-&gt;sa_handler);
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; err |= __put_user(old_ka.sa.sa_mask.sig[0],
oact-&gt;sa_mask.sig);
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; err |= __put_user(0, &amp;oact-&gt;sa_mask.sig[1]);
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; err |= __put_user(0, &amp;oact-&gt;sa_mask.sig[2]);
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; err |= __put_user(0, &amp;oact-&gt;sa_mask.sig[3]);
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (err)
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -EFAULT;
&nbsp; &nbsp; &nbsp; &nbsp; }

&nbsp; &nbsp; &nbsp; &nbsp; return ret;
}

I dunno -- maybe someone else can read the kernel code better than me,
but it looks like there's zero real value to the rt_sigaction
testcases, because it can be covered by sigaction...



&nbsp;&nbsp;&nbsp; We just tell guys who use these testcases on arch x86_64 that
&nbsp;&nbsp;&nbsp; "Syscall rt_sigaction cannot be called directly on arch x86_64.",
&nbsp;&nbsp;&nbsp; can we?
      </pre>
    </blockquote>
    <pre wrap="">&nbsp; &nbsp;It's not just x86_64 -- it's also ia64, and this may change
depending on the version of glibc and linux sources, so... this really
isn't a viable solution IMO.
&nbsp; &nbsp;Does anyone have any better suggestions, apart from just using a
preprocessor macro that would execute rt_sig* via their non-rt
equivalents in ltp_signal.h?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
AHA! I think I discovered the kernel bug. rt_sigaction on x86_64
assumes that you're working in 32-bit space:

gcooper@orangebox /usr/src/linux $ grep -r rt_sigaction /usr/src/linux/arch/x86*
/usr/src/linux/arch/x86/ia32/sys_ia32.c:asmlinkage long
sys32_rt_sigaction(int sig, struct sigaction32 __user *act,
Binary file /usr/src/linux/arch/x86/ia32/sys_ia32.o matches
Binary file /usr/src/linux/arch/x86/ia32/built-in.o matches
/usr/src/linux/arch/x86/ia32/ia32entry.S:       .quad sys32_rt_sigaction
Binary file /usr/src/linux/arch/x86/ia32/ia32entry.o matches
Binary file /usr/src/linux/arch/x86/kernel/syscall_64.o matches
Binary file /usr/src/linux/arch/x86/kernel/built-in.o matches
/usr/src/linux/arch/x86/kernel/syscall_table_32.S:      .long sys_rt_sigaction
/usr/src/linux/arch/x86/include/asm/unistd_32.h:#define
__NR_rt_sigaction       174
/usr/src/linux/arch/x86/include/asm/unistd_64.h:#define
__NR_rt_sigaction                       13
/usr/src/linux/arch/x86/include/asm/unistd_64.h:__SYSCALL(__NR_rt_sigaction,
sys_rt_sigaction)
/usr/src/linux/arch/x86/include/asm/sys_ia32.h:asmlinkage long
sys32_rt_sigaction(int, struct sigaction32 __user *,

Watch (compiled with -m32):

rt_sigaction01    0  TINFO  :  signal: 34
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 34
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 34
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 34
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 34
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 34
rt_sigaction01    0  TINFO  :  signal: 35
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 35
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 35
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 35
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 35
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 35
rt_sigaction01    0  TINFO  :  signal: 36
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 36
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 36
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 36
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 36
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 36
rt_sigaction01    0  TINFO  :  signal: 37
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 37
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 37
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 37
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 37
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 37
rt_sigaction01    0  TINFO  :  signal: 38
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 38
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 38
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 38
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 38
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 38
rt_sigaction01    0  TINFO  :  signal: 39
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 39
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 39
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 39
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 39
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 39
rt_sigaction01    0  TINFO  :  signal: 40
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 40
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 40
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 40
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 40
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 40
rt_sigaction01    0  TINFO  :  signal: 41
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 41
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 41
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 41
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 41
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 41
rt_sigaction01    0  TINFO  :  signal: 42
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 42
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 42
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 42
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 42
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 42
rt_sigaction01    0  TINFO  :  signal: 43
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 43
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 43
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 43
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 43
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 43
rt_sigaction01    0  TINFO  :  signal: 44
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 44
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 44
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 44
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 44
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 44
rt_sigaction01    0  TINFO  :  signal: 45
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 45
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 45
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 45
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 45
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 45
rt_sigaction01    0  TINFO  :  signal: 46
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 46
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 46
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 46
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 46
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 46
rt_sigaction01    0  TINFO  :  signal: 47
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 47
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 47
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 47
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 47
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 47
rt_sigaction01    0  TINFO  :  signal: 48
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 48
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 48
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 48
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 48
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 48
rt_sigaction01    0  TINFO  :  signal: 49
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 49
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 49
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 49
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 49
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 49
rt_sigaction01    0  TINFO  :  signal: 50
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 50
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 50
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 50
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 50
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 50
rt_sigaction01    0  TINFO  :  signal: 51
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 51
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 51
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 51
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 51
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 51
rt_sigaction01    0  TINFO  :  signal: 52
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 52
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 52
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 52
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 52
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 52
rt_sigaction01    0  TINFO  :  signal: 53
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 53
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 53
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 53
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 53
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 53
rt_sigaction01    0  TINFO  :  signal: 54
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 54
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 54
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 54
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 54
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 54
rt_sigaction01    0  TINFO  :  signal: 55
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 55
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 55
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 55
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 55
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 55
rt_sigaction01    0  TINFO  :  signal: 56
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 56
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 56
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 56
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 56
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 56
rt_sigaction01    0  TINFO  :  signal: 57
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 57
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 57
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 57
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 57
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 57
rt_sigaction01    0  TINFO  :  signal: 58
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 58
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 58
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 58
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 58
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 58
rt_sigaction01    0  TINFO  :  signal: 59
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 59
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 59
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 59
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 59
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 59
rt_sigaction01    0  TINFO  :  signal: 60
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 60
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 60
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 60
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 60
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 60
rt_sigaction01    0  TINFO  :  signal: 61
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 61
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 61
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 61
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 61
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 61
rt_sigaction01    0  TINFO  :  signal: 62
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 62
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 62
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 62
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 62
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 62
rt_sigaction01    0  TINFO  :  signal: 63
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 63
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 63
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 63
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 63
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 63
rt_sigaction01    0  TINFO  :  signal: 64
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 64
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 64
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 64
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 64
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_NOMASK
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 64

So from what I can tell, the sucker isn't properly translating
something in 64-bit space, and instead of properly trapping the issue,
it's segfaulting and dying -_-.

Ultimately the problem from what I can see is that bi-arch (32-bit on
64-bit kernel) 64-bit rt_sig* support is broken. I don't know about
straight, non-bi-arch 64-bit rt_sig* support...

If someone could verify this with a little more kernel experience, or
someone could direct me on how the issue could be trapped in gdb so I
could inspect the registers and ensure the traps are or aren't being
done properly, that would be helpful.

  </pre>
</blockquote>
<br>
Although I had figured this, I think your solution is just a
compromise, isn't it?<br>
Change 64-bit rt_sigaction to 32-bit rt_sigaction to pass the testcase.<br>
Let's try to use 64bit rt_sigaction to pass it. ^_^<br>
<br>
Thanks~<br>
Liubo<br>
<br>
<blockquote
 cite="mid:364299f40911270050q53743fbdte8b98170e135b4ae@mail.gmail.com"
 type="cite">
  <pre wrap="">Thanks!
-Garrett


  </pre>
</blockquote>
<br>
</body>
</html>

--------------090901080506050605040503--


--===============3243571527156341501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============3243571527156341501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3243571527156341501==--

