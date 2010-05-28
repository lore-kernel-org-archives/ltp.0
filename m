Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OIQhE-0005J1-Cd
	for ltp-list@lists.sourceforge.net; Sat, 29 May 2010 18:23:44 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OIQhC-0002rk-08
	for ltp-list@lists.sourceforge.net; Sat, 29 May 2010 18:23:44 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e34.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o4TIFvwW004663
	for <ltp-list@lists.sourceforge.net>; Sat, 29 May 2010 12:15:57 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4TINaRX102370
	for <ltp-list@lists.sourceforge.net>; Sat, 29 May 2010 12:23:36 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o4TINZxA028835
	for <ltp-list@lists.sourceforge.net>; Sat, 29 May 2010 12:23:35 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4BFE530A.10709@in.ibm.com>
References: <4BFE530A.10709@in.ibm.com>
Date: Fri, 28 May 2010 13:02:17 +0530
Message-Id: <1275031948.5418.24.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [RFC] Timer related syscalls for LTP test
Reply-To: subrata@linux.vnet.ibm.com
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
To: Suzuki Poulose <suzuki@in.ibm.com>
Cc: Linus Test Project <ltp-list@lists.sourceforge.net>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, iranna.ankad@in.ibm.com

On Thu, 2010-05-27 at 16:40 +0530, Suzuki Poulose wrote: 
> Hi,
> 
> I have found a problem with the timer related syscall tests.
> 
> The following syscall tests, uses the direct syscall interface to the 
> kernel for testing the interface, instead of using the GLIBC interface.
> 
> testcases/kernel/syscalls
> 	\_ timer_getoverrun/
> 	\_ timer_gettime/
> 
> testcases/kernel/timers
> 	\_ timer_create/
> 	\_ timer_delete/
> 	\_ timer_settime/
> 
> So they use :
> 	syscall(__NR_timer_XXXX, args )
> for directly using the kernel syscall interface than using the
> 
> 	timer_xxxxx(args)
> 
> provided by the GLIBC. This is completely fine.
> 
> But however there is a mismatch in the "timer_t" type defined by the 
> Linux kernel and the GNU Libc.
> 
> Linux kernel defines it as an int for all architectures.
> 
> include/linux/types.h :
> 
> typedef __kernel_timer_t timer_t;
> 
> arch/powerpc/include/asm/posix_types.h :
> typedef int __kernel_timer_t;
> 
> 
> Now, the glibc provides a wrapper to the timer related system calls. 
> While providing the wrapper, Glibc stores some internal data associated 
> with the timer. So it defines the "timer_t" as a pointer (void*) as below:
> 
> /usr/include/time.h :
> 
> /* Timer ID returned by `timer_create'.  */
> typedef __timer_t timer_t;
> 
> 
> in /usr/include/bits/types.h :
> 
> /* Timer ID returned by `timer_create'.  */
> __STD_TYPE __TIMER_T_TYPE __timer_t;
> 
> in /usr/include/bits/typesizes.h
> 
> #define __TIMER_T_TYPE          void *
> 
> 
> So that leads to the definiton of timer_t as void* by glibc. And this 
> cannot be changed. But the glibc uses the "proper" typed argument for 
> the syscalls it issues by defining a kernel_timer_t.
> 
> On 32bit machines the difference is not noticed, since both the timer_t 
> in userspace and the kernel space are of the same size. But on 64bit 
> machines this is different.
> 
> Userspace has a width of 64bit and the kernel has 32bit width. Now, when 
> we pass the pointer to timer_t to the kernel, things get complicated and 
> on Big endian machines, ppc64, s390x, this leads to a problem. As the 
> value kept is not available when we try to dereference it as a 32bit and 
> this leads to undesired results like below:
> 
> timer_getoverrun01    1  TFAIL  :  Block 1: test 0 FAILED... errno = 22 
> :Invalid argument
> 
> 
> strace shows :
> 
> 
> 13017 timer_create(CLOCK_REALTIME, {(nil), SIGALRM, SIGEV_SIGNAL, 
> {...}},{0x26e80}) = 0
> 13017 fstat(1, {st_dev=makedev(0, 11), st_ino=3, st_mode=S_IFCHR|0620,
> st_nlink=1, st_uid=0, st_gid=5, st_blksize=1024, st_blocks=0, 
> st_rdev=makedev(136, 0), 
> st_atime=2010/05/17-15:48:40,st_mtime=2010/05/17-15:48:40, 
> st_ctime=2010/05/17-13:15:48}) = 0
> 13017 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 
> -1, 0)= 0x20000028000
> 13017 write(1, "timer_getoverrun01    0  TINFO  "..., 66) = 66
> 13017 timer_getoverrun(0x26e80)         = -1 EINVAL (Invalid argument)
> 
> 
> So the conclusion is that, if we are using the System calls directly, we 
> should use the argument which is compatible with the kernel. We simply 
> *cannot* use the glibc definition and the kernel API directly.
> 
> I have a patch attached below that fixes this issue.

Thanks Suzie.

> 
> One more comment regarding the placement of timer_gettime and 
> timer_getoverrun syscall tests. I strongly believe they could be moved 
> to testcases/kernel/timers/ directory where the rest of the timer 
> related syscall tests are placed. If that change is made, we can use the 
> definition added in common_timers.h (in the patch) for those tests too, 
> instead of defining in each of the tests.

Sure, you can move them accordingly in the next patch :-)

Regards--
Subrata

> 
> 
> Thanks
> 
> Suzuki
> 
> 
> 
> 
> 
> 
> 
> 
> ------------------------------------------------------------------------------
> 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
