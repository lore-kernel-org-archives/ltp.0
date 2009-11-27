Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <liubo2009@cn.fujitsu.com>) id 1NDtSM-0000AC-AB
	for ltp-list@lists.sourceforge.net; Fri, 27 Nov 2009 05:33:22 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NDtSE-0005x4-K9
	for ltp-list@lists.sourceforge.net; Fri, 27 Nov 2009 05:33:22 +0000
Message-ID: <4B0F64B7.6060507@cn.fujitsu.com>
Date: Fri, 27 Nov 2009 13:33:43 +0800
From: liubo <liubo2009@cn.fujitsu.com>
MIME-Version: 1.0
References: <4AF93496.3030408@cn.fujitsu.com>	
	<200911102333.55526.vapier@gentoo.org>	
	<4AFA45B0.7070608@cn.fujitsu.com>	
	<1258359225.5677.35.camel@subratamodak.linux.ibm.com>	
	<4B0112EC.9020202@cn.fujitsu.com>
	<364299f40911260311m6d157453s47f57d1ba47ef643@mail.gmail.com>
In-Reply-To: <364299f40911260311m6d157453s47f57d1ba47ef643@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============6688935528486037078=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: Mike Frysinger <vapier@gentoo.org>, ltp-list <ltp-list@lists.sf.net>

This is a multi-part message in MIME format.
--===============6688935528486037078==
Content-Type: multipart/alternative;
	boundary="------------030201050507020502090202"

