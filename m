From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 20 Jan 2020 13:28:15 +0100
Subject: [LTP] [PATCH 2/3] tst_device.h: Use lapi/syscalls.h instead of
 <sys/syscall.h>
In-Reply-To: <558281761.2778139.1579517819187.JavaMail.zimbra@redhat.com>
References: <20200117113715.22786-1-pvorel@suse.cz>
 <20200117113715.22786-3-pvorel@suse.cz>
 <20200120103108.GA15405@dell5510>
 <558281761.2778139.1579517819187.JavaMail.zimbra@redhat.com>
Message-ID: <20200120122814.GA21132@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Example of the error is #634 [1], which is caused by __NR_socketcall being -1
> > instead of not defined (socketcall is not defined on some archs, e.g. x86-64
> > and ARM).
> > We can fix the condition
> 
> Tests using tst_syscall or ltp_syscall should be fine, since those check
> for ENOSYS.
> 
> >, but it will lead to numerous not obvious errors, so
> > I
> > suggest to revert this (and thus get LTP broken on very old distros).
> > 
> 
> Cyril, any thoughts?

I would say that doing #ifdef __NR_* in test source to disable it is
wrong to begin with.

Doing 'git grep ifdef __NR' shows only socketcall, set_robust_list and
timerfd tests.

The timerfd tests include lapi/syscalls.h already and uses ltp_syscall()
so that shouldn't break. I guess we can safely remove the ifdef there as
well.

The set_robust_list includes the old test.h so thi change to
tst_device.h should not affect it either.

So as far as I can tell the only thing that breaks are the socketcall
tests and I guess that the actual fix would be using tst_syscall()
instead of syscall() and we can remove the ifdefs as well.

-- 
Cyril Hrubis
chrubis@suse.cz
