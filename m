From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 20 Jul 2021 11:40:36 +0200
Subject: [LTP] [PATCH] stime: Only o32 system calls require 32-bit
 programs on mips
In-Reply-To: <045e5fc2-05a7-e006-3bb6-2f536c5634b4@uniontech.com>
References: <20210720063852.1883-1-zhanglianjie@uniontech.com>
 <YPaBnxlp2SsxCaPE@pevik>
 <045e5fc2-05a7-e006-3bb6-2f536c5634b4@uniontech.com>
Message-ID: <YPaaFAdTO9coCUxN@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi zhanglianjie,

[ Cc Thomas Bogendoerfer, MIPS kernel maintainer ]

> On 2021-07-20 15:56, Petr Vorel wrote:
> > Hi zhanglianjie,

> > > The stime() system call is only o32, not n32 and n64. If you do not
> > > specify that the current program is compiled to 32-bit when compiling
> > > the program on mips, the stime() system call will fail when the
> > > program is running.
> > You're right that stime() is only on o32. But tst_syscall() should catch that.
> > Or does it set different errno than ENOSYS?

> The returned errno is EFAULT. The o32 system call of stime is implemented on
> mips, so ENOSYS will not be returned.
I see.

> COMPAT_SYSCALL_DEFINE1(stime, compat_time_t __user *, tptr)
> {
>     ...
>     if (get_user(tv.tv_sec, tptr))
>         return -EFAULT;
>     ...
> }

> The tptr address is in the user space 0x120010da0, and after the system
> call, it is 0x20010da0 in the kernel state, and the upper 32 bits are set to
> 0, resulting in a failure to copy data from the user space to the kernel
> space.
Thanks for explanation.

> This patch needs to be modified and cannot affect other architectures.
Yes, o2 has to fixed, but agree that this would affect other archs which
supports __NR_stime, i.e. i386 now also complains:
stime_var.h:31: TCONF: the stime() syscall only o32 ABI in mips, make sure the current program is 32-bit

but it should stay:
stime02.c:37: TPASS: stime(2) fails, Caller not root: EPERM (1)

> > ...
> > > +#if defined(__mips__) && _MIPS_SZLONG == 32
Not sure if this would work to whitelist only mips n32 and n64 (keep mips o32
and all other archs):
#if ! defined(_MIPS_SZLONG) || _MIPS_SZLONG == 32

Kind regards,
Petr

> > >   		return tst_syscall(__NR_stime, ntime);
> > > +#else
> > > +		tst_brk(TCONF, "the stime() syscall only o32 ABI in mips, make sure the current program is 32-bit");
> > > +#endif