This is a multi-part message in MIME format.
--------------030201050507020502090202
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi, Garrett
On 11/26/2009 07:11 PM, Garrett Cooper wrote:
> On Mon, Nov 16, 2009 at 12:53 AM, liubo <liubo2009@cn.fujitsu.com> wrote:
>   
>> Hi, Subrata,
>> On 11/16/2009 04:13 PM, Subrata Modak wrote:
>>
>> Liubo,
>>
>> Are you sending an updated patch post this discussion ?
>>
>>
>>
>> Yes, I'll resend a updated patch about these rt_sigs.
>>
>> Regards--
>> Liubo
>>
>> Regards--
>> Subrata
>>
>> On Wed, 2009-11-11 at 13:03 +0800, Wei Yongjun wrote:
>>
>>
>> Mike Frysinger wrote:
>>
>>
>> On Tuesday 10 November 2009 04:38:30 liubo wrote:
>>
>>
>>
>> 1) rt_sigaction
>>     "sigaction" has the structure:
>>
>>  struct sigaction {
>>          __sighandler_t sa_handler;
>>          unsigned long sa_flags;
>>   #ifdef SA_RESTORER
>>           __sigrestore_t sa_restorer;
>>   #endif
>>           sigset_t sa_mask;               /* mask last for extensibility */
>>  };
>>
>>     However, on arch x86_64, if we directly get to call rt_sigaction,
>> the argument "sa_restorer" will not be fulfilled, and this will lead
>>  to segment fault.
>>     on arch x86_64, if sa_restorer is not set, kernel will lead to segment
>>  fault. In other arch, if sa_restorer is not set, kernel can do the correct
>>  work. To avoid this segment fault, we use glibc function
>> "int sigaction(...);" instead, which can fulfill the argument
>>  "sa_restorer".
>>
>>
>>
>> which defeats the purpose of the test.  there is no guarantee that the C
>> library sigaction function is implemented via the __NR_rt_sigaction syscall.
>>
>>
>>
>> In x86_64, it do this. And If we want to use __NR_rt_sigaction syscall
>> directly, we must fill the sa_restorer and set the RESTORER flag to
>> sa_mask. If we do not set the sa_restorer, kill will always cause
>> segment fault.
>>
>>
>>
>>
>>
>>
>> 2) rt_sigprocmask
>>     This failure contains two aspects,
>> the first is the segment fault as described in 1),
>> the second is that testcase uses a unknown signal 33 for test,
>> and this will lead sigaction cannot bind signal 33 to the action.
>>
>>     So, we attempt to use a known signal instead, such as 34.
>>
>>
>>
>> which is just as bogus and unportable.  if the test needs a real time
>> signal,
>> it should leverage the sigrtmin...sigrtmax defines.
>> -mike
>>     
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
> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
> and "show warranty" for details.
> This GDB was configured as "x86_64-pc-linux-gnu"...
> (gdb) c
> The program is not being run.
> (gdb) r
> Starting program:
> /scratch/ltp-dev2/ltp/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01
> thread:20
> [Thread debugging using libthread_db enabled]
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01    1  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=EINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01    2  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=EINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01    3  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=EINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01    4  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=EINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01    5  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=EINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01    6  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=EINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01    7  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=EINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01    8  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=EINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01    9  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=EINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   10  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=EINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   11  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=EINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   12  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=EINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   13  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=EINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   14  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=EINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   15  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=EINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   16  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=EINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   17  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=EINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   18  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=EINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   19  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=EINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   20  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=EINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   21  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=EINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   22  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=EINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   23  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=EINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   24  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=EINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   25  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=EINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   26  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=EINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   27  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=EINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   28  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=EINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   29  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=EINVAL(22): Invalid argument
> rt_sigaction01    0  TINFO  :  sigaddset(..) failed
> rt_sigaction01   30  TFAIL  :  rt_sigaction01 failed:
> TEST_ERRNO=EINVAL(22): Invalid argument
>
> So, the test needs fixing, anyhow. After I fixed it, the test still
> segfaulted >:( --
>
> gcooper@orangebox
> /scratch/ltp-dev2/ltp/testcases/kernel/syscalls/rt_sigaction $ gdb
> ./rt_sigaction01
> GNU gdb 6.8
> Copyright (C) 2008 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
> and "show warranty" for details.
> This GDB was configured as "x86_64-pc-linux-gnu"...
> (gdb) r
> Starting program:
> /scratch/ltp-dev2/ltp/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01
> thread:20
> [Thread debugging using libthread_db enabled]
> rt_sigaction01    0  TINFO  :  signal: 34
> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
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
>       result = INLINE_SYSCALL (rt_sigaction, 4,
>                                sig, act ? __ptrvalue (&kact) : NULL,
>                                oact ? __ptrvalue (&koact) : NULL, _NSIG / 8);
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
>         int ret = -EINVAL;
>
>         /* XXX: Don't preclude handling different sized sigset_t's.  */
>         if (sigsetsize != sizeof(sigset_t))
>                 goto out;
>
>         if (act) {
>                 if (copy_from_user(&new_sa.sa, act, sizeof(new_sa.sa)))
>                         return -EFAULT;
>         }
>
>         ret = do_sigaction(sig, act ? &new_sa : NULL, oact ? &old_sa : NULL);
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
>         int err = 0;
>
>         if (act) {
>                 old_sigset_t mask;
>
>                 if (!access_ok(VERIFY_READ, act, sizeof(*act)))
>                         return -EFAULT;
>                 err |= __get_user(new_ka.sa.sa_handler, &act->sa_handler);
>                 err |= __get_user(new_ka.sa.sa_flags, &act->sa_flags);
>                 err |= __get_user(mask, &act->sa_mask.sig[0]);
>                 if (err)
>                         return -EFAULT;
>
>                 siginitset(&new_ka.sa.sa_mask, mask);
>         }
>
>         ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
>
>         if (!ret && oact) {
>                 if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)))
>                         return -EFAULT;
>                 err |= __put_user(old_ka.sa.sa_flags, &oact->sa_flags);
>                 err |= __put_user(old_ka.sa.sa_handler, &oact->sa_handler);
>                 err |= __put_user(old_ka.sa.sa_mask.sig[0], oact->sa_mask.sig);
>                 err |= __put_user(0, &oact->sa_mask.sig[1]);
>                 err |= __put_user(0, &oact->sa_mask.sig[2]);
>                 err |= __put_user(0, &oact->sa_mask.sig[3]);
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

    We just tell guys who use these testcases on arch x86_64 that
    "Syscall rt_sigaction cannot be called directly on arch x86_64.",
    can we?
   
> Thanks,
> -Garrett
>
>
>   


--------------030201050507020502090202
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
On 11/26/2009 07:11 PM, Garrett Cooper wrote:
<blockquote
 cite="mid:364299f40911260311m6d157453s47f57d1ba47ef643@mail.gmail.com"
 type="cite">
  <pre wrap="">On Mon, Nov 16, 2009 at 12:53 AM, liubo <a class="moz-txt-link-rfc2396E" href="mailto:liubo2009@cn.fujitsu.com">&lt;liubo2009@cn.fujitsu.com&gt;</a> wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hi, Subrata,
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
    "sigaction" has the structure:

 struct sigaction {
         __sighandler_t sa_handler;
         unsigned long sa_flags;
  #ifdef SA_RESTORER
          __sigrestore_t sa_restorer;
  #endif
          sigset_t sa_mask;               /* mask last for extensibility */
 };

    However, on arch x86_64, if we directly get to call rt_sigaction,
the argument "sa_restorer" will not be fulfilled, and this will lead
 to segment fault.
    on arch x86_64, if sa_restorer is not set, kernel will lead to segment
 fault. In other arch, if sa_restorer is not set, kernel can do the correct
 work. To avoid this segment fault, we use glibc function
"int sigaction(...);" instead, which can fulfill the argument
 "sa_restorer".



