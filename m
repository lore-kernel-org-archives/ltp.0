Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <liubo2009@cn.fujitsu.com>) id 1NkY5M-0001BO-4m
	for ltp-list@lists.sourceforge.net; Thu, 25 Feb 2010 07:24:36 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NkY4d-0005Rq-Up
	for ltp-list@lists.sourceforge.net; Thu, 25 Feb 2010 07:24:36 +0000
Message-ID: <4B862614.5020401@cn.fujitsu.com>
Date: Thu, 25 Feb 2010 15:26:12 +0800
From: liubo <liubo2009@cn.fujitsu.com>
MIME-Version: 1.0
References: <4B82143D.5050006@cn.fujitsu.com>		<364299f41002212356g2a4ceb09o3d271e31b388fe51@mail.gmail.com>		<4B8249A7.3040401@cn.fujitsu.com>	<364299f41002221005l7df3ceafhaeb6a49b17ee0fed@mail.gmail.com>
	<4B832856.3050305@cn.fujitsu.com>
In-Reply-To: <4B832856.3050305@cn.fujitsu.com>
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
Content-Type: multipart/mixed; boundary="===============4879227151614856371=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--===============4879227151614856371==
Content-Type: multipart/alternative;
	boundary="------------080108000306080001050105"

This is a multi-part message in MIME format.
--------------080108000306080001050105
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Garrett,

    I figured that this patch has not been merged into ltp-cvs.
    Is there some else problems about this patch?

Thanks,
Liubo