which defeats the purpose of the test.  there is no guarantee that the C
library sigaction function is implemented via the __NR_rt_sigaction syscall.



In x86_64, it do this. And If we want to use __NR_rt_sigaction syscall
directly, we must fill the sa_restorer and set the RESTORER flag to
sa_mask. If we do not set the sa_restorer, kill will always cause
segment fault.






2) rt_sigprocmask
    This failure contains two aspects,
the first is the segment fault as described in 1),
the second is that testcase uses a unknown signal 33 for test,
and this will lead sigaction cannot bind signal 33 to the action.

    So, we attempt to use a known signal instead, such as 34.



which is just as bogus and unportable.  if the test needs a real time
signal,
it should leverage the sigrtmin...sigrtmax defines.
-mike
    </pre>
  </blockquote>
  <pre wrap=""><!---->
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
License GPLv3+: GNU GPL version 3 or later <a class="moz-txt-link-rfc2396E" href="http://gnu.org/licenses/gpl.html">&lt;http://gnu.org/licenses/gpl.html&gt;</a>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "x86_64-pc-linux-gnu"...
(gdb) c
The program is not being run.
(gdb) r
Starting program:
/scratch/ltp-dev2/ltp/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01
thread:20
[Thread debugging using libthread_db enabled]
rt_sigaction01    0  TINFO  :  sigaddset(..) failed
rt_sigaction01    1  TFAIL  :  rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01    0  TINFO  :  sigaddset(..) failed
rt_sigaction01    2  TFAIL  :  rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01    0  TINFO  :  sigaddset(..) failed
rt_sigaction01    3  TFAIL  :  rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01    0  TINFO  :  sigaddset(..) failed
rt_sigaction01    4  TFAIL  :  rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01    0  TINFO  :  sigaddset(..) failed
rt_sigaction01    5  TFAIL  :  rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01    0  TINFO  :  sigaddset(..) failed
rt_sigaction01    6  TFAIL  :  rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01    0  TINFO  :  sigaddset(..) failed
rt_sigaction01    7  TFAIL  :  rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01    0  TINFO  :  sigaddset(..) failed
rt_sigaction01    8  TFAIL  :  rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01    0  TINFO  :  sigaddset(..) failed
rt_sigaction01    9  TFAIL  :  rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01    0  TINFO  :  sigaddset(..) failed
rt_sigaction01   10  TFAIL  :  rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01    0  TINFO  :  sigaddset(..) failed
rt_sigaction01   11  TFAIL  :  rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01    0  TINFO  :  sigaddset(..) failed
rt_sigaction01   12  TFAIL  :  rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01    0  TINFO  :  sigaddset(..) failed
rt_sigaction01   13  TFAIL  :  rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01    0  TINFO  :  sigaddset(..) failed
rt_sigaction01   14  TFAIL  :  rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01    0  TINFO  :  sigaddset(..) failed
rt_sigaction01   15  TFAIL  :  rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01    0  TINFO  :  sigaddset(..) failed
rt_sigaction01   16  TFAIL  :  rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01    0  TINFO  :  sigaddset(..) failed
rt_sigaction01   17  TFAIL  :  rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01    0  TINFO  :  sigaddset(..) failed
rt_sigaction01   18  TFAIL  :  rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01    0  TINFO  :  sigaddset(..) failed
rt_sigaction01   19  TFAIL  :  rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01    0  TINFO  :  sigaddset(..) failed
rt_sigaction01   20  TFAIL  :  rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01    0  TINFO  :  sigaddset(..) failed
rt_sigaction01   21  TFAIL  :  rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01    0  TINFO  :  sigaddset(..) failed
rt_sigaction01   22  TFAIL  :  rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01    0  TINFO  :  sigaddset(..) failed
rt_sigaction01   23  TFAIL  :  rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01    0  TINFO  :  sigaddset(..) failed
rt_sigaction01   24  TFAIL  :  rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01    0  TINFO  :  sigaddset(..) failed
rt_sigaction01   25  TFAIL  :  rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01    0  TINFO  :  sigaddset(..) failed
rt_sigaction01   26  TFAIL  :  rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01    0  TINFO  :  sigaddset(..) failed
rt_sigaction01   27  TFAIL  :  rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01    0  TINFO  :  sigaddset(..) failed
rt_sigaction01   28  TFAIL  :  rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01    0  TINFO  :  sigaddset(..) failed
rt_sigaction01   29  TFAIL  :  rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument
rt_sigaction01    0  TINFO  :  sigaddset(..) failed
rt_sigaction01   30  TFAIL  :  rt_sigaction01 failed:
TEST_ERRNO=EINVAL(22): Invalid argument

So, the test needs fixing, anyhow. After I fixed it, the test still
segfaulted &gt;:( --

gcooper@orangebox
/scratch/ltp-dev2/ltp/testcases/kernel/syscalls/rt_sigaction $ gdb
./rt_sigaction01
GNU gdb 6.8
Copyright (C) 2008 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <a class="moz-txt-link-rfc2396E" href="http://gnu.org/licenses/gpl.html">&lt;http://gnu.org/licenses/gpl.html&gt;</a>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "x86_64-pc-linux-gnu"...
(gdb) r
Starting program:
/scratch/ltp-dev2/ltp/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01
thread:20
[Thread debugging using libthread_db enabled]
rt_sigaction01    0  TINFO  :  signal: 34
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
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

      result = INLINE_SYSCALL (rt_sigaction, 4,
                               sig, act ? __ptrvalue (&amp;kact) : NULL,
                               oact ? __ptrvalue (&amp;koact) : NULL, _NSIG / 8);

The kernel code for rt_sigaction in kernel/signal.c is as follows:

#ifdef __ARCH_WANT_SYS_RT_SIGACTION
SYSCALL_DEFINE4(rt_sigaction, int, sig,
                const struct sigaction __user *, act,
                struct sigaction __user *, oact,
                size_t, sigsetsize)
{
        struct k_sigaction new_sa, old_sa;
        int ret = -EINVAL;

        /* XXX: Don't preclude handling different sized sigset_t's.  */
        if (sigsetsize != sizeof(sigset_t))
                goto out;

        if (act) {
                if (copy_from_user(&amp;new_sa.sa, act, sizeof(new_sa.sa)))
                        return -EFAULT;
        }

        ret = do_sigaction(sig, act ? &amp;new_sa : NULL, oact ? &amp;old_sa : NULL);

        if (!ret &amp;&amp; oact) {
                if (copy_to_user(oact, &amp;old_sa.sa, sizeof(old_sa.sa)))
                        return -EFAULT;
        }
out:
        return ret;
}

This just blows my mind because rt_sigaction is just calling
do_sigaction, which is the same code as sigaction AFAICT, apart from
the fact that rt_sigaction completely disregards sa_restorer on some
architectures because it's obsolete, and requires the end-user to
specify a signal mask set (here's mips' version, which wasn't the same
as i386's version -- i386 had the old sa_restorer code):

SYSCALL_DEFINE3(sigaction, int, sig, const struct sigaction __user *, act,
        struct sigaction __user *, oact)
{
        struct k_sigaction new_ka, old_ka;
        int ret;
        int err = 0;

        if (act) {
                old_sigset_t mask;

                if (!access_ok(VERIFY_READ, act, sizeof(*act)))
                        return -EFAULT;
                err |= __get_user(new_ka.sa.sa_handler, &amp;act-&gt;sa_handler);
                err |= __get_user(new_ka.sa.sa_flags, &amp;act-&gt;sa_flags);
                err |= __get_user(mask, &amp;act-&gt;sa_mask.sig[0]);
                if (err)
                        return -EFAULT;

                siginitset(&amp;new_ka.sa.sa_mask, mask);
        }

        ret = do_sigaction(sig, act ? &amp;new_ka : NULL, oact ? &amp;old_ka : NULL);

        if (!ret &amp;&amp; oact) {
                if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)))
                        return -EFAULT;
                err |= __put_user(old_ka.sa.sa_flags, &amp;oact-&gt;sa_flags);
                err |= __put_user(old_ka.sa.sa_handler, &amp;oact-&gt;sa_handler);
                err |= __put_user(old_ka.sa.sa_mask.sig[0], oact-&gt;sa_mask.sig);
                err |= __put_user(0, &amp;oact-&gt;sa_mask.sig[1]);
                err |= __put_user(0, &amp;oact-&gt;sa_mask.sig[2]);
                err |= __put_user(0, &amp;oact-&gt;sa_mask.sig[3]);
                if (err)
                        return -EFAULT;
        }

        return ret;
}

I dunno -- maybe someone else can read the kernel code better than me,
but it looks like there's zero real value to the rt_sigaction
testcases, because it can be covered by sigaction...

  </pre>
</blockquote>
<br>
&nbsp;&nbsp;&nbsp; We just tell guys who use these testcases on arch x86_64 that <br>
&nbsp;&nbsp;&nbsp; "Syscall rt_sigaction cannot be called directly on arch x86_64.",<br>
&nbsp;&nbsp;&nbsp; can we?<br>
&nbsp;&nbsp;&nbsp; <br>
<blockquote
 cite="mid:364299f40911260311m6d157453s47f57d1ba47ef643@mail.gmail.com"
 type="cite">
  <pre wrap="">Thanks,
-Garrett


  </pre>
</blockquote>
<br>
</body>
</html>

--------------030201050507020502090202--


--===============6688935528486037078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============6688935528486037078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6688935528486037078==--