On 02/23/2010 08:59 AM, liubo wrote:
> Hi, Garrett,
> My revised patch has been "Acked/Tested-By: Rishikesh K
> Rajak<risrajak@linux.vnet.ibm.com>"
>
> url: http://marc.info/?l=ltp-list&m=126683033423523&w=2
>
> Thanks,
> Liubo
>
> On 02/23/2010 02:05 AM, Garrett Cooper wrote:
>   
>> On Mon, Feb 22, 2010 at 1:08 AM, liubo <liubo2009@cn.fujitsu.com> wrote:
>>   
>>     
>>> On 02/22/2010 03:56 PM, Garrett Cooper wrote:
>>>
>>> By and large this diff looks really good. My comments...
>>>
>>> On Sun, Feb 21, 2010 at 9:21 PM, liubo <liubo2009@cn.fujitsu.com> wrote:
>>>
>>>
>>> - rt_sigaction01
>>> On arch x86_64, if we directly get to call syscall
>>> rt_sigaction, there will be "segment fault".
>>> 1) One reason is that we must supply the flag of
>>> "SA_RESTORER" and the correct pointer to the fuction
>>> "restorer", according to the kernel code.
>>> 2) The other reason is that default syscall rt_sigaction
>>> use kernel "sigaction" structure, which is different
>>> with normal "sigaction" structure.
>>>
>>> So,
>>> 1) We manage to find the address of the function
>>> "restorer" by using glibc function "sigaction",
>>> which might be something tricky. Then we add these
>>> arguments to make test run correctly.
>>> 2) We also use kernel "sigaction" structure to fit
>>> realtime syscall __NR_rt_sigaction.
>>>
>>> - rt_sigprocmask01
>>> First, there exsits the same problem as rt_sigaction01.
>>> Second, this testcase uses a unchanged signal number 33,
>>> which may diff among different archs and lead to error
>>> "unknown signal".
>>>
>>> So, we use a macro TEST_SIG which refers to SIGRTMIN
>>> to replace 33.
>>>
>>>
>>> The problem is that SIGRTMIN is actually signal 32, not signal 33, and
>>> here's a problematic comment to ponder over (from bits/signum.h):
>>>
>>> /* These are the hard limits of the kernel.  These values should not be
>>>    used directly at user level.  */
>>> #define __SIGRTMIN      32
>>> #define __SIGRTMAX      (_NSIG - 1)
>>>
>>> I think the proper resolution would be to make the value SIGRTMIN+1.
>>>
>>>
>>>
>>> Hi, Garrett,
>>>
>>> In fact, I'm confused about whether #33 signal is particularly needed here,
>>> in some of my boxes, SIGRTMIN actually refers #34 signal, that is,
>>> #33 is unreachable.
>>>
>>> IMO, any realtime reachable signal can be used to pass the case here, and
>>> I pick SIGRTMIN by define a macro: #define TEST_SIG SIGRTMIN.
>>>
>>> Of course, the value "SIGRTMIN+1" also pass the case, so I'll pick your
>>> value.
>>>
>>> If you are free, looking forward to your explaination ...
>>>     
>>>       
>> Several signals between the non-RT and non-reserved RT signals are
>> used by [the now defunct] linuxthreads and nptl. See the following
>> page which refers to a very old school copy of LTP :]...:
>>
>> http://www.redhat.com/archives/phil-list/2003-April/msg00049.html
>>
>>   
>>     
>
> ok , got it.
>   
>>> - rt_sigsuspend01
>>> There exists the same problem as rt_sigaction01.
>>>
>>> This patch fixed these failure.
>>>
>>> Signed-off-by: Liu Bo <liubo2009@cn.fujitsu.com>
>>>
>>> ---
>>>  include/rt_signal.h                                |   60
>>> ++++++++++++++++++
>>>  .../kernel/syscalls/rt_sigaction/rt_sigaction01.c  |   64
>>> +++++++++++--------
>>>  .../syscalls/rt_sigprocmask/rt_sigprocmask01.c     |   32 +++++++---
>>>  .../syscalls/rt_sigsuspend/rt_sigsuspend01.c       |   13 ++++-
>>>  4 files changed, 132 insertions(+), 37 deletions(-)
>>>  create mode 100644 include/rt_signal.h
>>>
>>> diff --git a/include/rt_signal.h b/include/rt_signal.h
>>> new file mode 100644
>>> index 0000000..ea1e7e3
>>> --- /dev/null
>>> +++ b/include/rt_signal.h
>>> @@ -0,0 +1,60 @@
>>> +/******************************************************************************/
>>> +/*
>>>    */
>>> +/* Copyright (c) 2009 FUJITSU LIMITED
>>>   */
>>> +/*
>>>    */
>>> +/* This program is free software;  you can redistribute it and/or modify
>>>    */
>>> +/* it under the terms of the GNU General Public License as published by
>>>   */
>>> +/* the Free Software Foundation; either version 2 of the License, or
>>>    */
>>> +/* (at your option) any later version.
>>>    */
>>> +/*
>>>    */
>>> +/* This program is distributed in the hope that it will be useful,
>>>    */
>>> +/* but WITHOUT ANY WARRANTY;  without even the implied warranty of
>>>    */
>>> +/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
>>>    */
>>> +/* the GNU General Public License for more details.
>>>   */
>>> +/*
>>>    */
>>> +/* You should have received a copy of the GNU General Public License
>>>    */
>>> +/* along with this program;  if not, write to the Free Software
>>>   */
>>> +/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
>>>    */
>>> +/*
>>>    */
>>> +/* Author: Liu Bo <liubo2009@cn.fujitsu.com>
>>>    */
>>> +/*
>>>    */
>>> +/******************************************************************************/
>>> +
>>> +#ifndef __LTP_SIGNAL_H
>>> +#define __LTP_SIGNAL_H
>>> +
>>> +/* We do not globally define the SA_RESTORER flag so do it here.  */
>>> +#define HAVE_SA_RESTORER
>>> +#define SA_RESTORER 0x04000000
>>> +
>>> +struct kernel_sigaction {
>>> +       __sighandler_t k_sa_handler;
>>> +       unsigned long sa_flags;
>>> +       void (*sa_restorer) (void);
>>> +       sigset_t sa_mask;
>>> +};
>>> +
>>> +void (*restore_rt) (void);
>>> +
>>> +void
>>> +handler_h(void)
>>> +{
>>> +       return;
>>> +}
>>> +
>>> +/* initial restore_rt for x86_64 */
>>> +void
>>> +sig_initial(int sig)
>>> +{
>>> +       struct sigaction act, oact;
>>> +
>>> +       act.sa_handler = (void *)handler_h;
>>> +       sigemptyset(&act.sa_mask);
>>> +       sigaddset(&act.sa_mask, sig);
>>> +       /* copy act.sa_restorer to kernel */
>>> +       sigaction(sig, &act, &oact);
>>> +       /* copy oact.sa_restorer from kernel */
>>> +       sigaction(sig, &act, &oact);
>>> +       restore_rt = oact.sa_restorer;
>>> +}
>>> +#endif
>>> diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
>>> b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
>>> index ffc5fa2..d30f204 100644
>>> --- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
>>> +++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
>>> @@ -55,6 +55,10 @@
>>>  #include "usctest.h"
>>>  #include "linux_syscall_numbers.h"
>>>
>>> +#ifdef __x86_64__
>>> +#include "rt_signal.h"
>>> +#endif
>>> +
>>>  /*
>>>  * For all but __mips__:
>>>  *
>>> @@ -101,13 +105,14 @@ int  TST_TOTAL = 1;                   /* total number
>>> of tests in this file.   *
>>>  /*              On success - Exits calling tst_exit(). With '0' return
>>> code.  */
>>>  /*
>>>    */
>>>  /******************************************************************************/
>>> -extern void cleanup() {
>>> -        /* Remove tmp dir and all files in it */
>>> -        TEST_CLEANUP;
>>> -        tst_rmdir();
>>> +extern void cleanup()
>>> +{
>>> +       /* Remove tmp dir and all files in it */
>>> +       TEST_CLEANUP;
>>> +       tst_rmdir();
>>>
>>> -        /* Exit with appropriate return code. */
>>> -        tst_exit();
>>> +       /* Exit with appropriate return code. */
>>> +       tst_exit();
>>>  }
>>>
>>>  /* Local  Functions */
>>> @@ -128,11 +133,12 @@ extern void cleanup() {
>>>  /*              On success - returns 0.
>>>   */
>>>  /*
>>>    */
>>>  /******************************************************************************/
>>> -void setup() {
>>> -        /* Capture signals if any */
>>> -        /* Create temporary directories */
>>> -        TEST_PAUSE;
>>> -        tst_tmpdir();
>>> +void setup()
>>> +{
>>> +       /* Capture signals if any */
>>> +       /* Create temporary directories */
>>> +       TEST_PAUSE;
>>> +       tst_tmpdir();
>>>  }
>>>
>>>  int test_flags[] = {SA_RESETHAND|SA_SIGINFO, SA_RESETHAND,
>>> SA_RESETHAND|SA_SIGINFO, SA_RESETHAND|SA_SIGINFO, SA_NOMASK};
>>> @@ -144,22 +150,23 @@ handler(int sig)
>>>         tst_resm(TINFO,"Signal Handler Called with signal number %d\n",sig);
>>>         return;
>>>  }
>>> -
>>>  int
>>> -set_handler(int sig, int sig_to_mask, int mask_flags)
>>> +set_handler(int sig, int mask_flags)
>>>  {
>>> -        struct sigaction sa, oldaction;
>>> -
>>> -                sa.sa_sigaction = (void *)handler;
>>> -                sa.sa_flags = mask_flags;
>>> -                sigemptyset(&sa.sa_mask);
>>> -                sigaddset(&sa.sa_mask, sig_to_mask);
>>> -                TEST(syscall(__NR_rt_sigaction,sig, &sa,
>>> &oldaction,SIGSETSIZE));
>>> -        if (TEST_RETURN == 0) {
>>> -                return 0;
>>> -        } else {
>>> -                        return TEST_RETURN;
>>> -        }
>>> +#ifdef __x86_64__
>>> +       struct kernel_sigaction sa, oldaction;
>>> +       mask_flags |= SA_RESTORER;
>>> +       sa.sa_restorer = restore_rt;
>>> +       sa.k_sa_handler = (void *)handler;
>>> +#else
>>> +       struct sigaction sa, oldaction;
>>> +       sa.sa_handler = (void *)handler;
>>> +#endif
>>> +       sa.sa_flags = mask_flags;
>>> +       sigemptyset(&sa.sa_mask);
>>> +       sigaddset(&sa.sa_mask, sig);
>>> +       TEST(syscall(__NR_rt_sigaction,sig, &sa, &oldaction,SIGSETSIZE));
>>> +       return TEST_RETURN;
>>>  }
>>>
>>>
>>> @@ -182,8 +189,11 @@ int main(int ac, char **av) {
>>>                 for (testno = 0; testno < TST_TOTAL; ++testno) {
>>>
>>>                        for (signal = SIGRTMIN; signal <= (SIGRTMAX );
>>> signal++){//signal for 34 to 65
>>> -                               for(flag=0; flag<5;flag++) {
>>> -                                        TEST(set_handler(signal, 0,
>>> test_flags[flag]));
>>> +#ifdef __x86_64__
>>> +                               sig_initial(signal);
>>> +#endif
>>> +                               for(flag=0; flag<5;flag++) {
>>> +                                        TEST(set_handler(signal,
>>> test_flags[flag]));
>>>
>>>
>>> I know this isn't your code change, but since you're here.. a better
>>> way to do this would be:
>>>
>>> sizeof (test_flags) / sizeof (test_flags[0])
>>>
>>> as this is a fixed array buffer.
>>>
>>>
>>> Sure, this can increase codes's portability.
>>>
>>> I'm generating a new version patch.
>>>     
>>>       
>> The less we have to modify code in the future, the better... Cheers!
>>
>>   
>>     
>>>                                                 if (TEST_RETURN == 0) {
>>>                                                tst_resm(TINFO,"signal: %d ",
>>> signal);
>>>                                                tst_resm(TPASS, "rt_sigaction
>>> call succeeded: result = %ld ",TEST_RETURN );
>>> diff --git a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
>>> b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
>>> index 6398a28..8bcdc78 100644
>>> --- a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
>>> +++ b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
>>> @@ -62,6 +62,12 @@
>>>  #include "usctest.h"
>>>  #include "linux_syscall_numbers.h"
>>>
>>> +#ifdef __x86_64__
>>> +#include "rt_signal.h"
>>> +#endif
>>> +
>>> +#define TEST_SIG SIGRTMIN
>>> +
>>>  /* Extern Global Variables */
>>>  extern int Tst_count;           /* counter for tst_xxx routines.         */
>>>  extern char *TESTDIR;           /* temporary dir created by tst_tmpdir() */
>>> @@ -131,7 +137,16 @@ void sig_handler(int sig)
>>>  }
>>>
>>>  int main(int ac, char **av) {
>>> -       struct sigaction act, oact;
>>> +#ifdef __x86_64__
>>> +       struct kernel_sigaction act, oact;
>>> +       sig_initial(TEST_SIG);
>>> +       act.sa_flags |= SA_RESTORER;
>>> +        act.sa_restorer = restore_rt;
>>> +        act.k_sa_handler = sig_handler;
>>> +#else
>>> +        struct sigaction act, oact;
>>> +        act.sa_handler = sig_handler;
>>> +#endif
>>>         sigset_t set, oset;
>>>         int lc;                 /* loop counter */
>>>         char *msg;              /* message returned from parse_opts */
>>> @@ -154,22 +169,21 @@ int main(int ac, char **av) {
>>>                                cleanup();
>>>                                tst_exit();
>>>                        }
>>> -                       TEST(sigaddset(&set, 33));
>>> +                       TEST(sigaddset(&set, TEST_SIG));
>>>                        if(TEST_RETURN == -1){
>>>                                tst_resm(TFAIL,"Call to sigaddset() Failed,
>>> errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
>>>                                cleanup();
>>>                                tst_exit();
>>>                        }
>>> -
>>> +
>>>                        /* call rt_sigaction() */
>>> -                       act.sa_handler = sig_handler;
>>> -                        TEST(syscall(__NR_rt_sigaction, 33, &act, &oact,
>>> 8));
>>> +                        TEST(syscall(__NR_rt_sigaction, TEST_SIG, &act,
>>> &oact, 8));
>>>                        if(TEST_RETURN != 0){
>>>                                tst_resm(TFAIL,"Call to rt_sigaction()
>>> Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
>>>                                cleanup();
>>>                                tst_exit();
>>>                        }
>>> -                       /* call rt_sigprocmask() to block signal#33 */
>>> +                       /* call rt_sigprocmask() to block signal#SIGRTMIN */
>>>                         TEST(syscall(__NR_rt_sigprocmask, SIG_BLOCK, &set,
>>> &oset, 8));
>>>                        if(TEST_RETURN == -1){
>>>                                tst_resm(TFAIL,"Call to rt_sigprocmask()****
>>> Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
>>> @@ -178,7 +192,7 @@ int main(int ac, char **av) {
>>>                        }
>>>
>>>                        else {
>>> -                               TEST(kill(getpid(), 33));
>>> +                               TEST(kill(getpid(), TEST_SIG));
>>>                                if(TEST_RETURN != 0){
>>>                                        tst_resm(TFAIL,"Call to kill()
>>> Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
>>>                                        cleanup();
>>> @@ -198,13 +212,13 @@ int main(int ac, char **av) {
>>>                                                cleanup();
>>>                                                tst_exit();
>>>                                        }
>>> -                                       TEST(sigismember(&oset, 33));
>>> +                                       TEST(sigismember(&oset, TEST_SIG));
>>>                                        if(TEST_RETURN == 0 ){
>>>                                                tst_resm(TFAIL,"call
>>> sigismember() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
>>>                                                cleanup();
>>>                                                tst_exit();
>>>                                        }
>>> -                                       /* call rt_sigprocmask() to unblock
>>> signal#33 */
>>> +                                       /* call rt_sigprocmask() to unblock
>>> signal#SIGRTMIN */
>>>                                        TEST(syscall(__NR_rt_sigprocmask,
>>> SIG_UNBLOCK, &set, &oset, 8));
>>>                                        if(TEST_RETURN == -1){
>>>                                                tst_resm(TFAIL,"Call to
>>> rt_sigprocmask() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
>>> diff --git a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
>>> b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
>>> index 416a7c9..84f2967 100644
>>> --- a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
>>> +++ b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
>>> @@ -47,6 +47,10 @@
>>>  #include "usctest.h"
>>>  #include "linux_syscall_numbers.h"
>>>
>>> +#ifdef __x86_64__
>>> +#include "rt_signal.h"
>>> +#endif
>>> +
>>>  /* Extern Global Variables */
>>>  extern int Tst_count;           /* counter for tst_xxx routines.         */
>>>  extern char *TESTDIR;           /* temporary dir created by tst_tmpdir() */
>>> @@ -139,9 +143,16 @@ int main(int ac, char **av) {
>>>                                cleanup();
>>>                                tst_exit();
>>>                        }
>>> +#ifdef __x86_64__
>>> +                       struct kernel_sigaction act, oact;
>>> +                       sig_initial(SIGALRM);
>>> +                       act.sa_flags |= SA_RESTORER;
>>> +                       act.sa_restorer = restore_rt;
>>> +                       act.k_sa_handler = sig_handler;
>>> +#else
>>>                        struct sigaction act, oact;
>>>                        act.sa_handler = sig_handler;
>>> -
>>> +#endif
>>>                        TEST(syscall(__NR_rt_sigaction, SIGALRM, &act, &oact,
>>> 8));
>>>                        if(TEST_RETURN == -1){
>>>                                tst_resm(TFAIL,"rt_sigaction() Failed,
>>> errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
>>> --
>>> 1.6.2.2
>>>
>>>
>>>
>>>
>>>     
>>>       
>>   
>>     
>
>
>   
> ------------------------------------------------------------------------
>
> ------------------------------------------------------------------------------
> Download Intel&#174; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev
> ------------------------------------------------------------------------
>
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>   


--------------080108000306080001050105
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Hi Garrett,<br>
<br>
&nbsp;&nbsp;&nbsp; I figured that this patch has not been merged into ltp-cvs.<br>
&nbsp;&nbsp;&nbsp; Is there some else problems about this patch?<br>
<br>
Thanks,<br>
Liubo<br>
<br>
On 02/23/2010 08:59 AM, liubo wrote:
<blockquote cite="mid:4B832856.3050305@cn.fujitsu.com" type="cite">
  <pre wrap="">Hi, Garrett,
My revised patch has been "Acked/Tested-By: Rishikesh K
Rajak<a class="moz-txt-link-rfc2396E" href="mailto:risrajak@linux.vnet.ibm.com">&lt;risrajak@linux.vnet.ibm.com&gt;</a>"

url: <a class="moz-txt-link-freetext" href="http://marc.info/?l=ltp-list&amp;m=126683033423523&amp;w=2">http://marc.info/?l=ltp-list&amp;m=126683033423523&amp;w=2</a>

Thanks,
Liubo

On 02/23/2010 02:05 AM, Garrett Cooper wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">On Mon, Feb 22, 2010 at 1:08 AM, liubo <a class="moz-txt-link-rfc2396E" href="mailto:liubo2009@cn.fujitsu.com">&lt;liubo2009@cn.fujitsu.com&gt;</a> wrote:
  
    </pre>
    <blockquote type="cite">
      <pre wrap="">On 02/22/2010 03:56 PM, Garrett Cooper wrote:

By and large this diff looks really good. My comments...

On Sun, Feb 21, 2010 at 9:21 PM, liubo <a class="moz-txt-link-rfc2396E" href="mailto:liubo2009@cn.fujitsu.com">&lt;liubo2009@cn.fujitsu.com&gt;</a> wrote:


- rt_sigaction01
On arch x86_64, if we directly get to call syscall
rt_sigaction, there will be "segment fault".
1) One reason is that we must supply the flag of
"SA_RESTORER" and the correct pointer to the fuction
"restorer", according to the kernel code.
2) The other reason is that default syscall rt_sigaction
use kernel "sigaction" structure, which is different
with normal "sigaction" structure.

So,
1) We manage to find the address of the function
"restorer" by using glibc function "sigaction",
which might be something tricky. Then we add these
arguments to make test run correctly.
2) We also use kernel "sigaction" structure to fit
realtime syscall __NR_rt_sigaction.

- rt_sigprocmask01
First, there exsits the same problem as rt_sigaction01.
Second, this testcase uses a unchanged signal number 33,
which may diff among different archs and lead to error
"unknown signal".

So, we use a macro TEST_SIG which refers to SIGRTMIN
to replace 33.


The problem is that SIGRTMIN is actually signal 32, not signal 33, and
here's a problematic comment to ponder over (from bits/signum.h):

/* These are the hard limits of the kernel.  These values should not be
   used directly at user level.  */
#define __SIGRTMIN      32
#define __SIGRTMAX      (_NSIG - 1)

I think the proper resolution would be to make the value SIGRTMIN+1.



Hi, Garrett,

In fact, I'm confused about whether #33 signal is particularly needed here,
in some of my boxes, SIGRTMIN actually refers #34 signal, that is,
#33 is unreachable.

IMO, any realtime reachable signal can be used to pass the case here, and
I pick SIGRTMIN by define a macro: #define TEST_SIG SIGRTMIN.

Of course, the value "SIGRTMIN+1" also pass the case, so I'll pick your
value.

If you are free, looking forward to your explaination ...
    
      </pre>
    </blockquote>
    <pre wrap="">Several signals between the non-RT and non-reserved RT signals are
used by [the now defunct] linuxthreads and nptl. See the following
page which refers to a very old school copy of LTP :]...:

<a class="moz-txt-link-freetext" href="http://www.redhat.com/archives/phil-list/2003-April/msg00049.html">http://www.redhat.com/archives/phil-list/2003-April/msg00049.html</a>

  
    </pre>
  </blockquote>
  <pre wrap=""><!---->
ok , got it.
  </pre>
  <blockquote type="cite">
    <blockquote type="cite">
      <pre wrap="">- rt_sigsuspend01
There exists the same problem as rt_sigaction01.

This patch fixed these failure.

Signed-off-by: Liu Bo <a class="moz-txt-link-rfc2396E" href="mailto:liubo2009@cn.fujitsu.com">&lt;liubo2009@cn.fujitsu.com&gt;</a>

---
 include/rt_signal.h                                |   60
++++++++++++++++++
 .../kernel/syscalls/rt_sigaction/rt_sigaction01.c  |   64
+++++++++++--------
 .../syscalls/rt_sigprocmask/rt_sigprocmask01.c     |   32 +++++++---
 .../syscalls/rt_sigsuspend/rt_sigsuspend01.c       |   13 ++++-
 4 files changed, 132 insertions(+), 37 deletions(-)
 create mode 100644 include/rt_signal.h

diff --git a/include/rt_signal.h b/include/rt_signal.h
new file mode 100644
index 0000000..ea1e7e3
--- /dev/null
+++ b/include/rt_signal.h
@@ -0,0 +1,60 @@
+/******************************************************************************/
+/*
   */
+/* Copyright (c) 2009 FUJITSU LIMITED
  */
+/*
   */
+/* This program is free software;  you can redistribute it and/or modify
   */
+/* it under the terms of the GNU General Public License as published by
  */
+/* the Free Software Foundation; either version 2 of the License, or
   */
+/* (at your option) any later version.
   */
+/*
   */
+/* This program is distributed in the hope that it will be useful,
   */
+/* but WITHOUT ANY WARRANTY;  without even the implied warranty of
   */
+/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
   */
+/* the GNU General Public License for more details.
  */
+/*
   */
+/* You should have received a copy of the GNU General Public License
   */
+/* along with this program;  if not, write to the Free Software
  */
+/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
   */
+/*
   */
+/* Author: Liu Bo <a class="moz-txt-link-rfc2396E" href="mailto:liubo2009@cn.fujitsu.com">&lt;liubo2009@cn.fujitsu.com&gt;</a>
   */
+/*
   */
+/******************************************************************************/
+
+#ifndef __LTP_SIGNAL_H
+#define __LTP_SIGNAL_H
+
+/* We do not globally define the SA_RESTORER flag so do it here.  */
+#define HAVE_SA_RESTORER
+#define SA_RESTORER 0x04000000
+
+struct kernel_sigaction {
+       __sighandler_t k_sa_handler;
+       unsigned long sa_flags;
+       void (*sa_restorer) (void);
+       sigset_t sa_mask;
+};
+
+void (*restore_rt) (void);
+
+void
+handler_h(void)
+{
+       return;
+}
+
+/* initial restore_rt for x86_64 */
+void
+sig_initial(int sig)
+{
+       struct sigaction act, oact;
+
+       act.sa_handler = (void *)handler_h;
+       sigemptyset(&amp;act.sa_mask);
+       sigaddset(&amp;act.sa_mask, sig);
+       /* copy act.sa_restorer to kernel */
+       sigaction(sig, &amp;act, &amp;oact);
+       /* copy oact.sa_restorer from kernel */
+       sigaction(sig, &amp;act, &amp;oact);
+       restore_rt = oact.sa_restorer;
+}
+#endif
diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
index ffc5fa2..d30f204 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
@@ -55,6 +55,10 @@
 #include "usctest.h"
 #include "linux_syscall_numbers.h"

+#ifdef __x86_64__
+#include "rt_signal.h"
+#endif
+
 /*
 * For all but __mips__:
 *
@@ -101,13 +105,14 @@ int  TST_TOTAL = 1;                   /* total number
of tests in this file.   *
 /*              On success - Exits calling tst_exit(). With '0' return
code.  */
 /*
   */
 /******************************************************************************/
-extern void cleanup() {
-        /* Remove tmp dir and all files in it */
-        TEST_CLEANUP;
-        tst_rmdir();
+extern void cleanup()
+{
+       /* Remove tmp dir and all files in it */
+       TEST_CLEANUP;
+       tst_rmdir();

-        /* Exit with appropriate return code. */
-        tst_exit();
+       /* Exit with appropriate return code. */
+       tst_exit();
 }

 /* Local  Functions */
@@ -128,11 +133,12 @@ extern void cleanup() {
 /*              On success - returns 0.
  */
 /*
   */
 /******************************************************************************/
-void setup() {
-        /* Capture signals if any */
-        /* Create temporary directories */
-        TEST_PAUSE;
-        tst_tmpdir();
+void setup()
+{
+       /* Capture signals if any */
+       /* Create temporary directories */
+       TEST_PAUSE;
+       tst_tmpdir();
 }

 int test_flags[] = {SA_RESETHAND|SA_SIGINFO, SA_RESETHAND,
SA_RESETHAND|SA_SIGINFO, SA_RESETHAND|SA_SIGINFO, SA_NOMASK};
@@ -144,22 +150,23 @@ handler(int sig)
        tst_resm(TINFO,"Signal Handler Called with signal number %d\n",sig);
        return;
 }
-
 int
-set_handler(int sig, int sig_to_mask, int mask_flags)
+set_handler(int sig, int mask_flags)
 {
-        struct sigaction sa, oldaction;
-
-                sa.sa_sigaction = (void *)handler;
-                sa.sa_flags = mask_flags;
-                sigemptyset(&amp;sa.sa_mask);
-                sigaddset(&amp;sa.sa_mask, sig_to_mask);
-                TEST(syscall(__NR_rt_sigaction,sig, &amp;sa,
&amp;oldaction,SIGSETSIZE));
-        if (TEST_RETURN == 0) {
-                return 0;
-        } else {
-                        return TEST_RETURN;
-        }
+#ifdef __x86_64__
+       struct kernel_sigaction sa, oldaction;
+       mask_flags |= SA_RESTORER;
+       sa.sa_restorer = restore_rt;
+       sa.k_sa_handler = (void *)handler;
+#else
+       struct sigaction sa, oldaction;
+       sa.sa_handler = (void *)handler;
+#endif
+       sa.sa_flags = mask_flags;
+       sigemptyset(&amp;sa.sa_mask);
+       sigaddset(&amp;sa.sa_mask, sig);
+       TEST(syscall(__NR_rt_sigaction,sig, &amp;sa, &amp;oldaction,SIGSETSIZE));
+       return TEST_RETURN;
 }


@@ -182,8 +189,11 @@ int main(int ac, char **av) {
                for (testno = 0; testno &lt; TST_TOTAL; ++testno) {

                       for (signal = SIGRTMIN; signal &lt;= (SIGRTMAX );
signal++){//signal for 34 to 65
-                               for(flag=0; flag&lt;5;flag++) {
-                                        TEST(set_handler(signal, 0,
test_flags[flag]));
+#ifdef __x86_64__
+                               sig_initial(signal);
+#endif
+                               for(flag=0; flag&lt;5;flag++) {
+                                        TEST(set_handler(signal,
test_flags[flag]));


I know this isn't your code change, but since you're here.. a better
way to do this would be:

sizeof (test_flags) / sizeof (test_flags[0])

as this is a fixed array buffer.


Sure, this can increase codes's portability.

I'm generating a new version patch.
    
      </pre>
    </blockquote>
    <pre wrap="">The less we have to modify code in the future, the better... Cheers!

  
    </pre>
    <blockquote type="cite">
      <pre wrap="">                                                if (TEST_RETURN == 0) {
                                               tst_resm(TINFO,"signal: %d ",
signal);
                                               tst_resm(TPASS, "rt_sigaction
call succeeded: result = %ld ",TEST_RETURN );
diff --git a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
index 6398a28..8bcdc78 100644
--- a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
+++ b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
@@ -62,6 +62,12 @@
 #include "usctest.h"
 #include "linux_syscall_numbers.h"

+#ifdef __x86_64__
+#include "rt_signal.h"
+#endif
+
+#define TEST_SIG SIGRTMIN
+
 /* Extern Global Variables */
 extern int Tst_count;           /* counter for tst_xxx routines.         */
 extern char *TESTDIR;           /* temporary dir created by tst_tmpdir() */
@@ -131,7 +137,16 @@ void sig_handler(int sig)
 }

 int main(int ac, char **av) {
-       struct sigaction act, oact;
+#ifdef __x86_64__
+       struct kernel_sigaction act, oact;
+       sig_initial(TEST_SIG);
+       act.sa_flags |= SA_RESTORER;
+        act.sa_restorer = restore_rt;
+        act.k_sa_handler = sig_handler;
+#else
+        struct sigaction act, oact;
+        act.sa_handler = sig_handler;
+#endif
        sigset_t set, oset;
        int lc;                 /* loop counter */
        char *msg;              /* message returned from parse_opts */
@@ -154,22 +169,21 @@ int main(int ac, char **av) {
                               cleanup();
                               tst_exit();
                       }
-                       TEST(sigaddset(&amp;set, 33));
+                       TEST(sigaddset(&amp;set, TEST_SIG));
                       if(TEST_RETURN == -1){
                               tst_resm(TFAIL,"Call to sigaddset() Failed,
errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
                               cleanup();
                               tst_exit();
                       }
-
+
                       /* call rt_sigaction() */
-                       act.sa_handler = sig_handler;
-                        TEST(syscall(__NR_rt_sigaction, 33, &amp;act, &amp;oact,
8));
+                        TEST(syscall(__NR_rt_sigaction, TEST_SIG, &amp;act,
&amp;oact, 8));
                       if(TEST_RETURN != 0){
                               tst_resm(TFAIL,"Call to rt_sigaction()
Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
                               cleanup();
                               tst_exit();
                       }
-                       /* call rt_sigprocmask() to block signal#33 */
+                       /* call rt_sigprocmask() to block signal#SIGRTMIN */
                        TEST(syscall(__NR_rt_sigprocmask, SIG_BLOCK, &amp;set,
&amp;oset, 8));
                       if(TEST_RETURN == -1){
                               tst_resm(TFAIL,"Call to rt_sigprocmask()****
Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
@@ -178,7 +192,7 @@ int main(int ac, char **av) {
                       }

                       else {
-                               TEST(kill(getpid(), 33));
+                               TEST(kill(getpid(), TEST_SIG));
                               if(TEST_RETURN != 0){
                                       tst_resm(TFAIL,"Call to kill()
Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
                                       cleanup();
@@ -198,13 +212,13 @@ int main(int ac, char **av) {
                                               cleanup();
                                               tst_exit();
                                       }
-                                       TEST(sigismember(&amp;oset, 33));
+                                       TEST(sigismember(&amp;oset, TEST_SIG));
                                       if(TEST_RETURN == 0 ){
                                               tst_resm(TFAIL,"call
sigismember() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
                                               cleanup();
                                               tst_exit();
                                       }
-                                       /* call rt_sigprocmask() to unblock
signal#33 */
+                                       /* call rt_sigprocmask() to unblock
signal#SIGRTMIN */
                                       TEST(syscall(__NR_rt_sigprocmask,
SIG_UNBLOCK, &amp;set, &amp;oset, 8));
                                       if(TEST_RETURN == -1){
                                               tst_resm(TFAIL,"Call to
rt_sigprocmask() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
diff --git a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
index 416a7c9..84f2967 100644
--- a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
+++ b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
@@ -47,6 +47,10 @@
 #include "usctest.h"
 #include "linux_syscall_numbers.h"

+#ifdef __x86_64__
+#include "rt_signal.h"
+#endif
+
 /* Extern Global Variables */
 extern int Tst_count;           /* counter for tst_xxx routines.         */
 extern char *TESTDIR;           /* temporary dir created by tst_tmpdir() */
@@ -139,9 +143,16 @@ int main(int ac, char **av) {
                               cleanup();
                               tst_exit();
                       }
+#ifdef __x86_64__
+                       struct kernel_sigaction act, oact;
+                       sig_initial(SIGALRM);
+                       act.sa_flags |= SA_RESTORER;
+                       act.sa_restorer = restore_rt;
+                       act.k_sa_handler = sig_handler;
+#else
                       struct sigaction act, oact;
                       act.sa_handler = sig_handler;
-
+#endif
                       TEST(syscall(__NR_rt_sigaction, SIGALRM, &amp;act, &amp;oact,
8));
                       if(TEST_RETURN == -1){
                               tst_resm(TFAIL,"rt_sigaction() Failed,
errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
--
1.6.2.2




    
      </pre>
    </blockquote>
    <pre wrap="">
  
    </pre>
  </blockquote>
  <pre wrap=""><!---->

  </pre>
  <pre wrap="">
<hr size="4" width="90%">
------------------------------------------------------------------------------
Download Intel&amp;#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
<a class="moz-txt-link-freetext" href="http://p.sf.net/sfu/intel-sw-dev">http://p.sf.net/sfu/intel-sw-dev</a></pre>
  <pre wrap="">
<hr size="4" width="90%">
_______________________________________________
Ltp-list mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/ltp-list">https://lists.sourceforge.net/lists/listinfo/ltp-list</a>
  </pre>
</blockquote>
<br>
</body>
</html>

--------------080108000306080001050105--


--===============4879227151614856371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--===============4879227151614856371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4879227151614856371==--

